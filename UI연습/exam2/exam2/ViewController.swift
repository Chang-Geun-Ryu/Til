//
//  ViewController.swift
//  exam2
//
//  Created by CHANGGUEN YU on 29/03/2019.
//  Copyright © 2019 CHANGGUEN YU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var money = 70000
    var orderTotal = 0
    var jjajang = 0
    var jjam = 0
    var tang = 0
    
    @IBOutlet weak var jjajangNumber: UILabel!
    @IBOutlet weak var jjambbongNumber: UILabel!
    @IBOutlet weak var tangsuukNumber: UILabel!
    
    var label소지금:UILabel?
    var label결재: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let label1 = UILabel(frame: CGRect(x: 20, y: 350, width: 80, height: 40))
        label1.text = "소지금"
        label1.backgroundColor = .green
        label1.textAlignment = .center
        view.addSubview(label1)
        
        let label2 = UILabel(frame: CGRect(x: 110, y: 350, width: 140, height: 40))
        label2.backgroundColor = .green
        label2.textAlignment = .right
        view.addSubview(label2)
        label소지금 = label2
        
        let label3 = UILabel(frame: CGRect(x: 20, y: 400, width: 80, height: 40))
        label3.text = "결재금액"
        label3.backgroundColor = .orange
        label3.textAlignment = .center
        view.addSubview(label3)
        
        let label4 = UILabel(frame: CGRect(x: 110, y: 400, width: 140, height: 40))
        label4.backgroundColor = .orange
        label4.textAlignment = .right
        view.addSubview(label4)
        label결재 = label4
        
        let button1 = UIButton(type: .system)
        button1.backgroundColor = .black
        button1.frame = CGRect(x: 270, y: 350, width: 80, height: 40)
        button1.setTitle("초기화", for: .normal)
        button1.tintColor = .white
        button1.addTarget(self, action: #selector(reset), for: .touchUpInside)
        view.addSubview(button1)
        
        let button2 = UIButton(type: .system)
        button2.backgroundColor = .black
        button2.setTitle("결재", for: .normal)
        button2.tintColor = .white
        button2.frame = CGRect(x: 270, y: 400, width: 80, height: 40)
        button2.addTarget(self, action: #selector(buy), for: .touchUpInside)
        view.addSubview(button2)
        
        viewLabel()
    }
    
    @objc func reset() {
        money = 70000
        orderTotal = 0
        
        jjajang = 0
        jjam = 0
        tang = 0
        
        viewLabel()
    }
    
    @objc func buy() {
        guard orderTotal > 0 else { return }
        
        let str = "총 결제금액은 \(orderTotal)입니다."
        let alert = UIAlertController(title: "결제하기", message: str, preferredStyle: .alert)
        let okAct = UIAlertAction(title: "확인", style: .default) { (okAct) in self.ok() }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(okAct)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func ok() {
        guard money > orderTotal else { return }
        
        money -= orderTotal
        jjam = 0
        jjajang = 0
        tang = 0
        orderTotal = 0
        
        viewLabel()
    }
    
    @IBAction func order(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            jjajang += 1
        case 1:
            jjam += 1
        case 2:
            tang += 1
        default:
            break
        }
        
        orderTotal = 5000 * jjajang + 6000 * jjam + 12000 * tang
        
        viewLabel()
    }
    
    func viewLabel() {
        guard label결재 != nil, label소지금 != nil else { return }
        
        jjajangNumber.text = String(jjajang)
        jjambbongNumber.text = String(jjam)
        tangsuukNumber.text = String(tang)
        
        label소지금?.text = String(money) + "원"
        label결재?.text = String(orderTotal) + "원"
    }

}

