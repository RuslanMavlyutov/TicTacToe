import UIKit

final class PlayerCell: UICollectionViewCell {
    
    @IBOutlet weak var figureLabel: UILabel!

    func configure(cell: GameFieldCell) {
        switch(cell) {
        case .tic:
            figureLabel.text = "X"
            contentView.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        case .tac:
            figureLabel.text = "0"
            contentView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .empty:
            figureLabel.text = ""
            contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
        }
    }

    func reset() {
        figureLabel.text = ""
        contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
    }
}
