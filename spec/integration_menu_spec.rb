require "menu"
require "menu_item"

RSpec.describe "integration at level of Menu" do
  it "can add MenuItems" do
    quarks_drinks = Menu.new("Drinks")
    drink_1 = MenuItem.new("Bajoran Ale", 1.50)
    drink_2 = MenuItem.new("Bloodwine", 3.75)
    drink_3 = MenuItem.new("Saurian Brandy", 2.60)
    quarks_drinks.add(drink_1)
    quarks_drinks.add(drink_2)
    quarks_drinks.add(drink_3)
    expect(quarks_drinks.list_items).to eq [drink_1, drink_2, drink_3]
  end
end
