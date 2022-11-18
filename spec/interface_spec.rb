require "interface"

RSpec.describe Interface do
  before(:each) do
    @terminal = double :fake_terminal
    @interface = Interface.new(@terminal)
  end
  context "#get_user_choice(message, options)" do
    before(:each) do
      expect(@terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
      expect(@terminal).to receive(:puts).with("[1] Drinks").ordered
      expect(@terminal).to receive(:puts).with("[2] Starters").ordered
      expect(@terminal).to receive(:puts).with("[3] Main Meals").ordered
    end
    it "displays the message and options" do
      expect(@terminal).to receive(:puts).with("[4] Desserts").ordered
      allow(@terminal).to receive(:gets).and_return("4")
      @interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"])
    end
    it "receives a response from user" do
      expect(@terminal).to receive(:puts).with("[4] Desserts").ordered
      expect(@terminal).to receive(:gets).and_return("4").ordered
      expect(@interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"])).to eq 4
      expect(@interface.response).to eq 4
    end
    it "raises an error if response is 0" do
      expect(@terminal).to receive(:puts).with("[4] Desserts").ordered
      expect(@terminal).to receive(:gets).and_return("0").ordered
      expect { @interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"]) }.to raise_error "ERROR:: user picked an invalid valid option. Should be a number 1..4"
    end
    it "raises an error if response is larger than number of options" do
      expect(@terminal).to receive(:gets).and_return("4").ordered
      expect { @interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals"]) }.to raise_error "ERROR:: user picked an invalid valid option. Should be a number 1..3"
    end
  end

  context "#get_quantity" do
    it "asks user for how much of an item" do
      item = double :fake_item, name: "Saurian Brandy", cost: 2.6
      expect(@terminal).to receive(:puts).with("How many Saurian Brandys?")
      expect(@terminal).to receive(:gets).and_return("5")
      @interface.get_quantity(item)
    end
    it "accepts positive response" do
      item = double :fake_item, name: "Saurian Brandy", cost: 2.6
      expect(@terminal).to receive(:puts).with("How many Saurian Brandys?")
      expect(@terminal).to receive(:gets).and_return("5")
      @interface.get_quantity(item)
    end
    it "raises error for non-positive response" do
      item = double :fake_item, name: "Saurian Brandy", cost: 2.6
      expect(@terminal).to receive(:puts).with("How many Saurian Brandys?")
      expect(@terminal).to receive(:gets).and_return("0")
      expect { @interface.get_quantity(item) }.to raise_error "ERROR:: you can't buy that many!!!"
    end
  end
  it "shows an order" do
    order = double :fake_order, total_cost: 16.60, items: ["5 x Saurian Brandy @ £2.60each = £13.00", "2 x Egg Sandwich @ £1.80each = £3.60"]
    expect(@terminal).to receive(:puts).with("Your current order:").ordered
    expect(@terminal).to receive(:puts).with("5 x Saurian Brandy @ £2.60each = £13.00").ordered
    expect(@terminal).to receive(:puts).with("2 x Egg Sandwich @ £1.80each = £3.60").ordered
    expect(@terminal).to receive(:puts).with("Total value is £16.60").ordered
    @interface.show_order(order)
  end
  context "#get_next_step" do
    it "asks for next step" do
      expect(@terminal).to receive(:puts).with("Please select:").ordered
      expect(@terminal).to receive(:puts).with("[1] place order").ordered
      expect(@terminal).to receive(:puts).with("[2] add another item").ordered
      allow(@terminal).to receive(:gets).and_return("1")
      @interface.get_next_step
    end
    it "returns 2 if user selects '2'" do
      expect(@terminal).to receive(:puts).exactly(3).times.ordered
      expect(@terminal).to receive(:gets).and_return("2")
      expect(@interface.get_next_step).to eq 2
    end
    it "returns 1 if user selects '1'" do
      expect(@terminal).to receive(:puts).exactly(3).times.ordered
      expect(@terminal).to receive(:gets).and_return("1")
      expect(@interface.get_next_step).to eq 1
    end
    it "repeats request if choice not '1' or '2'" do
      expect(@terminal).to receive(:puts).exactly(3).times.ordered
      expect(@terminal).to receive(:gets).and_return("x").ordered
      expect(@terminal).to receive(:puts).exactly(3).times.ordered
      expect(@terminal).to receive(:gets).and_return("1").ordered
      @interface.get_next_step
    end
  end
end
