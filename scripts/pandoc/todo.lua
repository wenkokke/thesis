---Support TODOs.
---
---@module todo
---@author Wen Kokke
---@license MIT
---@copyright Wen Kokke 2024
local todo = {}

--------------------------------------------------------------------------------
-- Filter that finds and converts block-level TODOs.
--------------------------------------------------------------------------------

local function BlockTodo(block_like_elements)
    if FORMAT:match 'latex' then
        local block_todo_element = pandoc.Blocks({})
        block_todo_element:insert(pandoc.RawBlock("latex", "\\begin{TODO}"))
        block_todo_element:extend(block_like_elements)
        block_todo_element:insert(pandoc.RawBlock("latex", "\\end{TODO}"))
        return pandoc.Div(block_todo_element)
    else
        io.stderr:write("Unsupported format " .. FORMAT .. "\n")
    end
end

local function is_block_todo(div)
    return div ~= nil and div.tag == "Div" and div.classes:includes("TODO")
end

function Div(div)
    if is_block_todo(div) then
        local block_todo_element = BlockTodo(div.content)
        return block_todo_element
    end
end

--------------------------------------------------------------------------------
-- Filter that finds and converts inline-level TODOs.
--------------------------------------------------------------------------------

local function InlineTodo(inline_like_elements)
    -- Warning:
    local warning_inlines = pandoc.Inlines({})
    warning_inlines = warning_inlines .. inline_like_elements
    local warning_doc = pandoc.Pandoc({pandoc.Plain(warning_inlines)})
    local warning_text = pandoc.write(warning_doc, 'plain')
    io.stderr:write("TODO: " .. warning_text .. "\n")
    -- Render inline TODO:
    if FORMAT:match 'latex' then
        local inline_todo_element = pandoc.Inlines({})
        inline_todo_element:insert(pandoc.RawInline("latex", "\\inlineTODO{"))
        for i = 2, #inline_like_elements do
            inline_todo_element:insert(inline_like_elements[i])
        end
        inline_todo_element:insert(pandoc.RawInline("latex", "}"))
        -- inline_todo_element:insert(pandoc.LineBreak())
        return inline_todo_element
    else
        io.stderr:write("Unsupported format " .. FORMAT .. "\n")
    end
end

local function is_inline_todo_init(inline_like_element)
    return inline_like_element ~= nil and inline_like_element.tag == "Str" and inline_like_element.text == "TODO:"
end

local function is_inline_todo_stop(inline_like_element)
    return inline_like_element ~= nil and inline_like_element.tag == "LineBreak"
end

function Inlines(inline_like_elements)
    local result = pandoc.Inlines({})
    local parsing_inline_todo = false
    local inline_todo_content = pandoc.Inlines({})
    for i = 1, #inline_like_elements do
        local inline_like_element = inline_like_elements[i]
        local inline_todo_init = is_inline_todo_init(inline_like_element)
        local inline_todo_stop = is_inline_todo_stop(inline_like_element)
        local end_of_inlines = i == #inline_like_elements
        -- Insert inline_like_element into appropriate sequence
        if not inline_todo_init then
            if parsing_inline_todo and not inline_todo_stop then
                inline_todo_content:insert(inline_like_element)
            elseif not parsing_inline_todo then
                result:insert(inline_like_element)
            end
        end
        -- STATE CHANGE: End parsing an inline TODO element
        if parsing_inline_todo and (inline_todo_init or inline_todo_stop or end_of_inlines) then
            result = result .. InlineTodo(inline_todo_content)
            parsing_inline_todo = false
            inline_todo_content = pandoc.Inlines({})
        end
        -- STATE CHANGE: Begin parsing an inline TODO element
        if not parsing_inline_todo and inline_todo_init then
            parsing_inline_todo = true
        end
    end
    return result
end
