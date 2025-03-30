---Fix typesetting of "i.e.", "e.g.", "etc", etc.
---
---@module foreign
---@author Wen Kokke
---@license MIT
---@copyright Wen Kokke 2023
local foreign = {}

local function word_boundary_at_start(text)
    return text == nil or text == '' or string.match(text, '^%A')
end

local function word_boundary_at_end(text)
    return text == nil or text == '' or string.match(text, '%A$')
end

local function find_and_replace(str)
    if str.t == 'Str' then
        -- e.g.
        local prefix, match, suffix = string.match(str.text, '(.*)(e%.g%.)(.*)')
        if match ~= nil then
            local result = pandoc.Inlines({})
            if prefix ~= nil and prefix ~= '' then
                result:insert(pandoc.Str(prefix))
            end
            result:insert(pandoc.RawInline('latex', '\\eg'))
            if suffix ~= nil and suffix ~= '' and suffix ~= ',' then
                result:insert(pandoc.Str(suffix))
            end
            return result
        end
        -- i.e.
        local prefix, match, suffix = string.match(str.text, '(.*)(i%.e%.)(.*)')
        if match ~= nil then
            local result = pandoc.Inlines({})
            if prefix ~= nil and prefix ~= '' then
                result:insert(pandoc.Str(prefix))
            end
            result:insert(pandoc.RawInline('latex', '\\ie'))
            if suffix ~= nil and suffix ~= '' and suffix ~= ',' then
                result:insert(pandoc.Str(suffix))
            end
            return result
        end
        -- etc
        local prefix, match, suffix = string.match(str.text, '(.*)(etc)(.*)')
        if word_boundary_at_end(prefix) and match ~= nil and word_boundary_at_start(suffix) then
            local result = pandoc.Inlines({})
            if prefix ~= nil and prefix ~= '' then
                result:insert(pandoc.Str(prefix))
            end
            result:insert(pandoc.RawInline('latex', '\\etc'))
            if suffix ~= nil and suffix ~= '' then
                result:insert(pandoc.Str(suffix))
            end
            return result
        end
    end
end

function Pandoc(doc)
    if FORMAT:match('latex') then
        doc = doc:walk({
            Str = find_and_replace
        })
        return doc
    end
end
