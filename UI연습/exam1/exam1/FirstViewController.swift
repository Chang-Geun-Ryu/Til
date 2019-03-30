//
//  FirstViewController.swift
//  exam1
//
//  Created by CHANGGUEN YU on 29/03/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    private let pw = "asdf"
    var switchProperty: UISwitch?
    var textFeild: UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let textPW = UITextField(frame: CGRect(x: view.frame.width/2 - 200, y: 200, width: 400, height: 80))
        textPW.font = UIFont.systemFont(ofSize: 45)
        textPW.textColor = .black
        textPW.textAlignment = .center
        textPW.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textPW.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textPW.addTarget(self, action: #selector(editingDidEndOnExit), for: .editingDidEndOnExit)
        textPW.borderStyle = .roundedRect
        textPW.placeholder = "비밀번호 입력하세요"
        textPW.isSecureTextEntry = true
        view.addSubview(textPW)
        textFeild = textPW
        
        let switchOnOff = UISwitch(frame: CGRect(x: view.frame.width/2 - 15, y: view.frame.height/2 - 20, width: 30, height: 40))
        switchOnOff.setOn(false, animated: true)
        switchOnOff.isEnabled = false
        view.addSubview(switchOnOff)
        switchProperty = switchOnOff
    }
    
    @objc func editingDidBegin (_ sender: UITextField) {}
    
    @objc func editingChanged (_ sender: UITextField) {
        guard pw == textFeild?.text else {
            switchProperty?.setOn(false, animated: true)
            return
        }
        
        switchProperty?.setOn(true, animated: true)
    }
    
    @objc func editingDidEndOnExit (_ sender: UITextField) {
        guard let on = switchProperty?.isOn else {return}
        guard on else{ return }
        guard let password = textFeild?.text else { return }
        
        let secondView = SecondViewController()
        secondView.pw = password
        present(secondView, animated: true)
        textFeild?.text = ""
        switchProperty?.setOn(false, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
