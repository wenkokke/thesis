-- Uses `pandoc.template.apply`, which was added in Pandoc 3.0.1.
PANDOC_VERSION:must_be_at_least '3.0.1'

-- The image templates:
local templates = {
    html = [[
        <picture>
            <source srcset="${ src }.tex?as=webp&dppx=1 1x" type="image/webp" />
            <source srcset="${ src }.tex?as=webp&dppx=2 2x" type="image/webp" />
            <source srcset="${ src }.tex?as=webp&dppx=3 3x" type="image/webp" />
            <img
                src="${ src }.tex"
                ${ if(title) }alt="${ title }"${ endif }
                ${ if(identifier) }id="${ identifier }"${ endif }
                ${ if(classes) }class="${ for(classes) }${ classes }${ sep }, ${ endfor }"${ endif }
                ${ if(attributes) }${ for(attributes/pairs) }${ it.key }="${ it.value }"${ sep } ${ endfor }${ endif }
            />
        </picture>
    ]],
    latex = [[
        \input{${ src }}
    ]]
}

local function render(format, context)
    assert(templates[format] ~= nil)
    local template_string = templates[format]:match('^%s*(.*)\n%s*$')
    local template = pandoc.template.compile(template_string)
    local document = pandoc.template.apply(template, context)
    local rendered = pandoc.layout.render(document)
    return pandoc.RawInline(format, rendered)
end

-- Convert each Image node with a .tex source to an \input command:
function Image(image)
    -- Parse the image URL:
    local src, query = image.src:match("(.+)%.tex$")
    if src == nil then
        src, query = image.src:match("(.+)%.tex(%?.+)$")
    end
    -- Render the image in the target format:
    if src ~= nil then
        if FORMAT:match 'latex' then
            return render('latex', {
                src = src,
                query = query
            })
        elseif FORMAT:match 'html' then
            local src_basename = pandoc.path.filename(src)
            local src_directory = pandoc.path.directory(src)
            local context = {
                src = src,
                query = query,
                title = image.title,
                identifier = image.identifier,
                classes = image.classes,
                attributes = nil
            }
            if type(context.classes) == "table" and #context.classes == 0 then
                context.classes = nil
            end
            for key, value in pairs(image.attributes) do
                if context.attributes == nil then
                    context.attributes = {}
                end
                context.attributes[key] = value
            end
            return render('html', context)
        end
    end
end
