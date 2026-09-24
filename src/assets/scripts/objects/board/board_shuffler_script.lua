local Script = {}
local Debugger = require("debugger.m2d_debugger")
local Time = require("time.m2d_time")

local function getInversionsCount(pieces)
    local count = 0
    for i = 1, #pieces do
        for j = i + 1, #pieces do
            if pieces[i].number > pieces[j].number then
                count = count + 1
            end
        end
    end
    return count
end

function Script.shuffle(board)
    local pieces = board.pieces
    local places = board.places
    local hasShuffled = false

    repeat
        local h, m, s = System.getTime()
        local seed = h * 3600 + m * 60 + s + Time.deltaTime
        math.randomseed(seed)
        math.random()
        for i = 1, #pieces do
            local j = math.random(i, #pieces)
            pieces[i], pieces[j] = pieces[j], pieces[i]
        end
        if getInversionsCount(pieces) % 2 == 0 then
            Debugger.msg("GENERATED A SOLVABLE BOARD")
            local matches = 0
            for i = 1, #pieces do
                if pieces[i].number == i then matches = matches + 1 end
            end
            if matches == #pieces then
                Debugger.msg("GENERATED SOLVED BOARD, TRYING AGAIN")
            else
                hasShuffled = true
            end
        else
            Debugger.msg("UNSOLVABLE BOARD, TRYING AGAIN")
        end
    until hasShuffled

    for i = 1, #pieces do
        pieces[i]:placePiece(places[i])
    end
end

return Script