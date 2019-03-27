import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var idImage: UIImageView!
    @IBOutlet weak var pwsImage: UIImageView!
    @IBOutlet weak var idFeild: UITextField!
    @IBOutlet weak var pwsField: UITextField!
    @IBOutlet weak var login: UIButton!
    
    let users: [User] = [
        User(name: "Mike", profileImageName: "person1", password: "abcd"),
        User(name: "Allen", profileImageName: "person2", password: "1122"),
        User(name: "Kevin", profileImageName: "person3", password: "1234"),
        User(name: "Joke", profileImageName: "person4", password: "4321"),
        User(name: "Hillary", profileImageName: "person5", password: "aaaa"),
        User(name: "Jenny", profileImageName: "person6", password: "dcba"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idImage.image = UIImage(named: "id")
        pwsImage.image = UIImage(named: "password")
        
        login.layer.cornerRadius = 10
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let id = idFeild.text, !id.isEmpty else {
            // 경고창띄우기
            alert("아이디가 없습니다.", "아이디를 입력해주세요")
            return
        }
        guard let psw = pwsField.text, !psw.isEmpty else {
            // 경고창띄우기
            alert("비밀번호가 없습니다.", "비밀번호를 입력해주세요")
            return
        }
        
        for user in users {
            if user.name == id, user.password == psw {
                print("success")
                
                let secondView = SecondViewController()
                secondView.currentUser = user
                
                present(secondView, animated: true)
                
                return
            }
        }
        
        alert("아이디또는 비밀번호가 없습니다.", "입력해주세요")
    }
    
    func alert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func corner(to targetView: UIView, with radious: CGFloat) {
        targetView.layer.cornerRadius = radious
        targetView.clipsToBounds = true
        targetView.layer.masksToBounds = true
    }
}

