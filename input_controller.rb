require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'

# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)
    gameboard = GameBoard.new 10, 10
    ships = 0 
    if read_file_lines(path)  == true
        read_file_lines(path) do |line| 
            if ships < 5
                if line =~ /^\(([1-9]|10),([1-9]|10)\), (Right|Left|Up|Down), ([1-5])$/
                    row = $1.to_i
                    column = $2.to_i
                    orientation = $3.to_s
                    size = $4.to_i
                    gameboard.add_ship(Ship.new(Position.new(row,column),orientation,size))
                        ships += 1 
                end
            end
        end
    else
        return nil
    end
    if ships == 5
        return gameboard
    else
        return nil
    end
end


# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)
    attacks = Array.new
    if read_file_lines(path)  == true
        read_file_lines(path) do |line| 
            if line =~ /^\(([1-9]|10),([1-9]|10)\)$/
                row = $1.to_i
                column = $2.to_i
            attacks.push(Position.new(row,column))
            end
        end
    else
        return nil
    end
    return attacks
end


# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end
    true
end
