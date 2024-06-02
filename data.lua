--data.lua

-- These are some style prototypes that the tutorial uses
-- You don't need to understand how these work to follow along
local styles = data.raw["gui-style"].default

styles["cc_content_frame"] = {
    type = "frame_style",
    parent = "inside_shallow_frame_with_padding",
    vertically_stretchable = "on"
}

styles["cc_controls_flow"] = {
    type = "horizontal_flow_style",
    vertical_align = "center",
    horizontal_spacing = 16
}

styles["cc_controls_textfield"] = {
    type = "textbox_style",
    width = 36
}


styles["cc_deep_frame"] = {
    type = "frame_style",
    parent = "slot_button_deep_frame",
    vertically_stretchable = "on",
    horizontally_stretchable = "on",
    top_margin = 16,
    left_margin = 8,
    right_margin = 8,
    bottom_margin = 4
}

--markdown styles
styles["cc_h1"] = {
    type = "label_style",
    font = "heading-1"
}
styles["cc_h2"] = {
    type = "label_style",
    font = "heading-2"
}
styles["cc_h3"] = {
    type = "label_style",
    font = "heading-3"
}
styles["cc_h4"] = {
    type = "label_style",
    font = "heading-4"
}

styles["cc_hline"] = {
    type = "line_style",
    vertically_stretchable = "on",
    height = 2,

}

styles["cc_italic"] = {
    type = "label_style",
    parent = "label",
    font_color = {r = 1, g = 1, b = 1},
    font = "cc_italic_font"
}

styles["cc_bold_italic"] = {
    type = "label_style",
    parent = "label",
    font_color = {r = 1, g = 1, b = 1},
    font = "cc_bold_italic_font"
}

styles["cc_bold"] = {
    type = "label_style",
    parent = "label",
    font_color = {r = 1, g = 1, b = 1},
    font = "default-bold"
}

styles["cc_strike_through"] = {
    type = "label_style",
    parent = "label",
    font_color = {r = 1, g = 1, b = 1},
    strikethrough = true,
    strikethrough_color = {r = 1, g = 1, b = 1}

}
styles["cc_bullet"] = {
    type = "label_style",
    parent = "label",
    font_color = {r = 1, g = 1, b = 1},
    left_margin = 16
}


styles["cc_table_row"] = {
    type = "table_style",
    parent = "table",
    cell_padding = 4,
    horizontal_spacing = 0,
    vertical_spacing = 0
}

styles["cc_table"] = {
    type = "table_style",
    parent = "table",
    cell_padding = 4,
    horizontal_spacing = 0,
    vertical_spacing = 0,
    horizontal_line_color = {r = 1, g = 1, b = 1},
    vertical_line_color = {r = 1, g = 1, b = 1},
}
data:extend({
    {
        type = "custom-input",
        name = "cc_toggle_interface",
        key_sequence = "CONTROL + I",
        order = "a"
    },
    {
        type = "font",
        name = "cc_italic_font",
        from = "cc-italic",
        size = 12,
    },
    {
        type = "font",
        name = "cc_bold_italic_font",
        from = "cc-bold-italic",
        size = 12,

    },
    {
        type = "font",
        name = "heading-4",
        from = "default-bold",
        size = 11 -- will translate 4 modules (ceil(11 * 1.4 / 4))
      },
})