require "controller"

RSpec.describe Controller do
  before(:each) do
    @takeaway = double :fake_takeaway, shop_name: "Quark's fake bar"
    @interface = double :fake_interface
    @controller = Controller.new(@takeaway, @interface)
  end
  it "initialises with a takeaway and an interface" do
    expect(@takeaway).to receive(:shop_name).and_return("Quark's fake bar")
    expect(@controller.get_shop_name).to eq "Quark's fake bar"
  end

  context "controller starts an order" do
    it "user is asked to pick a menu" do
      expect(@takeaway).to receive(:list_menu_types).and_return(["Drinks", "Starters", "Main meals", "Desserts"])
      expect(@interface).to receive(:get_user_choice).with("Choose a menu (1-4)", ["Drinks", "Starters", "Main meals", "Desserts"])
      order = double :fake_order
      @controller.start_order(order)
    end
  end
end
