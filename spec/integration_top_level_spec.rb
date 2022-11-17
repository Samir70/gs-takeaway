require "controller"
require "menu"
require "menu_item"
require "takeaway"
require "interface"
require "customer_order"

RSpec.describe "integration of the whole shebang" do
  before(:each) do
    @quarks = Takeaway.new("Quark's bar and grill")
    quarks_drinks = Menu.new("Drinks")
    quarks_starters = Menu.new("Starters")
    quarks_mains = Menu.new("Main Meals")
    quarks_desserts = Menu.new("Desserts")

    @quarks.add(quarks_drinks)
    @quarks.add(quarks_starters)
    @quarks.add(quarks_mains)
    @quarks.add(quarks_desserts)
  end
  it "user is asked to pick a menu" do
    terminal = double :fake_terminal
    interface = Interface.new(terminal)
    controller = Controller.new(@quarks, interface)
    order = CustomerOrder.new()
    expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
    expect(terminal).to receive(:puts).with("[1] Drinks").ordered
    expect(terminal).to receive(:puts).with("[2] Starters").ordered
    expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
    expect(terminal).to receive(:puts).with("[4] Desserts").ordered
    allow(terminal).to receive(:gets).and_return("2")
    controller.start_order(order)
  end
end
