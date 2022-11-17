
# Multi-Class Planned Design Recipe

## 1. Describe the Problem

> As a customer
> So that I can check if I want to order something
> I would like to see a list of dishes with prices.

> As a customer
> So that I can order the meal I want
> I would like to be able to select some number of several available dishes.

> As a customer
> So that I can verify that my order is correct
> I would like to see an itemised receipt with a grand total.

Use the twilio-ruby gem to implement this next one. You will need to use doubles too.

> As a customer
> So that I am reassured that my order will be delivered on time
> I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

## 2. Design the Class System

Design the interfaces of each of your classes and how they will work together
to achieve the job of the program. You can use diagrams to visualise the
relationships between classes.

       ┌─────────────────────────────────────────────────────────────────────┐
       │                                                                     │
       │  CONTROLLER     - communicates selection from takeaway              │
       │  ----------       to user order                                     │
       │                                                                     │
       │   - init(takeaway)                                                  │
       │   - start_order(order),                                             │
       │      - has views: view_menu_types, view_menu_items, view_order      │
       │   - add_to_order                                                    │
       │   - place_order                                                     │
       │                                                                     ├────────────────┐
       └─┬───────────────────────────────────────────────────────────────┬───┘                │
         │                                                               │                    │
         │                                                               │                    │
         │         ┌───────────────────────────────────────────┐         │                    │
         │         │                                           │         │                    │
┌────────▼─────────┴───────────┐                               │         │                    │
│                              │                         ┌─────▼─────────▼──────────┐         │
│ TAKEAWAY                     │                         │                          │         │
│ --------                     ├────┐                    │ INTERFACE                │         │
│   - init with name of shop   │    │                    │ ---------                │         │
│   - add a menu               │    │contains zero       │ - get user input via     │         │
│   - list menu types          │    │  or more           │   numbered list in       │         │
│   - list content of a menu   │    │  menus             │   in terminal            │         │
│                              │    │                    └────────▲─────────────────┘         │
└──────────────────────────────┘    │                             │                           │
                                    │                             │                           │
   ┌───────────────────────────┐    │                             │                           │
   │                           │    │                             │                           │
   │ MENU                      │    │         ┌───────────────────┴─────────────┐             │
   │ ----                      │◄───┘         │                                 │             │
   │                           │              │ CUSTOMER'S ORDER                │             │
   │  - list_items             │              │ ----------------                │             │
   │                           │              │                                 │             │
   │                           │              │   - add meals (with quantity)   │             │
   │  - init with type eg:     │              │   - list meals                  │             │
   │    starter, etc           │              │     with cost for quantity      │◄────────────┘
   └────────┬──────────────────┘              │     with total cost             │
            │                                 │   -                             │
            │                                 └─────┬───────────────────────────┘
            │ contains zero or more                 │
            │  meals                                │
            │                                  contains zero or more
            │                                   meals
     ┌──────▼─────────────────┐                     │
     │                        │                     │
     │ MenuItem               ◄─────────────────────┘
     │ ----                   │
     │   - name               │
     │   - price              │
     │   - format for display │
     └────────────────────────┘

Steps 3, 4, and 5 then operate as a cycle.

## 3. Create Examples as Integration Tests
Overview of use case, setting up a controller with a full takeaway that has four menus

``` ruby
quarks = Takeaway.new("Quark's bar and grill")
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

quarks.add(quarks_drinks)
quarks.add(quarks_starters)
quarks.add(quarks_mains)
quarks.add(quarks_desserts)

controller = Controller.new(takeaway, interface)
controller.start_order(order)
<!-- At this point, the user will move around various menus and add to order, view order, place order -->
controller.add_to_order(menu_item)
controller.add_to_order(menu_item)
controller.add_to_order(menu_item)
controller.place_order
```
Create examples of the classes being used together in different situations
and combinations that reflect the ways in which the system will be used.

