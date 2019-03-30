//
//  SecondViewController.swift
//  exam1
//
//  Created by CHANGGUEN YU on 29/03/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    public var pw = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: view.frame.width/2 - 200, y: 200, width: 400, height: 80))
        label.text = pw
        label.font = UIFont.systemFont(ofSize: 45)
        label.textColor = .black
        label.textAlignment = .center
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.frame = CGRect(x: view.frame.width/2 - 100, y: 400, width: 200, height: 100)
        button.setTitle("dismiss", for: .normal)
        button.tintColor = .blue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func dismissView (_ sender: UIButton) {
        guard let vc = presentingViewController as? FirstViewController else { return }
        
        vc.dismiss(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
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
