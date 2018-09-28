import UIKit

final class CellBuilder {
    let gameField: GameField
    let gameRules: GameRules
    var moveNumber = 0
    var player = Player.first
    var endGame = GameResult.friendship
    init(size: Int) {
        gameField = GameField(numberRowAndColumn: size)
        gameRules = GameRules()
    }

    func checkGameIsOver() ->GameResult {
        if moveNumber < 5 {
            return .nextMove
        }

        if gameRules.checkWinner(game: gameField) == .friendship, moveNumber < 9 {
            return .nextMove
        }

        if moveNumber < 9 {
            return gameRules.checkWinner(game: gameField)
        } else {
            return .friendship
        }
    }

    func isCellFill(index: Int) ->Bool {
        let row = index / 3
        let column = index % 3
        if gameField[column, row] != GameFieldCell.empty {
            return true
        } else {
            return false
        }
    }

    func fillCell(index: Int) -> Player {
        moveNumber += 1
        let row = index / 3
        let column = index % 3
        if moveNumber % 2 != 0 {
            gameField[column,row] = GameFieldCell.tic
            return Player.first
        } else {
            gameField[column,row] = GameFieldCell.tac
            return Player.second
        }
    }
}
