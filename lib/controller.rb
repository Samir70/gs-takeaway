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
    options = @shop.list_menu_types
    @interface.get_user_choice(
      "Choose a menu (1-#{options.length})", options
    )
  end
end
