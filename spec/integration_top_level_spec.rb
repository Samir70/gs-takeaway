require "controller"
require "menu"
require "menu_item"
require "takeaway"
require "Interface"

RSpec.describe "integration of the whole shebang" do
  before(:each) do
    @quarks = Takeaway.new("Quark's bar and grill")
    quarks_drinks = Menu.new("Drinks")
    quarks_starters = Menu.new("Starters")
    quarks_mains = Menu.new("Main meals")
    quarks_desserts = Menu.new("Desserts")

    @quarks.add(quarks_drinks)
    @quarks.add(quarks_starters)
    @quarks.add(quarks_mains)
    @quarks.add(quarks_desserts)
  end
  xit "user is asked to pick a menu" do
    terminal = double :fake_terminal
    interface = Interface.new(terminal)
    controller = Controller.new(@quarks, interface)
    order = CustomerOrder.new()
    controller.start_order(order)
    expect(interface).to receive(:get_user_choice)
                           .with("Choose a menu (1-4)", ["Drinks", "Starters", "Main meals", "Desserts"])
    expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
    expect(terminal).to receive(:puts).with("[1] Drinks").ordered
    expect(terminal).to receive(:puts).with("[2] Starters").ordered
    expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
    expect(terminal).to receive(:puts).with("[4] Desserts").ordered
  end
end
