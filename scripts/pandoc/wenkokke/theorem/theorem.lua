---Support amsthm-style theorems.
---
---@module theorem
---@author Wen Kokke
---@license MIT
---@copyright Wen Kokke 2023
-- Uses `pandoc.Blocks`, which was added in Pandoc 2.17.
PANDOC_VERSION:must_be_at_least '2.17'

-- Import the logging module:
-- local logging = require 'logging'

-- Constants for the possible values of proof-section-location.
local LOCATION_INPLACE = 'inplace'
local LOCATION_OMITTED = 'omitted'

-- Configuration for filter. Can be overwritten by metadata.
local theorem = {
    -- Use restatable environment from `thm-restate`.
    restatable = nil,
    -- Specify the location for omitted proofs.
    --
    -- Possible values are:
    -- * inplace  -- in-place (default).
    -- * omitted  -- at the next omitted-proofs block.
    -- These be specified either all-at-once...
    --
    --  ```yaml
    --  location: "omitted"
    --  ```
    --
    -- ...or separately for by using proof tags, e.g., the following
    -- specifies the tags @summary and @omitted to keep the proof in-place
    -- and move it to the proof section, respectively...
    --
    --  ```yaml
    --  location:
    --    summary: "inplace"
    --    omitted: "omitted"
    --    default: "inplace"
    --  ```
    location = nil,

    -- The theorem styles.
    styles = {
        Assumption = {
            classes = {'assumption'},
            counter = 1,
            environment = 'assumption'
        },
        Claim = {
            classes = {'claim'},
            counter = 1,
            environment = 'claim'
        },
        Conjecture = {
            classes = {'conjecture'},
            counter = 1,
            environment = 'conjecture'
        },
        Corollary = {
            classes = {'corollary'},
            counter = 1,
            environment = 'corollary'
        },
        Counterexample = {
            classes = {'counterexample'},
            counter = 1,
            environment = 'counterexample'
        },
        Convention = {
            classes = {'convention'},
            counter = 1,
            environment = 'convention'
        },
        Definition = {
            classes = {'definition'},
            counter = 1,
            environment = 'definition'
        },
        Example = {
            classes = {'example'},
            counter = 1,
            environment = 'example'
        },
        Lemma = {
            classes = {'lemma'},
            counter = 1,
            environment = 'lemma'
        },
        Proof = {
            classes = {'proof'},
            counter = nil,
            environment = 'proof'
        },
        Proposition = {
            classes = {'proposition'},
            counter = 1,
            environment = 'proposition'
        },
        Remark = {
            classes = {'remark'},
            counter = 1,
            environment = 'remark'
        },
        Theorem = {
            classes = {'theorem'},
            counter = 1,
            environment = 'theorem'
        }
    }
}

-- Cache for information tracked at runtime.
local theorem_cache = {
    -- String that tracks the previous statement's identifier.
    previous_identifier = "unknown",

    -- Table of cross-reference targets.
    targets = {},

    -- Table of rendered statements by identifier.
    statements = {},

    -- List of rendered proofs that have not yet been inserted.
    proofs = {}
}

--- Get the proof section location.
local function get_location(tag)
    if type(theorem) == 'table' then
        if type(theorem.location) == 'string' then
            return theorem.location
        elseif type(theorem.location) == 'table' then
            if tag ~= nil then
                assert(type(tag) == 'string')
                if theorem.location[tag] ~= nil then
                    return theorem.location[tag]
                else
                    local msg_fmt = "proof location for tag '%s' is not defined"
                    error(string.format(msg_fmt, tag))
                end
            elseif theorem.location.default ~= nil then
                return theorem.location.default
            end
        end
    end
    return LOCATION_INPLACE
end

--- Get the list of allowed proof tags.
local function get_location_tag_allowlist()
    if theorem_cache.location_tag_allowlist ~= nil then
        return theorem_cache.location_tag_allowlist
    end
    if type(theorem) == 'table' then
        if type(theorem.location) == 'table' then
            local tag_allowlist = pandoc.List({})
            for tag, _ in pairs(theorem.location) do
                if tag ~= 'default' then
                    table.insert(tag_allowlist, tag)
                end
            end
            theorem_cache.location_tag_allowlist = tag_allowlist
            return tag_allowlist
        end
    end
    return {}
