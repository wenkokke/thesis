---Support header case conversion.
---
---@module title_case
---@author Wen Kokke
---@license MIT
---@copyright Wen Kokke 2024
--
-- Possible values for 'title_case' option:
local TITLE_CASE_TITLE = 'title'
local TITLE_CASE_SENTENCE = 'sentence'
--
-- Possible values for 'title_case_style' option:
local TITLE_CASE_STYLE_AP = 'AP'
--
-- Exceptions for each title case style:
local TITLE_CASE_EXCEPTIONS = {
    AP = {'a', 'for', 'so', 'an', 'in', 'the', 'and', 'nor', 'to', 'at', 'of', 'up', 'but', 'on', 'yet', 'by', 'or'},
    -- Exceptions regardless of style
    ['*'] = {'d', 'll', 's', 't'}
}
--
-- Default options:
local title_case = {
    title_case = TITLE_CASE_TITLE,
    title_case_style = TITLE_CASE_STYLE_AP,
    first_word = true
}

--------------------------------------------------------------------------------
-- Filter that converts headers to title case.
--------------------------------------------------------------------------------

local function get_exceptions()
    if title_case.title_case_exceptions == nil then
        local result = pandoc.List(TITLE_CASE_EXCEPTIONS['*'])
        if title_case.title_case == TITLE_CASE_TITLE then
            local title_case_exceptions = TITLE_CASE_EXCEPTIONS[title_case.title_case_style]
            if title_case_exceptions ~= nil then
                result = result .. pandoc.List(title_case_exceptions)
            end
        end
        title_case.title_case_exceptions = result
    end
    return title_case.title_case_exceptions
end

local PATTERN_UNICODE_CHARACTER = "([%z\1-\127\194-\244][\128-\191]*)"
local PATTERN_ALPHA = "[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]"

local function convert_word(word)
    -- If the word is written in all-caps, keep it that way.
    local is_allcaps = word:match("^%u+$")
    if is_allcaps then
        return word
    end
    -- If the word is an exception, according the title style, lowercase it.
    local is_exception = get_exceptions():includes(word:lower())
    if is_exception and not title_case.first_word then
        return word:lower()
    end
    -- Otherwise, capitalise the word.
    return word:sub(1, 1):upper() .. word:sub(2):lower()
end

local convert_Str = {
    Str = function(str)
        local text = ""
        local word = ""
        for char in str.text:gmatch(PATTERN_UNICODE_CHARACTER) do
            local is_alpha = char:match(PATTERN_ALPHA) ~= nil
            if is_alpha then
                word = word .. char
            else
                if word ~= "" then
                    text = text .. convert_word(word)
                    word = ""
                    title_case.first_word = false
                end
                text = text .. char
            end
        end
        if word ~= "" then
            text = text .. convert_word(word)
            word = ""
            title_case.first_word = false
        end
        return pandoc.Str(text)
    end
}

local convert_Header = {
    Header = function(header)
        title_case.first_word = true
        header = pandoc.walk_block(header, convert_Str)
        return header
    end
}
--------------------------------------------------------------------------------
-- Filter that reads the options from the metadata.
--------------------------------------------------------------------------------

--- Extend a table with the values from another table.
---
--- This function mutates its first argument.
---
---@param t1 table
---@param t2 table
---@return table
local function table_merge(t1, t2)
    assert(type(t1) == 'table')
    assert(type(t2) == 'table')
    for key, val in pairs(t2) do
        if type(val) == 'table' then
            if type(t1[key] or nil) == 'table' then
                t1[key] = table_merge(t1[key], val)
            else
                t1[key] = val
            end
        else
            t1[key] = val
        end
    end
    return t1
end

local get_options = {
    Meta = function(el)
        for key, value in pairs(el) do
            if key == 'title_case' then
                table_merge(title_case, value)
            end
        end
    end
}

--------------------------------------------------------------------------------
-- Filter that puts everything together.
--------------------------------------------------------------------------------

function Pandoc(doc)
    doc:walk(get_options)
    doc = doc:walk(convert_Header)
    return doc
end
