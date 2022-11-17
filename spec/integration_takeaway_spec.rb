require "takeaway"
require "menu"
require "menu_item"

RSpec.describe "integration at level of takeaway" do
  before(:each) do
    @quarks = Takeaway.new("Quark's bar and grill")
    @quarks_drinks = Menu.new("Drinks")
    @quarks_starters = Menu.new("Starters")
    @quarks.add(@quarks_drinks)
    @quarks.add(@quarks_starters)
  end
  it "lists the types of its menus" do
    expect(@quarks.list_menu_types).to eq ["Drinks", "Starters"]
  end
  it "lists the items on one of its menus" do
    drink_1 = MenuItem.new("Bajoran Ale", 1.50)
    drink_2 = MenuItem.new("Bloodwine", 3.75)
    drink_3 = MenuItem.new("Saurian Brandy", 2.60)
    @quarks_drinks.add(drink_1)
    @quarks_drinks.add(drink_2)
    @quarks_drinks.add(drink_3)
    expect(@quarks.list_menu_items(@quarks_drinks)).to eq [drink_1, drink_2, drink_3]
  end
end
