import UIKit

class playerCell: UICollectionViewCell {
    @IBOutlet weak var figureLabel: UILabel!
    
    func configure(isFirstPlayer: Bool) {
        if isFirstPlayer {
            figureLabel.text = "X"
        } else {
            figureLabel.text = "0"
        }
        contentView.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    }
}
