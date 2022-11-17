class MenuItem
    def initialize(name, cost)
        @name = name
        @cost = cost
    end

    def formatted
        return "#{@name} (£#{'%.2f' % @cost})"
    end

    attr_reader :name, :cost
end