end

--- Get the proof section location.
local function get_proof_section_location()
    local location_tag_allowlist = get_location_tag_allowlist()
    table.insert(location_tag_allowlist, 'default')
    local location_list = pandoc.List({})
    for _, tag in pairs(location_tag_allowlist) do
        local location = get_location(tag)
        if location ~= LOCATION_INPLACE then
            if not location_list:includes(location) then
                table.insert(location_list, location)
            end
        end
    end
    if #location_list > 1 then
        local msg_fmt = "proof location: at most one of ['inplace', 'omitted'] supported, found: [%s]\n"
        io.stderr:write(string.format(msg_fmt, table.concat(location_list, ", ")))
    elseif #location_list == 1 then
        return location_list[1]
    else
        return LOCATION_INPLACE
    end
end

--- Test whether or not theorems should be restatable.
local function get_restatable()
    if theorem.restatable then
        return true
    else
        local proof_section_location = get_proof_section_location()
        if proof_section_location == LOCATION_INPLACE then
            return false
        else
            if theorem.restatable == false then
                local msg_fmt = "The value '%s' for proof-section location requries restatable"
                io.stderr:write('WARNING: ' .. string.format(msg_fmt, proof_section_location) .. "\n")
            end
            return true
        end
    end
end

--------------------------------------------------------------------------------
-- The lexer for theorem headers.
--------------------------------------------------------------------------------

-- Lexer action that sets the theorem style.
local function set_theorem_style(info, value)
    if type(value) == "string" then
        if theorem.styles[value] ~= nil then
            info.style = {
                name = value
            }
            for key, value in pairs(theorem.styles[value]) do
                info.style[key] = value
            end
        else
            local msg_fmt = "ERROR: Unsupported theorem style '%s'\n"
            io.stderr:write(string.format(msg_fmt, value))
        end
    end
end

-- Lexer action that sets a custom counter.
local function set_custom_counter(result, value)
    result.custom_counter = value
end

-- Lexer action that adds the theorem name.
local function add_theorem_name(result, value)
    if result.theorem_name == nil then
        result.theorem_name = {}
    end
    if type(value) == "string" then
        if value ~= "" then
            table.insert(result.theorem_name, pandoc.Str(value))
        end
    else
        table.insert(result.theorem_name, value)
    end
end

-- Lexer action that adds a theorem identifier.
local function add_theorem_identifier(result, value)
    if result.theorem_identifier == nil then
        result.theorem_identifier = {}
    end
    if type(value) == "string" then
        if value ~= "" then
            table.insert(result.theorem_identifier, pandoc.Str(value))
        end
    else
        table.insert(result.theorem_identifier, value)
    end
end

-- Lexer action that adds miscellaneous text.
local function add_miscellaneous(result, value)
    if result.miscellaneous == nil then
        result.miscellaneous = {}
    end
    if type(value) == "string" then
        if value ~= "" then
            table.insert(result.miscellaneous, pandoc.Str(value))
        end
    else
        table.insert(result.miscellaneous, value)
    end
end

local theorem_header_lexer = {
    if_Str = {{
        match = "(%a+)",
        input_states = {"start"},
        output_state = "after_kw",
        action = set_theorem_style
    }, {
        match = "([%d%.]*%d)",
        input_states = {"after_kw"},
        output_state = "after_num",
        action = set_custom_counter
    }, {
        match = "%(([^)]*)",
        input_states = {"after_kw", "after_num"},
        output_state = "after_lpar",
        action = add_theorem_name
    }, {
        match = "([^)]*)%)",
        input_states = {"after_lpar"},
        output_state = "after_rpar",
        action = add_theorem_name
    }, {
        match = "%{#([^}]*)",
        input_states = {"after_kw", "after_num", "after_rpar"},
        output_state = "after_lbrace",
        action = add_theorem_identifier
    }, {
        match = "([^}]*)%}",
        input_states = {"after_lbrace"},
        output_state = "after_rbrace",
        action = add_theorem_identifier
    }, {
        match = "%.(.*)",
        input_states = {"after_kw", "after_num", "after_rpar", "after_rbrace"},
        output_state = "after_dot",
        action = add_miscellaneous
    }},
    otherwise = {
        after_lpar = add_theorem_name,
        after_dot = add_miscellaneous
    },
    start_state = "start",
    final_states = {"after_dot"}
}

