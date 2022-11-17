require "menu_item"

RSpec.describe MenuItem do
  it "initialises with name and cost" do
    drink_1 = MenuItem.new("Bajoran Ale", 1.50)
    expect(drink_1.name).to eq "Bajoran Ale"
    expect(drink_1.cost).to eq 1.50
  end

  it "formats its contents" do
    drink_1 = MenuItem.new("Bajoran Ale", 1.50)
    expect(drink_1.formatted).to eq "Bajoran Ale (£1.50)"
  end
end
