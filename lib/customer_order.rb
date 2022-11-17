class CustomerOrder
    def initialize
        @items = []
        @total_cost = 0
    end
    attr_reader :items, :total_cost

    def add_items(description, cost)
        @items << description
        @total_cost += cost
    end

end