---Run a lexer on a list of Pandoc elements.
---
---@param lexer table
---@param els table
---@return table
local function run_lexer(lexer, els)
    local result = {}
    local state = lexer.start_state
    local index = 0
    local el = nil
    ::next::
    index = index + 1
    el = els[index]
    ::continue::
    if el == nil then
        -- We have reached the end of the input:
        if pandoc.List.includes(lexer.final_states, state) then
            return result
        else
            local msg_fmt = "ERROR: Lexer ended in non-final state '%s'\n"
            io.stderr:write(string.format(msg_fmt, state))
        end
    elseif el ~= nil and el.tag == 'Str' then
        -- Try every lexer rule, in order:
        for _, rule in pairs(lexer.if_Str) do
            if pandoc.List.includes(rule.input_states, state) then
                local value, rest = el.text:match("^" .. rule.match .. "(.*)$")
                if value ~= nil then
                    state = rule.output_state
                    rule.action(result, value)
                    if rest == nil or rest == "" then
                        goto next
                    else
                        el = pandoc.Str(rest)
                        goto continue
                    end
                end
            end
        end
    end
    if lexer.otherwise[state] ~= nil then
        -- Try the default action:
        lexer.otherwise[state](result, el)
        goto next
    end
    if el ~= nil and el.tag == 'Space' then
        -- Skip any spaces that don't have a default action:
        goto next
    end
    -- Throw a lexical error:
    local msg_fmt = "ERROR: Lexical error at token '%s' in state '%s'\n"
    io.stderr:write(string.format(msg_fmt, el, state))
end

---Render the identifier for a theorem.
---
---@param theorem_info table
---@return string
local function render_theorem_identifier(theorem_info)
    local theorem_identifier = nil
    if theorem_info.theorem_identifier ~= nil then
        theorem_identifier = pandoc.utils.stringify(pandoc.Inlines(theorem_info.theorem_identifier))
    elseif theorem_info.theorem_name ~= nil then
        theorem_identifier = pandoc.utils.stringify(pandoc.Inlines(theorem_info.theorem_name))
    elseif theorem_info.custom_counter ~= nil then
        theorem_identifier = theorem_info.custom_counter
    elseif theorem_info.style.counter ~= nil then
        theorem_identifier = tostring(theorem_info.style.counter)
    else
        theorem_identifier = "for-" .. theorem_info.previous_identifier
    end
    -- Sanitize identifier (replace non-alphanumeric characters with dashes)
    theorem_identifier = string.gsub(theorem_identifier, "%W", "-")
    -- Add the theorem style name as a prefix
    theorem_identifier = string.lower(string.format("%s:%s", theorem_info.style.name, theorem_identifier))
    return theorem_identifier
end

local function lex_proof_tag(item)
    if item[1] ~= nil and (item[1].tag == 'Plain' or item[1].tag == 'Para') then
        if item[1].content[1].tag == 'Cite' then
            local tag_allowlist = get_location_tag_allowlist()
            if #item[1].content[1].citations == 1 then
                local tag = item[1].content[1].citations[1]
                if tag_allowlist:includes(tag.id) and tag.mode == 'AuthorInText' and #tag.prefix == 0 and #tag.suffix ==
                    0 then
                    table.remove(item[1].content, 1)
                    while (item[1].content[1].tag == 'Space') do
                        table.remove(item[1].content, 1)
                    end
                    return tag.id
                end
            end
        else
            return 'default'
        end
    end
