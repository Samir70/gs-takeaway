class Takeaway
    def initialize(name)
        @shop_name = name
        @menus = []
    end

    def add(menu)
        @menus << menu
    end

    def list_menu_types
        return @menus.map(&:menu_type)
    end

    def list_menu_items(menu)
        return menu.list_items
    end

    attr_reader :shop_name, :menus
end