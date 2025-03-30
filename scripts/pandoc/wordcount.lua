-- Count the number of words in a document.
local wordcount = {
    value = 0,
    max = 80000
}

local function load(meta)
    if meta['wordcount-target'] ~= nil then
        wordcount.max = tonumber(pandoc.utils.stringify(meta['wordcount-target']))
    end
end

local function save(meta)
    wordcount.percent = 100 * (wordcount.value / wordcount.max)
    if meta.wordcount == nil then
        meta.wordcount = wordcount
    else
        meta.wordcount.value = string.format("%d", wordcount.value)
        meta.wordcount.max = string.format("%d", wordcount.max)
        meta.wordcount.percent = string.format("%.2f", wordcount.percent)
    end
    return meta
end

function Pandoc(doc)
    -- Load wordcount.max:
    doc:walk({
        Meta = load
    })
    -- Count words in document body:
    pandoc.walk_block(pandoc.Div(doc.blocks), {
        Str = function(el)
            if el.text:match("%P") then
                wordcount.value = wordcount.value + 1
            end
        end,
        Code = function(el)
            local _, n = el.text:gsub("%S+", "")
            wordcount.value = wordcount.value + n
        end,
        CodeBlock = function(el)
            local _, n = el.text:gsub("%S+", "")
            wordcount.value = wordcount.value + n
        end
    })
    -- Save wordcount.value and wordcount.percent:
    return doc:walk({
        Meta = save
    })
end
