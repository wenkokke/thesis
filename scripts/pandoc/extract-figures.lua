local path = pandoc.path
local sha1 = pandoc.utils.sha1
local stringify = pandoc.utils.stringify
local system = pandoc.system

local options = {
    cache_directory = path.join({system.get_working_directory(), ".pandoc-cache", "extract-figures"}),
    project_root = system.get_working_directory()
}

local function get_options(meta)
    if meta['cache-dir'] ~= nil then
        options.cache_directory = stringify(meta['cache-dir'])
    end
    if meta['project-root'] ~= nil then
        options.project_root = stringify(meta['project-root'])
    end
end

local function extract_math(math)
    -- Render the contents for the math file:
    local math_contents = nil
    if math.mathtype == "InlineMath" then
        math_contents = "$" .. math.text .. "$"
    else
        math_contents = "$\\displaystyle\n" .. math.text .. "\n$"
    end
    -- Render the name for the math file:
    local math_path = path.join({path.normalize(options.cache_directory), sha1(math.text) .. ".tex"})
    -- Write the math file:
    system.make_directory(options.cache_directory, true)
    local math_file = io.open(math_path, 'w')
    math_file:write(math_contents)
    math_file:close()
    -- Return an Image:
    return pandoc.Image(math.text, path.make_relative(math_path, options.project_root), math.text, {
        class = math.mathtype,
        ['data-tex'] = math.text
    })
end

function Pandoc(doc)
    if FORMAT:match 'html' or FORMAT:match 'native' then
        doc:walk({
            Meta = get_options
        })
        return doc:walk({
            Math = extract_math
        })
    end
end
