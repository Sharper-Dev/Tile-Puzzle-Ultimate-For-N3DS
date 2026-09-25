local Script = {}

function Script.check(board)
    local pieces = {}
    local matches = 0
    for i = 1, #board.places do
        if board.places[i].currentPiece then
            table.insert(pieces, board.places[i].currentPiece)
        elseif i ~= 9 then
            matches = -1
        end
    end

    for i = 1, #pieces do
        if pieces[i].number == i then
            matches = matches + 1
        end
    end

    return matches == #pieces
end

return Script