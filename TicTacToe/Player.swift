import Foundation

enum Player {
    case first, second
}

final class PlayerTrigger {
    private var currentPlayer = Player.first

    func trigger() -> Player {
        let result = currentPlayer
        switch currentPlayer {
        case .first:
            currentPlayer = .second
        case .second:
            currentPlayer = .first
        }
        return result
    }

    func current() -> Player {
        return currentPlayer
    }
}

extension Player {
    var symbol: GameFieldCell {
        switch self {
        case .first:
            return .tic
        case .second:
            return .tac
        }
    }
}
