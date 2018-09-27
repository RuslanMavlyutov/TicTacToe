import UIKit

final class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    let array = [0,1,2,3,4,5,6,7,8]
    var game = GameRules()
    let cellBuilder = CellBuilder(size:3)

    @IBOutlet private weak var startBtn: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var moveLabel: UILabel!
    @IBAction private func startGame(_ sender: UIButton)
    {
        if startBtn.titleLabel?.text == "End game" {
            startBtn.setTitle("Start", for: .normal)
        } else {
            initGame()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlayerCell
        cell.contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
        if !(cell.figureLabel.text?.isEmpty)! {
            cell.figureLabel.text = ""
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let selectedCell:PlayerCell = collectionView.cellForItem(at: indexPath) as! PlayerCell
        if !cellBuilder.isCellFill(index: indexPath.row) {
            if cellBuilder.fillCell(index: indexPath.row) == Player.first {
                moveLabel.text = "Second player move"
                moveLabel.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
                selectedCell.configure(player: Player.first)
            } else {
                moveLabel.text = "First player move"
                moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                selectedCell.configure(player: Player.second)
            }

            if cellBuilder.checkGameIsOver() {
                print(cellBuilder.winner())
                if cellBuilder.winner() != .draw {
                    moveLabel.text = "\(cellBuilder.winner()) win! Game over!"
                } else {
                    moveLabel.text = "\(cellBuilder.winner()) win! Game over! It's draw"
                }
                moveLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                return
            }
        }

    }
    
    func initGame()
    {
        moveLabel.text = "First player move"
        moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        collectionView.reloadData()
        startBtn.setTitle("End game", for: .normal)
    }
}

