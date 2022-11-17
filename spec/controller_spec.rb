require "controller"

RSpec.describe Controller do
  before(:each) do
    @menu = double :fake_menu
    menu_2 = double :fake_menu
    menu_3 = double :fake_menu
    @takeaway = double :fake_takeaway, shop_name: "Quark's fake bar", menus: [@menu, menu_2, menu_3]
    @interface = double :fake_interface
    @controller = Controller.new(@takeaway, @interface)
    @item_1 = double :fake_item, formatted: "Bajoran Ale (£1.50)"
    @item_2 = double :fake_item, formatted: "Bloodwine (£3.75)"
    @item_3 = double :fake_item, formatted: "Saurian Brandy (£2.60)"
  end
  it "initialises with a takeaway and an interface" do
    expect(@takeaway).to receive(:shop_name).and_return("Quark's fake bar")
    expect(@controller.get_shop_name).to eq "Quark's fake bar"
  end

  context "controller starts an order" do
    it "asks user to pick a menu" do
      expect(@takeaway).to receive(:list_menu_types).and_return(["Drinks", "Starters", "Main meals", "Desserts"]).ordered
      expect(@interface).to receive(:get_user_choice).with("Choose a menu (1-4)", ["Drinks", "Starters", "Main meals", "Desserts"]).and_return(1).ordered
      expect(@menu).to receive(:list_items).and_return([@item_1, @item_2, @item_3]).ordered
      expect(@interface).to receive(:get_user_choice).ordered
      order = double :fake_order
      @controller.start_order(order)
    end
    it "asks user to pick item from chosen menu" do
      menu = double :fake_menu
      expect(@takeaway).to receive(:list_menu_types).and_return(["Drinks", "Starters", "Main meals", "Desserts"])
      expect(@interface).to receive(:get_user_choice).with("Choose a menu (1-4)", ["Drinks", "Starters", "Main meals", "Desserts"]).and_return(1)
      expect(@menu).to receive(:list_items).and_return([@item_1, @item_2, @item_3])
      expect(@interface).to receive(:get_user_choice).with("Choose an item (1-3)", ["Bajoran Ale (£1.50)", "Bloodwine (£3.75)", "Saurian Brandy (£2.60)"])
      order = double :fake_order
      @controller.start_order(order)
    end
  end
end
