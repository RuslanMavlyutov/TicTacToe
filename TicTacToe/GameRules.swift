import UIKit

enum GameFieldCell {
    case empty, tic, tac
}

enum Player {
    case first, second
}

enum EndGame {
    case firstPlayer, secondPlayer, draw
}

class GameField {
    private var storage: [[GameFieldCell]] = []
    
    init(numberRowAndColumn: Int) {
        storage = Array(repeating: Array(repeating: GameFieldCell.empty, count: numberRowAndColumn),
                        count: numberRowAndColumn)
    }

    subscript(column: Int, row: Int) -> GameFieldCell {
        get {
            return storage[column][row]
        }
        set(value) {
            storage[column][row] = value
        }
    }
}

final class GameRules {

    func checkWinner(game: GameField) ->EndGame{
        let i = 0
        if game[i, i] == game[i + 1, i], game[i + 1, i] == game[i + 2, i] {
            print("on horizontall")
            return result(field: game[i,i])
        } else if game[i, i] == game[i, i + 1], game[i, i + 1] == game[i, i + 2] {
            print("on vertical")
            return result(field: game[i,i])
        } else if game[i, i] == game[i + 1, i + 1], game[i + 1, i + 1] == game[i + 2, i + 2] ||
            game[i + 2, i] == game[i + 1, i + 1], game[i + 1, i + 1] == game[i, i + 2] {
            print("on diagonall")
            return result(field: game[i,i])
        } else {
            print("draw")
        }
        return EndGame.draw
    }

    func result(field: GameFieldCell) ->EndGame {
        switch(field) {
        case .tic:
            print("tic")
            return .firstPlayer
        case .empty:
            print("tac")
            return .secondPlayer
        case .tac:
            print("toe")
            return .draw
        }
    }
}
