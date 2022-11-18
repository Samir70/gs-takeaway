RSpec.shared_examples "order has started" do
  it "asks user to pick a menu" do
    expect(subject).to receive(:puts).with("Choose a menu (1-4)").ordered
    expect(subject).to receive(:puts).with("[1] Drinks").ordered
    expect(subject).to receive(:puts).with("[2] Starters").ordered
    expect(subject).to receive(:puts).with("[3] Main Meals").ordered
    expect(subject).to receive(:puts).with("[4] Desserts").ordered
  end
end