end

-- Lex a definition list item body containing a theorem body.
---
---@param body table
---@return table
local function lex_definition_list_definition_item(body)
    -- assert(#body == 1, "Unexpected number of elements '" .. #body .. "'")
    local result = {}
    for _, item in pairs(body) do
        local tag = lex_proof_tag(item)
        local location = get_location(tag)
        result[location] = item
    end
    return result
end

-- Lex a definition list item containing a theorem.
---
---@param head table
---@param body table
---@return table
local function lex_definition_list_definition(head, body)
    local success, theorem_info = pcall(function()
        return run_lexer(theorem_header_lexer, head)
    end)
    if success then
        if theorem_info.style.name == "Proof" then
            theorem_info.body = lex_definition_list_definition_item(body)
        else
            theorem_info.body = body[1]
        end
        if theorem_info.custom_counter == nil then
            local theorem_style = theorem.styles[theorem_info.style.name]
            if theorem_style.counter ~= nil then
                theorem_style.counter = theorem_style.counter + 1
            end
        end
        -- Render the theorem identifier
        theorem_info.previous_identifier = theorem_cache.previous_identifier
        theorem_info.identifier = render_theorem_identifier(theorem_info)
        -- Update the global previous theorem identifier
        theorem_cache.previous_identifier = theorem_info.identifier
        return theorem_info
    else
        local msg_fmt = "WARNING: Could not lex theorem '%s'\n"
        io.stderr:write(string.format(msg_fmt, tostring(theorem_info)))
        return nil
    end
end

-- Lex a definition list containing only theorems.
---
---@param head table
---@param body table
---@return table
local function lex_definition_list(el)
    if el ~= nil and el.tag == 'DefinitionList' then
        assert(el.content ~= nil)
        local result_list = pandoc.List({})
        for index = 1, #el.content do
            local success, result_or_error = pcall(lex_definition_list_definition, table.unpack(el.content[index]))
            if success then
                result_list:insert(result_or_error)
            else
                -- If result_list is non-empty, throw an error:
                if index > 1 then
                    local msg_fmt = "ERROR: item %s in definition list is not a theorem: %s\n"
                    io.stderr:write(string.format(msg_fmt, index, result_or_error))
                else
                    return nil
                end
            end
        end
        if #result_list > 0 then
            return result_list
        end
    end
    return nil
end

--------------------------------------------------------------------------------
-- The renderer for theorems.
--------------------------------------------------------------------------------

---Render a theorem as a Pandoc element.
---
---@param theorem_info table
---@return table
local function render_theorem_other(theorem_info)
    -- Render theorem
    local strong = pandoc.Inlines({})
    strong:insert(pandoc.Str(theorem_info.style.name))
    -- Render counter
    if theorem_info.custom_counter ~= nil then
        strong:insert(pandoc.Space())
        strong:insert(pandoc.Str(theorem_info.custom_counter))
    elseif theorem_info.style.counter ~= nil then
        strong:insert(pandoc.Space())
        strong:insert(pandoc.Str(string.format("%d", theorem_info.style.counter)))
    end
    -- Render header
    local header = pandoc.Inlines({})
    header:insert(pandoc.Strong(strong))
    if theorem_info.theorem_name ~= nil then
        header:insert(pandoc.Space())
        header:insert(pandoc.Str('('))
        header:extend(theorem_info.theorem_name)
        header:insert(pandoc.Str(')'))
    end
    header:insert(pandoc.Str('.'))
    if theorem_info.miscellaneous ~= nil then
        header:insert(pandoc.Emph(theorem_info.miscellaneous))
    end
    -- Render theorem statement
    if theorem_info.style.name == "Proof" then
        theorem_info.statement = {}
        for location, body in pairs(theorem_info.body) do
            local content = pandoc.Blocks({})
            content:insert(pandoc.Para(header))
            content:extend(body)
            local statement = pandoc.Blocks({})
            statement:insert(pandoc.Div(content, pandoc.Attr(theorem_info.identifier, theorem_info.style.classes)))
            theorem_info.statement[location] = statement
        end
    else
        local content = pandoc.Blocks({})
        content:insert(pandoc.Para(header))
        content:extend(theorem_info.body)
        local statement = pandoc.Blocks({})
        statement:insert(pandoc.Div(content, pandoc.Attr(theorem_info.identifier, theorem_info.style.classes)))
        theorem_info.statement = statement
    end
    -- Render theorem restatement
    if get_restatable() then
        theorem_info.restatement = statement
    end
    return theorem_info
end

---Render a theorem as a Pandoc element for LaTeX.
---
---@param theorem_info table
---@return table
local function render_theorem_latex(theorem_info)
    -- Render theorem
    local header = pandoc.Inlines({})
    local footer = pandoc.Inlines({})
    -- Render header
    header:insert(pandoc.RawInline('latex', '{'))
    -- Set custom counter
    if theorem_info.custom_counter ~= nil then
        header:insert(pandoc.RawInline('latex', string.format('\\renewcommand{\\the%s}{%s}',
            theorem_info.style.environment, theorem_info.custom_counter)))
    end
    if get_restatable() then
        -- Render theorem command
        local theorem_command_name = theorem_info.identifier:gsub("%A", "")
        -- Render theorem statement
        if theorem_info.theorem_name ~= nil then
            assert(type(theorem_info.theorem_name) == "table")
            header:insert(pandoc.RawInline('latex', '\\begin{restatable}['))
            header:extend(theorem_info.theorem_name)
            header:insert(pandoc.RawInline('latex', string.format(']{%s}{%s}', theorem_info.style.environment,
                theorem_command_name)))
        else
            header:insert(pandoc.RawInline('latex', string.format('\\begin{restatable}{%s}{%s}',
                theorem_info.style.environment, theorem_command_name)))
        end
        -- Render theorem restatement
        local raw_latex_command = pandoc.RawInline('latex', string.format('\\%s*', theorem_command_name))
        theorem_info.restatement = pandoc.Blocks({pandoc.Inlines({raw_latex_command})})
    else
        -- Render theorem statement
        if theorem_info.theorem_name ~= nil then
            assert(type(theorem_info.theorem_name) == "table")
            header:insert(pandoc.RawInline('latex', string.format('\\begin{%s}[', theorem_info.style.environment)))
            header:extend(theorem_info.theorem_name)
            header:insert(pandoc.RawInline('latex', ']'))
        else
            header:insert(pandoc.RawInline('latex', string.format('\\begin{%s}', theorem_info.style.environment)))
        end
    end
    -- Add miscellaneous text to header
    if theorem_info.miscellaneous ~= nil then
        assert(type(theorem_info.miscellaneous) == "table")
        header:extend(theorem_info.miscellaneous)
    end
    -- Add LaTeX cross-reference label to header
    header:insert(pandoc.RawInline('latex', string.format('\\label{%s}', theorem_info.identifier)))
    -- Render footer start
    if get_restatable() then
        footer:insert(pandoc.RawInline('latex', '\\end{restatable}'))
    else
        footer:insert(pandoc.RawInline('latex', string.format('\\end{%s}', theorem_info.style.environment)))
    end
    -- Restore custom counter
    if theorem_info.custom_counter ~= nil then
        footer:insert(pandoc.RawInline('latex', string.format('\\addtocounter{%s}{-1}', theorem_info.style.environment)))
    end
    -- Render footer end
    footer:insert(pandoc.RawInline('latex', '}'))
    -- Render theorem statement
    if theorem_info.style.name == "Proof" then
        theorem_info.statement = {}
        for location, body in pairs(theorem_info.body) do
            local statement = pandoc.Blocks({})
            statement:insert(pandoc.Para(header))
            statement:extend(body)
            statement:insert(pandoc.Para(footer))
            theorem_info.statement[location] = statement
        end
    else
        local statement = pandoc.Blocks({})
        statement:insert(pandoc.Para(header))
        statement:extend(theorem_info.body)
        statement:insert(pandoc.Para(footer))
        theorem_info.statement = statement
    end
    return theorem_info
end

--- Register a cross-reference target for theorem.
local function register_theorem_target(theorem_info)
    theorem_cache.targets[theorem_info.identifier] = {
        number = theorem_info.style.counter
    }
end

---Render a theorem.
---
---@param theorem_info table
---@return table
local function render_theorem(theorem_info)
    register_theorem_target(theorem_info)
    if FORMAT:match('latex') then
        return render_theorem_latex(theorem_info)
    else
        return render_theorem_other(theorem_info)
    end
end

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
            if key == 'theorem' then
                table_merge(theorem, value)
            end
        end
    end
}

