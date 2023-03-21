class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column

    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @board = Array.new(max_row) {Array.new(max_column){" "} }
        @successful_attacks = 0
        @total_grids = 0
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)
        if ship.start_position.row < 1 || ship.start_position.row > @max_row || ship.start_position.column < 1 || ship.start_position.column > @max_column
            return false
        end
        if ship.orientation == "Up"
            x = ship.start_position.row - ship.size - 1
            if x <= @max_row && x >= 1
                x = ship.start_position.row
                for i in 0..(ship.size-1) do 
                    if @board[x - i - 1][ship.start_position.column - 1] == "S"
                        return false
                    end
                end
                for i in 0..(ship.size-1) do 
                    @board[x - i - 1][ship.start_position.column - 1] = "S"
                    @total_grids = @total_grids + 1
                end
                return true
            else
                return false 
            end
        elsif ship.orientation == "Down"
            x = ship.start_position.row + ship.size - 1 
            if x <= @max_row && x >= 1
                x = ship.start_position.row
                for i in 0..(ship.size-1) do 
                    if @board[x + i - 1][ship.start_position.column - 1] == "S"
                        return false
                    end
                end
                for i in 0..(ship.size - 1) do 
                    @board[x + i - 1][ship.start_position.column - 1] = "S"
                    @total_grids = @total_grids + 1
                end
                return true
            else
                return false 
            end
        elsif ship.orientation == "Left"
            y = ship.start_position.column - ship.size - 1 
            if y <= @max_column && y >= 1
                y = ship.start_position.column
                for i in 0..(ship.size-1) do 
                    if @board[ship.start_position.row - 1][y - i - 1] == "S"
                        return false
                    end
                end
                for i in 0..(ship.size - 1) do 
                    @board[ship.start_position.row - 1][y - i - 1] = "S"
                    @total_grids = @total_grids + 1
                end
                return true
            else
                return false 
            end
        elsif ship.orientation == "Right"
            y = ship.start_position.column + ship.size - 1 
            if y <= @max_column && y >= 1
                y = ship.start_position.column
                for i in 0..(ship.size-1) do 
                    if @board[ship.start_position.row - 1][y + i - 1] == "S"
                        return false
                    end
                end
                for i in 0..(ship.size - 1) do 
                    @board[ship.start_position.row - 1][y + i - 1] = "S"
                    @total_grids = @total_grids + 1
                end
                return true
            else
                return false 
            end
        else
            return false
        end
    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # check position
        if position.row <= @max_row && position.row >= 1 && position.column <= @max_column && position.column >= 1
            if @board[position.row - 1][position.column - 1] == "S" 
                @board[position.row - 1][position.column - 1] = "A"
                @successful_attacks = @successful_attacks + 1
                return true
            elsif @board[position.row - 1][position.column - 1] == "A"
                return true
            else
                return false
            end
        else
            return nil
        end
        # update your grid
        # return whether the attack was successful or not
    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks
        return @successful_attacks
    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        if @total_grids == @successful_attacks 
            return true
        else
            return false
        end
    end


    # String representation of GameBoard (optional but recommended)
    def to_s
      @board.each {|x| puts x.to_s}
    end
    
    def check_board (x,y,size,orientation)
        if orientation == "Up"
            for i in 0..(size - 1) do
                if @board[x + i - 1][y - 1] == "S"
                    return false
                end
            end
            return true
        elsif orientation == "Down"
            for i in 0..(size - 1) do
                if @board[x - i - 1][y - 1] == "S"
                    return false
                end
            end
            return true
        elsif orientation == "Left"
            for i in 0..(size - 1) do
                if @board[x - 1][y - i - 1] == "S"
                    return false
                end
            end
            return true
        elsif orientation == "Right"
            for i in 0..(size - 1) do
                if @board[x - 1][y + i - 1] == "S"
                    return false
                end
            end
            return true
        else 
            return false
        end
    end
end
