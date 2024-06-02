--control.lua
script.on_init(function()
    local freeplay = remote.interfaces["freeplay"]
    if freeplay then  -- Disable freeplay popup-message
        if freeplay["set_skip_intro"] then remote.call("freeplay", "set_skip_intro", true) end
        if freeplay["set_disable_crashsite"] then remote.call("freeplay", "set_disable_crashsite", true) end
    end

end)
local markdown = require("./scripts/markdown")

script.on_event(defines.events.on_player_created, function(event)
    local player = game.get_player(event.player_index)

    if player == nil then
        return
    end
    -- Example usage
    local text = [[
# Heading 1
## Heading 2
### Heading 3
#### Heading 4
*This is a italic.*
_This is also italic text._
**This is bold text.**
__This is also bold text.__
~~This is strike through text.~~
* This should be a bullet point
- This should also be a bullet point
***This should be bold italic text.***
___This should be bold italic text.___

---

___

***
| Header 1 | Header 2 | Header 3 |
|----------|----------|----------|
| Cell 1   | Cell 2   | Cell 3   |
]]
    local gui_elements = markdown.render(text)

    -- Create a GUI frame and add the rendered elements to it
    local screen_element = player.gui.screen
    local frame = screen_element.add({
        type = "frame",
        name="cc.markdown_renderer",
        caption = {"cc.markdown_renderer"},   
    })
    frame.style.minimal_height = 400
    frame.style.minimal_width = 385
    frame.style.vertically_stretchable = true
    frame.auto_center = true

    local content_frame = frame.add{type="frame", name="content_frame", direction="vertical", style="cc_content_frame"}
    for _, element in ipairs(gui_elements) do
        if element.type == "table" then
            local table_element = content_frame.add{type = "table", column_count = element.column_count, style = "cc_table"}
            table_element.draw_horizontal_lines = true
            table_element.draw_vertical_lines = true
            table_element.draw_horizontal_line_after_headers = true
            for _, row in ipairs(element.rows) do
                for _, cell_value in ipairs(row.cells) do
                    
                    if row.border then
                        -- search for alignment (:-, -:, :-:)
                        local alignment = cell_value:match("^:?%-+")
                        if alignment then
                            local alignment_style = "left"
                            if alignment:sub(-1) == ":" then
                                alignment_style = "right"
                            end
                            table_element.style.horizontal_align = alignment_style
                        else
                            table_element.style.horizontal_align = "center"
                        end
                    else
                        
                        if row.header then
                            table_element.add{type = "label", caption = cell_value, style = "cc_h1"}
                        else
    
                            table_element.add{type = "label", caption = cell_value}
                            
                        end
                    end                 
                end
            end
        else
            content_frame.add(element)
        end
    end
end)