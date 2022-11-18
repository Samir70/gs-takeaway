class CustomerOrder
    def initialize
        @items = []
        @total_cost = 0
    end
    attr_reader :items, :total_cost

    def add_items(item, quantity)
        cost = quantity * item.cost
        description = "#{quantity} x #{item.name} @ £#{'%.2f' % item.cost}each = £#{'%.2f' % cost}"
        @items << description
        @total_cost += cost
    end

end