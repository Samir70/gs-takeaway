class Menu
    def initialize(type)
        @menu_type = type
        @items = []
    end

    def add(item)
        @items << item
    end

    def list_items
        return @items
    end

    attr_reader :menu_type
end