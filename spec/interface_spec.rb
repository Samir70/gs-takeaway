require "interface"

RSpec.describe Interface do
    # The following two have no internal state so don't need to be setup as blank before each test
    let(:terminal) { double :fake_terminal }
    let(:interface) { Interface.new(terminal) }
  context "#get_user_choice(message, options)" do
    before(:each) do
      expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
      expect(terminal).to receive(:puts).with("[1] Drinks").ordered
      expect(terminal).to receive(:puts).with("[2] Starters").ordered
      expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
    end
    it "displays the message and options" do
      expect(terminal).to receive(:puts).with("[4] Desserts").ordered
      allow(terminal).to receive(:gets).and_return("4")
      interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"])
    end
    it "receives a response from user" do
      expect(terminal).to receive(:puts).with("[4] Desserts").ordered
      expect(terminal).to receive(:gets).and_return("4").ordered
      expect(interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"])).to eq 4
      expect(interface.response).to eq 4
    end
    it "raises an error if response is 0" do
      expect(terminal).to receive(:puts).with("[4] Desserts").ordered
      expect(terminal).to receive(:gets).and_return("0").ordered
      expect { interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"]) }.to raise_error "ERROR:: user picked an invalid valid option. Should be a number 1..4"
    end
    it "raises an error if response is larger than number of options" do
      expect(terminal).to receive(:gets).and_return("4").ordered
      expect { interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals"]) }.to raise_error "ERROR:: user picked an invalid valid option. Should be a number 1..3"
    end
  end

  context "get_quantity" do
    it "asks user for how much of an item" do
      item = double :fake_item, name: "Saurian Brandy", cost: 2.6
      expect(terminal).to receive(:puts).with("How many Saurian Brandys?")
      expect(terminal).to receive(:gets).and_return("5")
      interface.get_quantity(item)
    end
    it "accepts positive response" do
      item = double :fake_item, name: "Saurian Brandy", cost: 2.6
      expect(terminal).to receive(:puts).with("How many Saurian Brandys?")
      expect(terminal).to receive(:gets).and_return("5")
      interface.get_quantity(item)
    end
    it "raises error for non-positive response" do
      item = double :fake_item, name: "Saurian Brandy", cost: 2.6
      expect(terminal).to receive(:puts).with("How many Saurian Brandys?")
      expect(terminal).to receive(:gets).and_return("0")
      expect { interface.get_quantity(item) }.to raise_error "ERROR:: you can't buy that many!!!"
    end
  end
end
