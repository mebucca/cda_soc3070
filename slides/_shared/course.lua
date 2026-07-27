-- Shared Pandoc transformations for SOC3070 presentations.
-- Pandoc handles `. . .` at the slide root, but markers nested in columns or
-- custom divs can survive as literal paragraphs. Convert every marker into a
-- RevealJS fragment boundary before the writer builds the slides.

local function is_pause(block)
  return (block.t == "Para" or block.t == "Plain")
    and pandoc.utils.stringify(block) == ". . ."
end

local function is_slide_boundary(block)
  return block.t == "HorizontalRule"
    or (block.t == "Header" and block.level <= 2)
end

local function Blocks(blocks)
  local output = pandoc.List()
  local group = pandoc.List()
  local fragment = false

  local function flush()
    if #group == 0 then
      return
    end

    if fragment then
      output:insert(pandoc.Div(group, pandoc.Attr("", { "fragment" })))
    else
      output:extend(group)
    end
    group = pandoc.List()
  end

  for _, block in ipairs(blocks) do
    if is_pause(block) then
      flush()
      fragment = true
    elseif is_slide_boundary(block) then
      -- A fragment never crosses into the next Reveal slide. Without this
      -- reset, a later heading can be nested inside the previous fragment and
      -- Pandoc no longer recognizes it as a slide boundary.
      flush()
      fragment = false
      output:insert(block)
    else
      group:insert(block)
    end
  end

  flush()
  return output
end

-- Slide-type backgrounds. Colours live in _shared/course.css: cover/closing use
-- the active theme's primary colour, section dividers (.inverse) use its
-- secondary colour. Content slides are untouched.
--
-- IMPORTANT: RevealJS reads `data-background-color` off the slide <section>
-- and paints its own separate `.slide-background` layer with that value
-- directly as an inline style (see reveal.js's `createBackground`/
-- `syncSlidePageSize`) -- it does NOT keep it around as a copyable HTML
-- attribute. A CSS rule keyed on `[data-background-color="..."]` therefore
-- only ever colours the `<section>` itself (a box no bigger than its actual
-- content, e.g. the centred title), never the full-bleed slide background.
-- So we cannot emit a placeholder/sentinel colour here and remap it in CSS --
-- we must resolve the real hex value for the active theme right here, at
-- filter time, and hand RevealJS that value directly.
local FALLBACK_TEAM = "barcelona"

local function read_file(path)
  local f = io.open(path, "r")
  if not f then
    return nil
  end
  local content = f:read("a")
  f:close()
  return content
end

-- Pull --course-primary / --course-secondary for `body.theme-<team>` out of
-- course.css. Mirrors the equivalent regex-based lookup in
-- _shared/bikeshare.R's `course_palette()` -- course.css stays the single
-- source of truth for every palette, in both R and RevealJS.
local function theme_colors(team)
  local css = read_file("../_shared/course.css")
  if not css then
    return nil, nil
  end

  local selector_team = team:gsub("[%-]", "%%-")
  local block = css:match("body%.theme%-" .. selector_team .. "%s*{([^}]*)}")
  if not block then
    return nil, nil
  end

  local primary = block:match("%-%-course%-primary%s*:%s*(#%x%x%x%x%x%x)")
  local secondary = block:match("%-%-course%-secondary%s*:%s*(#%x%x%x%x%x%x)")
  return primary, secondary
end

local function has_class(el, name)
  for _, c in ipairs(el.classes) do
    if c == name then
      return true
    end
  end
  return false
end

-- Resolved once from document metadata, then reused by every Header.
local primary_bg = nil
local secondary_bg = nil

local function ResolveTheme(m)
  local team = FALLBACK_TEAM
  -- NOTE: `body-classes` is a quarto-reserved metadata key -- quarto consumes
  -- it to set the real `<body class="...">` and strips it from the metadata
  -- map before Lua filters run, so it is never visible here (confirmed by
  -- instrumenting this filter: `m["body-classes"]` is always nil). `course-team`
  -- is a plain, non-reserved key that survives untouched, so it is the only
  -- reliable way to tell this filter which palette is active.
  local course_team = m["course-team"] and pandoc.utils.stringify(m["course-team"])
  if course_team then
    team = course_team:gsub("_", "-")
  end

  local primary, secondary = theme_colors(team)
  if not primary or not secondary then
    primary, secondary = theme_colors(FALLBACK_TEAM)
  end

  primary_bg = primary
  secondary_bg = secondary

  if primary_bg and m["title-slide-attributes"] == nil then
    m["title-slide-attributes"] = pandoc.MetaMap({
      ["data-background-color"] = pandoc.MetaString(primary_bg)
    })
  end

  return m
end

local function TagHeader(el)
  if has_class(el, "closing") and primary_bg then
    el.attributes["background-color"] = primary_bg
  elseif has_class(el, "inverse") and secondary_bg then
    el.attributes["background-color"] = secondary_bg
  end
  return el
end

-- Returned as an ordered list so the metadata pass (which resolves the active
-- theme's real colours) always completes before the Header pass that needs
-- them -- a single combined filter table does not guarantee that ordering.
return {
  { Meta = ResolveTheme },
  { Blocks = Blocks, Header = TagHeader },
}
