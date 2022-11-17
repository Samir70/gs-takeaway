require './lib/menu_item'
require './lib/menu'
require './lib/takeaway'

@quarks = Takeaway.new("Quark's bar and grill")
quarks_drinks = Menu.new("Drinks")
quarks_drinks.add(MenuItem.new("Bajoran Ale", 1.50))
quarks_drinks.add(MenuItem.new("Bloodwine", 3.75))
quarks_drinks.add(MenuItem.new("Saurian Brandy", 2.60))

quarks_starters = Menu.new("Starters")
quarks_starters.add(MenuItem.new("Bajoran shrimp", 6.78))
quarks_starters.add(MenuItem.new("Tube grubs", 6.78))
quarks_starters.add(MenuItem.new("Plomeek soup", 7.25))

quarks_mains = Menu.new("Main meals")
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

# controller = Controller.new(takeaway, interface)
# controller.start_order(order)