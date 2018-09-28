import UIKit

enum GameFieldCell {
    case empty, tic, tac
}

enum Player {
    case first, second
}

enum EndGame { //GameResult nextMove, winner
    case firstPlayer, secondPlayer, draw
}

class GameField {
    private var storage: [[GameFieldCell]] = []
    let matrixSize: Int
    
    init(numberRowAndColumn: Int) {
        matrixSize = numberRowAndColumn
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
        var endGame = EndGame.draw
        let countForWin = game.matrixSize
        for i in 0..<countForWin {
            var countTicForVerticalWin = 0
            var countTacForVerticalWin = 0
            var countTicForHorizontalWin = 0
            var countTacForHorizontalWin = 0
            var countTicForFirstDiagonalWin = 0
            var countTacForFirstDiagonalWin = 0
            var countTicForSecondDiagonalWin = 0
            var countTacForSecondDiagonalWin = 0
            for j in 0..<countForWin {
                if game[i, j] == .tic {
                    countTicForVerticalWin += 1
                }
                if game[i, j] == .tac {
                    countTacForVerticalWin += 1
                }
                if game[j, i] == .tic {
                    countTicForHorizontalWin += 1
                }
                if game[j, i] == .tac {
                    countTacForHorizontalWin += 1
                }
                if game[j, j] == .tic {
                    countTicForFirstDiagonalWin += 1
                }
                if game[j, j] == .tac {
                    countTacForFirstDiagonalWin += 1
                }
                if game[countForWin - j - 1, j] == .tic {
                    countTicForSecondDiagonalWin += 1
                }
                if game[countForWin - j - 1, j] == .tac {
                    countTacForSecondDiagonalWin += 1
                }
            }
            if countTicForVerticalWin == countForWin || countTicForVerticalWin == countForWin ||
                countTicForFirstDiagonalWin == countForWin || countTicForSecondDiagonalWin == countForWin {
                print("win tic")
                endGame = .firstPlayer
                break
            } else if countTacForVerticalWin == countForWin || countTacForVerticalWin == countForWin ||
                countTacForFirstDiagonalWin == countForWin || countTacForSecondDiagonalWin == countForWin {
                print("win tac")
                endGame = .secondPlayer
                break
            } else {
                endGame = .draw
            }
        }
        return endGame
    }
}
