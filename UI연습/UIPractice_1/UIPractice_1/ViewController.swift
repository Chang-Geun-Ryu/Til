import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let grayView = UIView(frame: CGRect(x: 10, y: 10, width: view.frame.width - 20, height: 100))
        grayView.backgroundColor = .gray
        view.addSubview(grayView)
        
        let yellowView = UIView(frame: CGRect(x: 5, y: 5, width: 100, height: 90))
        yellowView.backgroundColor = .yellow
        grayView.addSubview(yellowView)
        
        let blueView2 = UIView(frame: CGRect(x: yellowView.frame.origin.x + 105, y: 5, width: grayView.frame.width - 115, height: (grayView.frame.height - 15)/2))
        blueView2.backgroundColor = .blue
        grayView.addSubview(blueView2)
        
        let blueView3 = UIView(frame: CGRect(x: yellowView.frame.origin.x + 105, y: blueView2.frame.origin.y + blueView2.frame.height + 5, width: grayView.frame.width - 115, height: (grayView.frame.height - 15)/2))
        blueView3.backgroundColor = .blue
        grayView.addSubview(blueView3)
        
        let orangeView = UIView(frame: CGRect(x: 10, y: 120, width: view.frame.width - 20, height: view.frame.height - 130))
        orangeView.backgroundColor = .orange
        view.addSubview(orangeView)
        
        let redView = UIView(frame: CGRect(x: 10, y: 10, width: orangeView.frame.width - 20, height: (orangeView.frame.height-40)/3))
        redView.backgroundColor = .red
        orangeView.addSubview(redView)
        
        let greenView = UIView(frame: CGRect(x: 10, y: redView.frame.height + 20, width: orangeView.frame.width - 20, height: (orangeView.frame.height-40)/3))
        greenView.backgroundColor = .green
        orangeView.addSubview(greenView)
        
        let blueView = UIView(frame: CGRect(x: 10, y: greenView.frame.origin.y + greenView.frame.height + 10, width: orangeView.frame.width - 20, height: (orangeView.frame.height-40)/3))
        blueView.backgroundColor = .blue
        orangeView.addSubview(blueView)
        
        
    }
    
    
}

