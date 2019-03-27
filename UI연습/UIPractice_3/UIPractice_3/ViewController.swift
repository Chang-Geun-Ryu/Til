import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var coke: UIView!
    @IBOutlet weak var juce: UIView!
    @IBOutlet weak var leaton: UIView!
    @IBOutlet weak var papci: UIView!
    
    @IBOutlet weak var imageBlue: UIImageView!
    @IBOutlet weak var nameBlue: UILabel!
    @IBOutlet weak var priceBlue: UILabel!
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var price2: UILabel!
    
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var name3: UILabel!
    @IBOutlet weak var price3: UILabel!
    
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var name4: UILabel!
    @IBOutlet weak var price4: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    var totalPriceNumber: Int = 0
    
    let beverages: [Beverage] = [
        Beverage(name: "코카콜라", imageName: "coke", price: 1500),
        Beverage(name: "쥬스", imageName: "juice", price: 1200),
        Beverage(name: "립톤", imageName: "lipton", price: 1700),
        Beverage(name: "펩시", imageName: "pepsi", price: 1300)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAttribute()
    }
    
    func configureAttribute() {
        corner(to: coke, with: 10)
        imageBlue.image = #imageLiteral(resourceName: "coke")
        nameBlue.text = beverages[0].name
        priceBlue.text = String(beverages[0].price)
        
        corner(to: juce, with: 10)
        image2.image = UIImage(named: beverages[1].imageName)
        name2.text = beverages[1].name
        price2.text = String(beverages[1].price)
        
        corner(to: leaton, with: 10)
        image3.image = UIImage(named: beverages[2].imageName)
        name3.text = beverages[2].name
        price3.text = String(beverages[2].price)
        
        corner(to: papci, with: 10)
        image4.image = UIImage(named: beverages[3].imageName)
        name4.text = beverages[3].name
        price4.text = String(beverages[3].price)
        
        btn1.layer.cornerRadius = 10
        btn2.layer.cornerRadius = 10
        btn3.layer.cornerRadius = 10
        btn4.layer.cornerRadius = 10
    }
    
    func corner(to targetView: UIView, with radious: CGFloat) {
        targetView.layer.cornerRadius = radious
        targetView.clipsToBounds = true
        targetView.layer.masksToBounds = true
    }
    @IBAction func pushedButton(_ sender: UIButton) {
        if sender.tag == 0 {//코크
            totalPriceNumber += beverages[0].price
        } else if sender.tag == 1 { //주스
            totalPriceNumber += beverages[1].price
        } else if sender.tag == 2 { //립톤
            totalPriceNumber += beverages[2].price
        } else if sender.tag == 3 { //펩시
            totalPriceNumber += beverages[3].price
        } else {
            print("????")
        }
        
        totalPrice.text = String(totalPriceNumber)
    }
}

