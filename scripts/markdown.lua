---@param text string
local function render_markdown(text)
    local elements = {}

    -- Split the text into lines
    local lines = {}

    for line in text:gmatch("([^\n]*)\n?") do
        lines[#lines+1] = line
    end

    local i = 1
    while i <= #lines do
        local line = lines[i]

        -- Check for headings
        if line:match("^#") then
            local heading_text = line:gsub("^#+%s*", "")
            local heading_level = line:match("^(#+)")
            local heading_style = "cc_h1"
            if heading_level == "#" then
                heading_style = "cc_h1"
            elseif heading_level == "##" then
                heading_style = "cc_h2"
            elseif heading_level == "###" then
                heading_style = "cc_h3"
            elseif heading_level == "####" then
                heading_style = "cc_h4"
            end

            elements[#elements+1] = {
                type = "label",
                caption = heading_text,
                style = heading_style,
            }
            -- Check for horizontal line (hline ---)
        elseif line:match("^%-%-%-+$") then
            elements[#elements+1] = {
                type = "line",
                direction = "horizontal",
                style = "cc_hline"
            }
        -- Check for horizontal line (hline ___)
        elseif line:match("^%_%_%_+$") then
            elements[#elements+1] = {
                type = "line",
                direction = "horizontal",
                style = "cc_hline"
            }
        -- Check for horizontal line (hline ***)
        elseif line:match("^%*%*%*+$") then
            elements[#elements+1] = {
                type = "line",
                direction = "horizontal",
                style = "cc_hline"
            }
        elseif line:find("(?<!\\*)\\*{2}[^%*]+\\*{2}(?!\\*)") then
            local bold_line = line:gsub("%*%*([^%*]+)%*%*", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = bold_line,
                style = "cc_bold",
            }
        elseif line:find("%_%_[^%_]+%_%_") then
            local bold_line = line:gsub("%_%_([^%_]+)%_%_", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = bold_line,
                style = "cc_bold",
            }
        elseif line:find("%*[^%*]+%*") then
            local italic_line = line:gsub("%*([^%*]+)%*", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = italic_line,
                style = "cc_italic",
            }
        elseif line:find("%_[^%_]+%_") then
            local italic_line = line:gsub("%_([^%_]+)%_", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = italic_line,
                style = "cc_italic",
            }
        -- bold italic text (*** or ___)
        elseif line:find("%*%*%*[^%*]+%*%*%*") then
            local bold_italic_line = line:gsub("%*%*%*([^%*]+)%*%*%*", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = bold_italic_line,
                style = "cc_bold_italic",
            }
        elseif line:find("%_%_%_[^%_]+%_%_%_") then
            local bold_italic_line = line:gsub("%_%_%_([^%_]+)%_%_%_", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = bold_italic_line,
                style = "cc_bold_italic",
            }


        -- Check for strikethrough
        elseif line:find("~~[^~\\]*~~") then
            
            local strike_through_text = line:gsub("~~([^~\\]*)~~", "%1")
            elements[#elements+1] = {
                type = "label",
                caption = strike_through_text,
                style = "cc_strike_through",
            }

        -- Check for bullet points (* )
        elseif line:match("^%*%s+") then
            -- replace * with •
            local bullet_text = line:gsub("^%*%s+", "• ")
            elements[#elements+1] = {
                type = "label",
                caption = bullet_text,
                style = "cc_bullet"
            }
        -- Check for bullet points (- )
        elseif line:match("^%-") then
            -- replace - with •
            local bullet_text = line:gsub("^%-", "•")
            elements[#elements+1] = {
                type = "label",
                caption = bullet_text,
                style = "cc_bullet"
            }
        -- Check for tables
        elseif line:match("^|") then
            local rows = {}
            local column_count = 0
            local header_row = true
            local border_row = false

            while i <= #lines and lines[i]:match("^|") do
                local cells = {}
                for cell in lines[i]:gmatch("|([^|]+)") do
                    cells[#cells+1] = cell:gsub("^%s*(.-)%s*$", "%1")
                end
                column_count = math.max(column_count, #cells)
                if cells[1]:match("^%-+$") then
                    border_row = true
                end
                rows[#rows+1] = {cells = cells, header = header_row, border = border_row}
                header_row = false
                border_row = false
                i = i + 1
            end

            elements[#elements+1] = {
                type = "table",
                column_count = column_count,
                rows = rows,
            }
            --print(serpent.block(elements[#elements]))
            i = i - 1
        else
            -- Regular paragraph text
            elements[#elements+1] = {
                type = "label",
                caption = line
            }
        end

        i = i + 1
    end

    return elements
end

--[[
{
  column_count = 2,
  rows = {
    {
      cells = {
        "Header 1",
        "Header 2"
      },
          header = true
    },
    {
      cells = {
        "----------",
        "----------"
      },
      header = false
    },
    {
      cells = {
        "Cell 1",
        "Cell 2"
      },
      header = false
    }
  },
  type = "table"
}
]]

return {
    render = render_markdown
}