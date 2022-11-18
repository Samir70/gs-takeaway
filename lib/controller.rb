class Controller
  def initialize(shop, interface)
    @shop = shop
    @interface = interface
    @customer_order
  end

  def get_shop_name
    return @shop.shop_name
  end

  def start_order(order)
    @customer_order = order
    ask_user_to_pick_menu
  end

  private

  def ask_user_to_pick_menu
    menu_types = @shop.list_menu_types
    chosen_menu = @interface.get_user_choice(
      "Choose a menu (1-#{menu_types.length})", menu_types
    )
    ask_user_to_pick_item(@shop.menus[chosen_menu - 1]) if chosen_menu
  end

  def ask_user_to_pick_item(menu)
    items = menu.list_items
    chosen_item = @interface.get_user_choice(
      "Choose an item (1-#{items.length})", items.map(&:formatted)
    )
    ask_user_how_many(items[chosen_item - 1]) if chosen_item
  end

  def ask_user_how_many(item)
    quantity = @interface.get_quantity(item)
    if quantity
        @customer_order.add_items(item, quantity)
        @interface.show_order(@customer_order)
        next_step = @interface.get_next_step
        if next_step == 2
          ask_user_to_pick_menu
        end
    end
  end
end
