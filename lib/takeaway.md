
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
       │      - has views: view_menus, view_menu_items, view_order           │
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
   │  - list _meals in format  │              │ ----------------                │             │
   │    that includes          │              │                                 │             │
   │    name and cost          │              │   - add meals (with quantity)   │             │
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
     └────────────────────────┘

Steps 3, 4, and 5 then operate as a cycle.

## 3. Create Examples as Integration Tests

Create examples of the classes being used together in different situations
and combinations that reflect the ways in which the system will be used.

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