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

    attr_reader :response
end