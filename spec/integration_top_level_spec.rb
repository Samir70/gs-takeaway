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
    quarks_drinks.add(MenuItem.new("Bajoran Ale", 1.50))
    quarks_drinks.add(MenuItem.new("Bloodwine", 3.75))
    quarks_drinks.add(MenuItem.new("Saurian Brandy", 2.60))

    quarks_starters = Menu.new("Starters")
    quarks_starters.add(MenuItem.new("Bajoran shrimp", 6.78))
    quarks_starters.add(MenuItem.new("Tube grubs", 6.78))
    quarks_starters.add(MenuItem.new("Plomeek soup", 7.25))

    quarks_mains = Menu.new("Main Meals")
    quarks_mains.add(MenuItem.new("Jumbo Vulcan Molluscs", 10.50))
    quarks_mains.add(MenuItem.new("Hasperat", 11.75))
    quarks_mains.add(MenuItem.new("Heart of Targ", 12.50))

    quarks_desserts = Menu.new("Desserts")
    quarks_desserts.add(MenuItem.new("Bajoran Jumba Stick", 5.30))
    quarks_desserts.add(MenuItem.new("Rokeg Blood Pie", 15.10))
    quarks_desserts.add(MenuItem.new("Red Velvet Cake", 12.40))

    @quarks.add(quarks_drinks)
    @quarks.add(quarks_starters)
    @quarks.add(quarks_mains)
    @quarks.add(quarks_desserts)
    @terminal = double :fake_terminal
    interface = Interface.new(@terminal)
    @controller = Controller.new(@quarks, interface)
  end
  it "asks user to pick a menu" do
    expect(@terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
    expect(@terminal).to receive(:puts).with("[1] Drinks").ordered
    expect(@terminal).to receive(:puts).with("[2] Starters").ordered
    expect(@terminal).to receive(:puts).with("[3] Main Meals").ordered
    expect(@terminal).to receive(:puts).with("[4] Desserts").ordered
    allow(@terminal).to receive(:gets).and_return("1")
    allow(@terminal).to receive(:puts)
    order = CustomerOrder.new()
    @controller.start_order(order)
  end
  it "shows user items from chosen menu" do
    expect(@terminal).to receive(:puts).exactly(5).times.ordered
    # The five from showing the menu, as above
    expect(@terminal).to receive(:gets).and_return("1")
    expect(@terminal).to receive(:puts).with("Choose an item (1-3)").ordered
    expect(@terminal).to receive(:puts).with("[1] Bajoran Ale (??1.50)").ordered
    expect(@terminal).to receive(:puts).with("[2] Bloodwine (??3.75)").ordered
    expect(@terminal).to receive(:puts).with("[3] Saurian Brandy (??2.60)").ordered
    allow(@terminal).to receive(:gets).and_return("1")
    expect(@terminal).to receive(:puts).at_least(:once)
    order = CustomerOrder.new()
    @controller.start_order(order)
  end
  it "asks user how many of selected item" do
    # The calls from previous tests:
    expect(@terminal).to receive(:puts).exactly(5).times.ordered
    expect(@terminal).to receive(:gets).and_return("1").ordered
    expect(@terminal).to receive(:puts).exactly(4).times.ordered
    # new:
    expect(@terminal).to receive(:gets).and_return("3").ordered
    expect(@terminal).to receive(:puts).with("How many Saurian Brandys?").ordered
    expect(@terminal).to receive(:gets).and_return("5").ordered
    expect(@terminal).to receive(:puts).at_least(:once)
    allow(@terminal).to receive(:gets).and_return("1")
    order = CustomerOrder.new()
    @controller.start_order(order)
  end
  it "shows user current order and asks what next" do
    # The calls from previous tests:
    expect(@terminal).to receive(:puts).exactly(5).times.ordered
    expect(@terminal).to receive(:gets).and_return("1").ordered
    expect(@terminal).to receive(:puts).exactly(4).times.ordered
    expect(@terminal).to receive(:gets).and_return("3").ordered
    expect(@terminal).to receive(:puts).with("How many Saurian Brandys?").ordered
    expect(@terminal).to receive(:gets).and_return("5").ordered
    # new:
    expect(@terminal).to receive(:puts).with("Your current order:").ordered
    expect(@terminal).to receive(:puts).with("5 x Saurian Brandy @ ??2.60each = ??13.00").ordered
    expect(@terminal).to receive(:puts).with("Total value is ??13.00").ordered
    expect(@terminal).to receive(:puts).with("Please select:").ordered
    expect(@terminal).to receive(:puts).with("[1] place order").ordered
    expect(@terminal).to receive(:puts).with("[2] add another item").ordered
    expect(@terminal).to receive(:gets).and_return("1").ordered
    expect(@terminal).to receive(:puts).exactly(7).times
    order = CustomerOrder.new()
    @controller.start_order(order)
  end
  it "takes user back to choose menu when they select that option" do
    # The calls from previous tests:
    expect(@terminal).to receive(:puts).exactly(5).times.ordered
    expect(@terminal).to receive(:gets).and_return("1").ordered
    expect(@terminal).to receive(:puts).exactly(4).times.ordered
    expect(@terminal).to receive(:gets).and_return("3").ordered
    expect(@terminal).to receive(:puts).with("How many Saurian Brandys?").ordered
    expect(@terminal).to receive(:gets).and_return("5").ordered
    expect(@terminal).to receive(:puts).exactly(6).times.ordered
    # new:
    expect(@terminal).to receive(:gets).and_return("2").ordered
    expect(@terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
    expect(@terminal).to receive(:puts).with("[1] Drinks").ordered
    expect(@terminal).to receive(:puts).with("[2] Starters").ordered
    expect(@terminal).to receive(:puts).with("[3] Main Meals").ordered
    expect(@terminal).to receive(:puts).with("[4] Desserts").ordered
    allow(@terminal).to receive(:gets).and_return("1")
    expect(@terminal).to receive(:puts).at_least(:once)
    order = CustomerOrder.new()
    @controller.start_order(order)
  end
  it "completes the order when they select that option" do
    # The calls from previous tests:
    expect(@terminal).to receive(:puts).exactly(5).times.ordered
    expect(@terminal).to receive(:gets).and_return("1").ordered
    expect(@terminal).to receive(:puts).exactly(4).times.ordered
    expect(@terminal).to receive(:gets).and_return("3").ordered
    expect(@terminal).to receive(:puts).with("How many Saurian Brandys?").ordered
    expect(@terminal).to receive(:gets).and_return("5").ordered
    expect(@terminal).to receive(:puts).exactly(6).times.ordered
    # new:
    expect(@terminal).to receive(:gets).and_return("1").ordered
    expect(@terminal).to receive(:puts).with("Your order (worth ??13.00) is on its way!").ordered
    expect(@terminal).to receive(:puts).with("Expect it in 100 years.").ordered
    expect(@terminal).to receive(:puts).with("Keep your pound sterling, it's worthless!").ordered
    expect(@terminal).to receive(:puts).with("You have also been charged 10 bars of Gold-pressed Latinum for delivery!").ordered
    expect(@terminal).to receive(:puts).with("All sales are final!").ordered
    expect(@terminal).to receive(:puts).with("First rule of Acquisition:").ordered
    expect(@terminal).to receive(:puts).with("Once you have their money, you never give it back!").ordered
    # expect(@terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
    # expect(@terminal).to receive(:puts).with("[1] Drinks").ordered
    # expect(@terminal).to receive(:puts).with("[2] Starters").ordered
    # expect(@terminal).to receive(:puts).with("[3] Main Meals").ordered
    # expect(@terminal).to receive(:puts).with("[4] Desserts").ordered
    # allow(@terminal).to receive(:gets).and_return("1")
    # expect(@terminal).to receive(:puts).at_least(:once)
    order = CustomerOrder.new()
    @controller.start_order(order)
  end
end