--------------------------------------------------------------------------------
-- Filter that renders the theorems as Pandoc elements.
--------------------------------------------------------------------------------

local function require_proof_section()
    local proof_section_cache = theorem_cache.proofs
    return #proof_section_cache > 0
end

local function reset_proof_section_cache()
    theorem_cache.proofs = {}
end

local function render_theorems(doc)
    doc = doc:walk({
        CodeBlock = function(el)
            if el.classes:includes("omitted-proofs") then
                if not require_proof_section() then
                    local msg_fmt = "WARNING: empty proof section with identifier '#%s'\n"
                    io.stderr:write(string.format(msg_fmt, el.identifier))
                    return nil
                end
                local output = pandoc.Blocks({})
                for _, restatement_and_proof in pairs(theorem_cache.proofs) do
                    output:extend(restatement_and_proof)
                end
                reset_proof_section_cache()
                return output
            end
        end,
        DefinitionList = function(el)
            local theorem_info_list = lex_definition_list(el)
            if theorem_info_list ~= nil then
                local output = pandoc.Blocks({})
                for theorem_index, theorem_info in pairs(theorem_info_list) do
                    render_theorem(theorem_info)
                    local proof_section_location = get_proof_section_location()
                    --- Determine whether an item is a proof.
                    if theorem_info.style.name ~= "Proof" then
                        -- Statements are rendered in-place
                        output:extend(theorem_info.statement)
                        if proof_section_location ~= LOCATION_INPLACE then
                            -- Add the statement to the restatement cache
                            theorem_cache.statements[theorem_info.identifier] = theorem_info.restatement
                        end
                    else
                        -- Proofs follow the proof-section location
                        if theorem_info.statement[LOCATION_INPLACE] ~= nil then
                            output:extend(theorem_info.statement[LOCATION_INPLACE])
                        end
                        if proof_section_location ~= LOCATION_INPLACE then
                            if theorem_info.statement[proof_section_location] ~= nil then
                                -- Get the corresponding statement from the cache
                                local restatement = theorem_cache.statements[theorem_info.previous_identifier]
                                assert(restatement ~= nil)
                                local restatement_and_proof = pandoc.Blocks({})
                                restatement_and_proof:extend(restatement)
                                restatement_and_proof:extend(theorem_info.statement[proof_section_location])
                                table.insert(theorem_cache.proofs, restatement_and_proof)
                            end
                        end
                    end
                end
                return output
            else
                return nil
            end
        end,
        traversal = "topdown"
    })
    if require_proof_section() then
        io.stderr:write("ERROR: missing proof section\n")
    end
    return doc
end

--------------------------------------------------------------------------------
-- Filter that adds targets for the cross-reference filter.
--------------------------------------------------------------------------------

local save_theorem_targets = {
    Meta = function(meta)
        if meta.crossref == nil then
            meta.crossref = {}
        end
        if meta.crossref.targets == nil then
            meta.crossref.targets = {}
        end
        for identifier, target in pairs(theorem_cache.targets) do
            meta.crossref.targets[identifier] = target
        end
        return meta
    end
}

function Pandoc(doc)
    doc:walk(get_options)
    doc = render_theorems(doc)
    doc = doc:walk(save_theorem_targets)
    return doc
end
