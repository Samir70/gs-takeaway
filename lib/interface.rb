class Interface
  def initialize(io)
    @io = io
    @response = 0
  end

  def get_user_choice(message, options)
    @io.puts message
    options.each.with_index(1) { |option, index| @io.puts "[#{index}] #{option}" }
    @response = @io.gets.to_i
    if @response == 0 || @response > options.length
      fail "ERROR:: user picked an invalid valid option. Should be a number 1..#{options.length}"
    end
    return @response
  end

  def get_quantity(item)
    @io.puts "How many #{item.name}s?"
    res = @io.gets.to_i
    if res <= 0
      fail("ERROR:: you can't buy that many!!!")
    end
    return res
  end

  def show_order(order)
    @io.puts "Your current order:"
    order.items.each { |item| @io.puts item }
    @io.puts "Total value is £#{"%.2f" % order.total_cost}"
  end

  def get_next_step
    @io.puts "Please select:"
    @io.puts "[1] place order"
    @io.puts "[2] add another item"
    response = @io.gets.to_i
    if response == 1 || response == 2
      return response
    end
    get_next_step
  end

  attr_reader :response
end
