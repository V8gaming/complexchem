---@diagnostic disable
-- Remote interface. replace "cc" with your mod name
remote.add_interface("cc", {
    informatron_menu = function(data)
      return cc_menu(data.player_index)
    end,
    informatron_page_content = function(data)
      return cc_page_content(data.page_name, data.player_index, data.element)
    end
  })
  
  --[[
  If you implement the informatron_menu interface at all then you will have a page in Informatron even if you don't add additional sub-pages to the menu.
  The deafult page has a menu caption of cc.menu_cc and a page title of cc.title_cc.
  If you also add text to the page with the caption "cc.page_cc_text_1" then your mod should add the following to your local .cfg file:
  [cc]
  menu_cc=My Mod Name
  title_cc=My Mod Name
  page_cc_text_1=My descriptive text
  ]]--
  
  function cc_menu(player_index)
    return {
      cat=1,
      dog=1,
      bird={
        penguin = 1,
        corvid = {
          crow=1,
          raven=1,
          jay=1
        },
      }
    }
  end
  --[[
  For the above menu items you should add to your local .cfg file (under [cc]):
  menu_cat=Cat
  title_cat=Cat
  page_cat_text_1=Text about cats.
  menu_dog=Dog
  title_dog=Dog
  page_dog_text_1=Text about dogs.
  menu_bird=Bird
  title_bird=Bird
  page_bird_text_1=Text about birds.
  menu_penguin=Pengiun
  title_penguin=Pengiun
  page_penguin_text_1=Text about pengiuns.
  etc...
  ]]
  
  function cc_page_content(page_name, player_index, element)
    -- main page
    if page_name == "cc" then
      element.add{type="label", name="text_1", caption={"cc.page_cc_text_1"}}
    end
  
    if page_name == "cat" then
      element.add{type="label", name="text_1", caption={"cc.page_cat_text_1"}}
    end
  
    if page_name == "dog" then
      element.add{type="label", name="text_1", caption={"cc.page_dog_text_1"}}
    end
  
    if page_name == "bird" then
      element.add{type="label", name="text_1", caption={"cc.page_bird_text_1"}}
    end
  
    if page_name == "penguin" then
      element.add{type="label", name="text_1", caption={"cc.page_penguin_text_1"}}
      element.add{type="button", name="image_1", style="cc_penguin_image_1"}
      --[[
      To make an image you need to require the Informatron mod (so it loads first) then have some code like this in data.lua
      informatron_make_image("cc_penguin_image_1", "__cc__/graphics/informatron/pengiun.png", 200, 200)
        "cc_penguin_image_1" must be unique per image.
        "__cc__/graphics/informatron/page_1_image.png" is the path to your image.
        200, 200 is the width, height of the image
      ]]--
    end
  
  end