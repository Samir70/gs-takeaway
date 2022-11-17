class Controller
    def initialize(shop, interface)
        @shop = shop
        @interface = interface
    end
    
    def get_shop_name
        return @shop.shop_name
    end
end