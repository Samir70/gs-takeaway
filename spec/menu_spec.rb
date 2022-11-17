require "menu"

RSpec.describe Menu do
  context "initialises" do
    it "with an empty item list" do
      menu = Menu.new("Drinks")
      expect(menu.list_items).to eq []
    end
    it "reports its type" do
      menu = Menu.new("Drinks")
      expect(menu.menu_type).to eq "Drinks"
    end
  end

  it "can add multiple meals" do
    quarks_drinks = Menu.new("Drinks")
    drink_1 = double :fake_menu_item 
    drink_2 = double :fake_menu_item 
    drink_3 = double :fake_menu_item 
    quarks_drinks.add(drink_1)
    quarks_drinks.add(drink_2)
    quarks_drinks.add(drink_3)
    expect(quarks_drinks.list_items).to eq [drink_1, drink_2, drink_3]
  end
end
