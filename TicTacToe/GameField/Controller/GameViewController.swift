import UIKit

final class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    struct Strings {
        static let firstPlayerMove = "First player move"
        static let secondPlayerMove = "Second player move"
        static let startGame = "Start game"
        static let endGame = "End game"
    }

    struct Constants {
        static let sizeBoard = 3
        static let spacing = 3
    }

    private var isGameOver = true
    private var cellBuilder = CellBuilder(size:Constants.sizeBoard)

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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return Constants.sizeBoard * Constants.sizeBoard
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellName = String(describing: PlayerCell.self);
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! PlayerCell
        cell.reset()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let selectedCell:PlayerCell = collectionView.cellForItem(at: indexPath) as! PlayerCell
        if isGameOver {
            return
        }
        if !cellBuilder.isCellFill(index: indexPath.row) {
            let currentCell = cellBuilder.fillCell(index: indexPath.row)
            if currentCell == .tic {
                moveLabel.text = Strings.secondPlayerMove
                moveLabel.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            } else {
                moveLabel.text = Strings.firstPlayerMove
                moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }
            selectedCell.configure(cell: currentCell)

            if cellBuilder.checkGameIsOver() != .nextMove {
                if cellBuilder.checkGameIsOver() != .friendship {
                    moveLabel.text = "\(cellBuilder.checkGameIsOver()) win! Game over!"
                } else {
                    moveLabel.text = "\(cellBuilder.checkGameIsOver()) Game over! It's friendship!"
                }
                isGameOver = true
                startBtn.sendActions(for: .touchUpInside)
                moveLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                return
            }
        }
    }
    
    func initGame()
    {
        if isGameOver {
            isGameOver = false
        }
        cellBuilder = CellBuilder(size: Constants.sizeBoard)
        moveLabel.text = Strings.firstPlayerMove
        moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        collectionView.reloadData()
        startBtn.setTitle(Strings.endGame, for: .normal)
    }

    func reloadUI() {
        let leftSpacing = Constants.spacing
        let rightSpacing = Constants.spacing
        let spacingBetweenCell = (Constants.spacing - 1) * Constants.spacing
        let fullSpacing = leftSpacing + rightSpacing + spacingBetweenCell + Constants.sizeBoard - 1
        let itemSize = (UIScreen.main.bounds.width) / CGFloat(Constants.sizeBoard) - CGFloat(fullSpacing)
        print(UIScreen.main.bounds.width)
        print(itemSize)

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, CGFloat(Constants.spacing), 0, CGFloat(Constants.spacing))
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = CGFloat(Constants.spacing)
        layout.minimumLineSpacing = CGFloat(Constants.spacing)

        collectionView.collectionViewLayout = layout
    }
}

