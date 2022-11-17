require "controller"

RSpec.describe Controller do
  it "initialises with a takeaway and an interface" do
    takeaway = double :fake_takeaway, shop_name: "Quark's fake bar"
    interface = double :fake_interface
    controller = Controller.new(takeaway, interface)
    expect(takeaway).to receive(:shop_name).and_return("Quark's fake bar")
    expect(controller.get_shop_name).to eq "Quark's fake bar"
  end
end
