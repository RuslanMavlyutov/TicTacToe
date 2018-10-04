import UIKit

final class CellBuilder {
    private let size: Int
    private let MIN_NUMBER_FOR_CHECK_WINNER: Int
    private let countCell: Int
    private let gameField: GameField
    private let gameRules: GameRules
    private var moveNumber = 0

    init(size: Int) {
        self.size = size
        countCell = size * size
        MIN_NUMBER_FOR_CHECK_WINNER = size + size - 1
        gameField = GameField(size: size)
        gameRules = GameRules()
    }

    func checkGameIsOver() ->GameResult {
        if moveNumber < MIN_NUMBER_FOR_CHECK_WINNER {
            return .nextMove
        }

        if case .friendship = gameRules.checkWinner(game: gameField), moveNumber < countCell {
            return .nextMove
        }
        return gameRules.checkWinner(game: gameField)
    }

    func isCellFill(index: Int) ->Bool {
        let row = index / size
        let column = index % size
        if gameField[column, row] != .empty {
            return true
        } else {
            return false
        }
    }

    func fillCell(index: Int) -> GameFieldCell {
        moveNumber += 1
        let row = index / size
        let column = index % size
        if moveNumber % 2 != 0 {
            gameField[column,row] = .tic
        } else {
            gameField[column,row] = .tac
        }
        return gameField[column,row]
    }

    func gameFieldBoard() -> GameField {
        return gameField
    }
}
