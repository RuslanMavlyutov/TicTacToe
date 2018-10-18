import UIKit

final class ViewController: UIViewController {
    struct Strings {
        static let firstPlayerMove = "First player move"
        static let secondPlayerMove = "Second player move"
        static let startGame = "Start game"
        static let endGame = "End game"
    }

    struct Constants {
        static let sizeBoard = 3
        static let spacing: CGFloat = 3
    }

    private var gameField = GameField(size: Constants.sizeBoard) {
        didSet {
            collectionView.reloadData()
            let result = gameRules.checkWinner(game: gameField)
            updateStatusLabel(gameResult: result, currentPlayer: playerTrigger.current())
        }
    }
    private let gameRules: GameRules = GameRules()
    private var playerTrigger = PlayerTrigger()

    @IBOutlet private weak var startBtn: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var moveLabel: UILabel!
    @IBAction private func startGame(_ sender: UIButton)
    {
        if startBtn.titleLabel?.text == Strings.endGame {
            startBtn.setTitle(Strings.startGame, for: .normal)
        } else {
            initGame()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadUI()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.reloadUI()
        }, completion: { (UIViewControllerTransitionCoordinatorContext) ->Void in
        })
        super.viewWillTransition(to: size, with: coordinator)
    }

    private func updateStatusLabel(gameResult: GameResult, currentPlayer: Player) {
        switch gameResult {
        case let .winner(player):
            moveLabel.text = "\(player) win! Game over!"
        case .friendship:
            moveLabel.text = "Game over! It's \(gameResult)!"
        case .nextMove:
            updateStatusLabel(for: currentPlayer)
        }
    }

    private func updateStatusLabel(for player: Player)
    {
        switch playerTrigger.current() {
        case .first:
            moveLabel.text = Strings.secondPlayerMove
            moveLabel.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            break;
        case .second:
            moveLabel.text = Strings.firstPlayerMove
            moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            break;
        }
    }

    func initGame()
    {
        gameField = GameField(size: Constants.sizeBoard)
        playerTrigger = PlayerTrigger()
        moveLabel.text = Strings.firstPlayerMove
        moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        collectionView.reloadData()
        startBtn.setTitle(Strings.endGame, for: .normal)
    }

    func reloadUI() {
        let leftSpacing = Constants.spacing
        let rightSpacing = Constants.spacing
        let spacingBetweenCell = (Constants.spacing - 1) * Constants.spacing
        let fullSpacing = leftSpacing + rightSpacing + spacingBetweenCell + CGFloat(Constants.sizeBoard) - 1
        let itemSize = (UIScreen.main.bounds.width) / CGFloat(Constants.sizeBoard) - fullSpacing
        print(UIScreen.main.bounds.width)
        print(itemSize)

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, Constants.spacing, 0, Constants.spacing)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = Constants.spacing
        layout.minimumLineSpacing = Constants.spacing

        collectionView.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return Int(Constants.sizeBoard * Constants.sizeBoard)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellName = String(describing: PlayerCell.self);
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! PlayerCell
        let index = indexPath.rowAndColumn(forSize: Int(Constants.sizeBoard))
        cell.configure(cell: gameField[index.column, index.row])

        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let index = indexPath.rowAndColumn(forSize: Constants.sizeBoard)
        let result = gameRules.checkWinner(game: gameField)
        if result != .nextMove || gameField.isCellFilled(atRow: index.row, column: index.column) {
            return
        } else {
            gameField[index.column, index.row] = playerTrigger.trigger().symbol
        }
    }
}

