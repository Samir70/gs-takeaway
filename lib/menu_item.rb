class MenuItem
    def initialize(name, cost)
        @name = name
        @cost = cost
    end

    attr_reader :name, :cost
end