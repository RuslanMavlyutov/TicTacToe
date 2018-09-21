import UIKit

class playerCell: UICollectionViewCell {
    @IBOutlet weak var figureLabel: UILabel!
    
    func configure(isFirstPlayer: Bool) {
        if isFirstPlayer {
            figureLabel.text = "X"
            contentView.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        } else {
            figureLabel.text = "0"
            contentView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
}
