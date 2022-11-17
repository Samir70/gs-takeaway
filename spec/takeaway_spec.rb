require "takeaway"

RSpec.describe Takeaway do
  before(:each) do
    @quarks = Takeaway.new("Quark's bar and grill")
    @quarks_drinks = double(:fake_menu, menu_type: "Drinks")
    quarks_starters = double(:fake_menu, menu_type: "Starters")
    @quarks.add(@quarks_drinks)
    @quarks.add(quarks_starters)
  end
  it "initialises with a name" do
    expect(@quarks.shop_name).to eq "Quark's bar and grill"
  end

  it "lists the types of its menus" do
    expect(@quarks.list_menu_types).to eq ["Drinks", "Starters"]
  end
  it "lists the items on one of its menus" do
    drink_1 = double :fake_menu_item
    drink_2 = double :fake_menu_item
    drink_3 = double :fake_menu_item
    expect(@quarks_drinks).to receive(:list_items).and_return([drink_1, drink_2, drink_3])
    expect(@quarks.list_menu_items(@quarks_drinks)).to eq [drink_1, drink_2, drink_3]
  end
end
