require "interface"

RSpec.describe Interface do
  context "#get_user_choice(message, options)" do
    it "displays the message and options" do
      terminal = double :fake_terminal
      interface = Interface.new(terminal)
      expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
      expect(terminal).to receive(:puts).with("[1] Drinks").ordered
      expect(terminal).to receive(:puts).with("[2] Starters").ordered
      expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
      expect(terminal).to receive(:puts).with("[4] Desserts").ordered
      interface.get_user_choice("Choose a menu (1-4)", ["Drinks", "Starters", "Main Meals", "Desserts"])
    end
  end
end
