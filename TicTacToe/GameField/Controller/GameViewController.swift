import UIKit

private let SIZE_BOARD = 3
private let SPACING = 3
private let FIRST_PLAYER_MOVE = "First player move"
private let SECOND_PLAYER_MOVE = "Second player move"
private let START_GAME = "Start game"
private let END_GAME = "End game"

final class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    private var isGameOver = true
    private var cellBuilder = CellBuilder(size:SIZE_BOARD)

    @IBOutlet private weak var startBtn: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var moveLabel: UILabel!
    @IBAction private func startGame(_ sender: UIButton)
    {
        if startBtn.titleLabel?.text == END_GAME {
            startBtn.setTitle(START_GAME, for: .normal)
        } else {
            initGame()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadIB()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.reloadIB()
        }, completion: { (UIViewControllerTransitionCoordinatorContext) ->Void in
        })
        super.viewWillTransition(to: size, with: coordinator)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return SIZE_BOARD * SIZE_BOARD
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cellName = String(describing: NSStringFromClass(PlayerCell.classForCoder())).components(separatedBy: ".").last!;
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
                moveLabel.text = SECOND_PLAYER_MOVE
                moveLabel.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            } else {
                moveLabel.text = FIRST_PLAYER_MOVE
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
        cellBuilder = CellBuilder(size: SIZE_BOARD)
        moveLabel.text = FIRST_PLAYER_MOVE
        moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        collectionView.reloadData()
        startBtn.setTitle(END_GAME, for: .normal)
    }

    func reloadIB() {
        let leftSpacing = SPACING
        let rightSpacing = SPACING
        let spacingBetweenCell = (SPACING - 1) * SPACING
        let fullSpacing = leftSpacing + rightSpacing + spacingBetweenCell + SIZE_BOARD - 1
        let itemSize = (UIScreen.main.bounds.width) / CGFloat(SIZE_BOARD) - CGFloat(fullSpacing)
        print(UIScreen.main.bounds.width)
        print(itemSize)

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, CGFloat(SPACING), 0, CGFloat(SPACING))
        layout.itemSize = CGSize(width: itemSize, height: itemSize)

        layout.minimumInteritemSpacing = CGFloat(SPACING)
        layout.minimumLineSpacing = CGFloat(SPACING)

        collectionView.collectionViewLayout = layout
    }
}

