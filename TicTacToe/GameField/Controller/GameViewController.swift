import UIKit

class ViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {

    let array = [0,1,2,3,4,5,6,7,8]
    var isFirstPlayerMove = true
    var isGameOver = true
    var moveNumber = 0 {
        didSet {
            if(moveNumber == 9) {
                moveLabel.text = "Game over!/nFirst player win"
                moveLabel.textColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                moveNumber = 0
                isGameOver = true
                return
            }
            if moveNumber%2 == 0 {
                moveLabel.text = "First player move"
                moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            } else {
                moveLabel.text = "Second player move"
                moveLabel.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
            }
        }
    }

    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moveLabel: UILabel!
    @IBAction func startGame(_ sender: UIButton)
    {
        if startBtn.titleLabel?.text == "End game" {
            isGameOver = true
            startBtn.setTitle("Start", for: .normal)
        } else {
            initGame()
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! playerCell
        cell.contentView.backgroundColor = UIColor(red: 102/256, green: 255/256, blue: 255/256, alpha: 0.66)
        if !(cell.figureLabel.text?.isEmpty)! {
            cell.figureLabel.text = ""
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if !isGameOver {
            let selectedCell:playerCell = collectionView.cellForItem(at: indexPath) as! playerCell
            print(indexPath)
            moveNumber += 1
            selectedCell.configure(isFirstPlayer: moveNumber%2 != 0)
        }
    }
    
    func initGame()
    {
        isGameOver = false
        moveLabel.text = "First player move"
        moveLabel.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)

        collectionView.reloadData()
        startBtn.setTitle("End game", for: .normal)
    }
    
}

