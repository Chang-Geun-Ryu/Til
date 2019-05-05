//
//  ViewController.swift
//  FaceAppPractice
//
//  Created by CHANGGUEN YU on 04/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let path = UIBezierPath()
    
    path.move(to: CGPoint(x: 80, y: 50))
    path.addLine(to: CGPoint(x: 140, y: 150))
    path.addLine(to: CGPoint(x: 200, y: 200))
    
//    view.addSubview(path)
    
  }


}