``` ruby
# test 1 - a menu can add menu_items
quarks_drinks = Menu.new("Drinks")
drink_1 = MenuItem.new("Bajoran Ale", 1.50)
drink_2 = MenuItem.new("Bloodwine", 3.75)
drink_3 = MenuItem.new("Saurian Brandy", 2.60)
quarks_drinks.add(drink_1)
quarks_drinks.add(drink_2)
quarks_drinks.add(drink_3)
expect(quarks_drinks.list_items).to eq [drink_1, drink_2, drink_3]

# test 2 - a takeaway can add menus and list their types
quarks = Takeaway.new("Quark's bar and grill")
quarks_drinks = Menu.new("Drinks")
quarks_drinks.add(MenuItem.new("Bajoran Ale", 1.50))
quarks_drinks.add(MenuItem.new("Bloodwine", 3.75))
quarks_drinks.add(MenuItem.new("Saurian Brandy", 2.60))

quarks_starters = Menu.new("Starters")
quarks_starters.add(MenuItem.new("Bajoran shrimp", 6.78))
quarks_starters.add(MenuItem.new("Tube grubs", 6.78))
quarks_starters.add(MenuItem.new("Plomeek soup", 7.25))

quarks.add(quarks_drinks)
quarks.add(quarks_starters)
expect(quarks.list_menu_types).to eq ["Drinks", "Starters"]

# test 3 - a takeaway can add menus and list items on that menu
quarks = Takeaway.new("Quark's bar and grill")
quarks_drinks = Menu.new("Drinks")
drink_1 = MenuItem.new("Bajoran Ale", 1.50))
drink_2 = MenuItem.new("Bloodwine", 3.75))
drink_3 = MenuItem.new("Saurian Brandy", 2.60))
quarks_drinks.add(drink_1)
quarks_drinks.add(drink_2)
quarks_drinks.add(drink_3)

quarks.add(quarks_drinks)
expect(quarks.list_menu_items(quarks_drinks)).to eq [drink_1, drink_2, drink_3]

# test 4 - whole shebang: user is asked to pick a menu
# add another to repeat instructions if answer doesn't make sense
quarks = Takeaway.new("Quark's bar and grill")
quarks_drinks = Menu.new("Drinks")
quarks_starters = Menu.new("Starters")
quarks_mains = Menu.new("Main meals")
quarks_desserts = Menu.new("Desserts")

quarks.add(quarks_drinks)
quarks.add(quarks_starters)
quarks.add(quarks_mains)
quarks.add(quarks_desserts)

terminal = double :fake_terminal
interface = Interface.new(terminal)
controller = Controller.new(takeaway, interface)
order = CustomerOrder.new()
controller.start_order(order)

expect(interface).to receive(:get_user_choice)
    .with("Choose a menu", ["Drinks", "Starters", "Main meals", "Desserts"]) 
expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
expect(terminal).to receive(:puts).with("[1] Drinks").ordered
expect(terminal).to receive(:puts).with("[2] Starters").ordered
expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
expect(terminal).to receive(:puts).with("[4] Desserts").ordered

# test 5 - whole shebang: a user is asked to pick an item from a menu
# add another to repeat instructions if answer doesn't make sense
quarks = Takeaway.new("Quark's bar and grill")
quarks_drinks = Menu.new("Drinks")
quarks_drinks.add(MenuItem.new("Bajoran Ale", 1.50))
quarks_drinks.add(MenuItem.new("Bloodwine", 3.75))
quarks_drinks.add(MenuItem.new("Saurian Brandy", 2.60))
quarks_starters = Menu.new("Starters")
quarks_mains = Menu.new("Main meals")
quarks_desserts = Menu.new("Desserts")

quarks.add(quarks_drinks)
quarks.add(quarks_starters)
quarks.add(quarks_mains)
quarks.add(quarks_desserts)

terminal = double :fake_terminal
interface = Interface.new(terminal)
controller = Controller.new(takeaway, interface)
order = CustomerOrder.new()
controller.start_order(order)

expect(interface).to receive(:get_user_choice)
    .with("Choose a menu", ["Drinks", "Starters", "Main meals", "Desserts"]) 
expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
expect(terminal).to receive(:puts).with("[1] Drinks").ordered
expect(terminal).to receive(:puts).with("[2] Starters").ordered
expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
expect(terminal).to receive(:puts).with("[4] Desserts").ordered
expect(terminal).to receive(:gets).and_return("1").ordered

expect(interface).to receive(:get_user_choice)
    .with("Choose an item", ["Bajoran Ale (1.50)", "Bloodwine (3.75)", "Saurian Brandy (2.60)"]) 
expect(terminal).to receive(:puts).with("Choose an item (1-3)").ordered
expect(terminal).to receive(:puts).with("[1] Bajoran Ale (1.50)").ordered
expect(terminal).to receive(:puts).with("[2] Bloodwine (3.75)").ordered
expect(terminal).to receive(:puts).with("[3] Saurian Brandy (2.60)").ordered

# test 6 - whole shebang: a user is asked how many of chosen item
# also 6b - check that amount makes sense eg: is a positive number
quarks = Takeaway.new("Quark's bar and grill")
quarks_drinks = Menu.new("Drinks")
quarks_drinks.add(MenuItem.new("Bajoran Ale", 1.50))
quarks_drinks.add(MenuItem.new("Bloodwine", 3.75))
quarks_drinks.add(MenuItem.new("Saurian Brandy", 2.60))
quarks_starters = Menu.new("Starters")
quarks_mains = Menu.new("Main meals")
quarks_desserts = Menu.new("Desserts")

quarks.add(quarks_drinks)
quarks.add(quarks_starters)
quarks.add(quarks_mains)
quarks.add(quarks_desserts)

terminal = double :fake_terminal
interface = Interface.new(terminal)
controller = Controller.new(takeaway, interface)
order = CustomerOrder.new()
controller.start_order(order)

expect(interface).to receive(:get_user_choice)
    .with("Choose a menu", ["Drinks", "Starters", "Main meals", "Desserts"]) 
expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
expect(terminal).to receive(:puts).with("[1] Drinks").ordered
expect(terminal).to receive(:puts).with("[2] Starters").ordered
expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
expect(terminal).to receive(:puts).with("[4] Desserts").ordered
expect(terminal).to receive(:gets).and_return("1").ordered

expect(interface).to receive(:get_user_choice)
    .with("Choose an item", ["Bajoran Ale (1.50)", "Bloodwine (3.75)", "Saurian Brandy (2.60)"]) 
expect(terminal).to receive(:puts).with("Choose an item (1-3)").ordered
expect(terminal).to receive(:puts).with("[1] Bajoran Ale (1.50)").ordered
expect(terminal).to receive(:puts).with("[2] Bloodwine (3.75)").ordered
expect(terminal).to receive(:puts).with("[3] Saurian Brandy (2.60)").ordered
expect(terminal).to receive(:gets).and_return("3").ordered

expect(interface).to receive(:get_user_choice).with("How many Saurian Brandys?", [])

# test 7 - whole shebang: user is shown current order and asked add item / place order
# set up as above plus:
expect(terminal).to receive(:gets).and_return("5").ordered
expect(terminal).to receive(:puts).with("Your current order:").ordered
expect(terminal).to receive(:puts).with("5 x Saurian Brandy @ 2.60each = 13.00").ordered
expect(terminal).to receive(:puts).with("Please select:").ordered
expect(terminal).to receive(:puts).with("[1] place order").ordered
expect(terminal).to receive(:puts).with("[2] add another item").ordered

# test 8 - whole shebang: user wanted another item, back to start
# set up as above plus:
expect(terminal).to receive(:gets).and_return("2").ordered
expect(interface).to receive(:get_user_choice)
    .with("Choose a menu", ["Drinks", "Starters", "Main meals", "Desserts"]) 
expect(terminal).to receive(:puts).with("Choose a menu (1-4)").ordered
expect(terminal).to receive(:puts).with("[1] Drinks").ordered
expect(terminal).to receive(:puts).with("[2] Starters").ordered
expect(terminal).to receive(:puts).with("[3] Main Meals").ordered
expect(terminal).to receive(:puts).with("[4] Desserts").ordered

# test 8b - whole shebang: user wanted another item, back to start
# set up as upto test 7:
expect(terminal).to receive(:gets).and_return("1").ordered
expect(interface).to receive(:tell_user_order_is_complete).with(13) 
expect(terminal).to receive(:puts).with("Your order (worth £13.00) is on its way!").ordered
expect(terminal).to receive(:puts).with("Expect it in 100 years.").ordered
expect(terminal).to receive(:puts).with("Keep your pound sterling, it's worthless!").ordered
expect(terminal).to receive(:puts).with("You have also been charged 10 bars of Gold-pressed Latinum for delivery!").ordered
expect(terminal).to receive(:puts).with("All sales are final!").ordered
expect(terminal).to receive(:puts).with("First rule of Acquisition:").ordered
expect(terminal).to receive(:puts).with("Once you have their money, you never give it back!").ordered

```

Encode one of these as a test and move to step 4.

## 4. Create Examples as Unit Tests

Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail.

Encode one of these as a test and move to step 5.

## 5. Implement the Behaviour

For each example you create as a test, implement the behaviour that allows the
class to behave according to your example.

Then return to step 3 until you have addressed the problem you were given. You
may also need to revise your design, for example if you realise you made a
mistake earlier.