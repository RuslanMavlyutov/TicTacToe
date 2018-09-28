import UIKit

final class CellBuilder {
    let gameField: GameField
    let gameRules: GameRules
    var moveNumber = 0
    var player = Player.first
    var endGame = EndGame.draw
    init(size: Int) {
        gameField = GameField(numberRowAndColumn: size)
        gameRules = GameRules()
    }

    func checkGameIsOver() ->Bool {
        if moveNumber < 5 {
            return false
        }

        if gameRules.checkWinner(game: gameField) == .draw, moveNumber < 9 {
            return false
        }

        return true
    }

    func winner() ->EndGame {
        return gameRules.checkWinner(game: gameField)
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
