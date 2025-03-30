---Support embedded PDFs.
---
---@module embed_pdf
---@author Wen Kokke
---@license MIT
---@copyright Wen Kokke 2023
local embed_pdf = {}

-- Uses `pandoc.template.apply`, which was added in Pandoc 3.0.1.
PANDOC_VERSION:must_be_at_least '3.0.1'

-- The PDF embed templates.
local embed_pdf_templates = {
    html = [[
        <object
            type="application/pdf"
            data="${ src }"
            ${ if(attr) }
            ${ for(attr) }
            ${ it.key }="${ it.value }"
            ${ endfor }
            ${ endif }
            >
            <p>
                Your browser does not support PDF objects.
                <a href="${ src }">Click here to view the PDF.</a>
            </p>
        </object>
    ]],
    latex = [[
        \includepdf[${ for(includepdf) }${ it.key }=${ it.value },${ endfor }]{${ src }}
    ]]
}

-- Get a list of the supported formats.
local function get_supported_formats()
    local supported_formats = {}
    for format, template_string in pairs(embed_pdf_templates) do
        supported_formats:insert(format)
    end
    return supported_formats
end

-- Get the target format.
local function get_target_format()
    if FORMAT:match('latex') then
        return 'latex'
    elseif FORMAT:match('html') then
        return 'html'
    else
        local supported_formats = get_supported_formats():concat(', ')
        error('Unsupported format ' .. FORMAT .. ', expected one of ' .. supported_formats .. '\n')
    end
end

-- Check whether the argument is a list with one element.
local function is_singleton_list(els)
    return els ~= nil and #els == 1 and els[1] ~= nil
end

-- Check whether or not an Image element is a PDF embed.
local function is_pdf_embed(el)
    return el ~= nil and el.tag == 'Image' and el.src ~= nil and el.src:match("%.pdf$")
end

-- Get the options for a specific output format.
local function get_format_opts(el)
    local format = get_target_format()
    local opts = pandoc.List()
    if el.attr ~= nil and el.attr.attributes ~= nil then
        for key, value in pairs(el.attr.attributes) do
            if key:match('^' .. format .. ':') then
                key = key:sub(#format + #':' + 1)
                -- Check if key contains further qualifiers
                local key_col_ix = key:find(':')
                if key_col_ix ~= nil then
                    -- If the key contains a further qualifier,
                    -- insert a flag with that qualifier.
                    local parent_key = key:sub(1, key_col_ix - 1)
                    key = key:sub(key_col_ix + 1)
                    if opts[parent_key] == nil then
                        opts[parent_key] = pandoc.List()
                    end
                    opts[parent_key]:insert({
                        key = key,
                        value = value
                    })
                else
                    -- Otherwise, simply insert the value.
                    opts[key] = value
                end
            end
        end
    end
    return opts
end

-- Render a PDF embed.
local function render_pdf_embed(el, block)
    local format = get_target_format()
    assert(embed_pdf_templates[format] ~= nil)
    local template_string = embed_pdf_templates[format]:match('^%s*(.*)\n%s*$')
    local template = pandoc.template.compile(template_string)
    local context = get_format_opts(el)
    context.src = el.src
    local document = pandoc.template.apply(template, context)
    local rendered = pandoc.layout.render(document)
    if block == true then
        return pandoc.RawBlock(format, rendered)
    else
        return pandoc.RawInline(format, rendered)
    end
end

function Image(el)
    if is_pdf_embed(el) then
        return render_pdf_embed(el)
    else
        return el
    end
end

-- Specialised function to render standalone images as block elements.
function Para(el)
    if is_singleton_list(el.content) then
        local image = el.content[1]
        if is_pdf_embed(image) then
            return render_pdf_embed(image, true)
        end
    end
    return nil
end

-- This ensures that the specialised Para function fires before the general Image function.
-- Requires: Pandoc > 2.17
traverse = 'topdown'
