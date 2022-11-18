require 'customer_order'

RSpec.describe CustomerOrder do
    it "initialises with an empty item list" do
        order = CustomerOrder.new
        expect(order.items).to eq []
    end
    it "updates items and total cost when customer places order" do
        order = CustomerOrder.new
        item_1 = double :fake_item, name:"Saurian Brandy", cost:2.60
        item_2 = double :fake_item, name:"Egg Sandwich", cost:1.80
        order.add_items(item_1, 5)
        expect(order.items).to eq ["5 x Saurian Brandy @ £2.60each = £13.00"]
        expect(order.total_cost).to eq 13.0
        order.add_items(item_2, 2)
        expect(order.items).to eq ["5 x Saurian Brandy @ £2.60each = £13.00", "2 x Egg Sandwich @ £1.80each = £3.60"]
        expect(order.total_cost).to eq 16.6
    end
end