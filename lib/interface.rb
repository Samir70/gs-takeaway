class Interface
    def initialize(io)
        @io = io
    end

    def get_user_choice(message, options)
        @io.puts message
        options.each.with_index(1) { |option, index| @io.puts "[#{index}] #{option}" }
    end
end