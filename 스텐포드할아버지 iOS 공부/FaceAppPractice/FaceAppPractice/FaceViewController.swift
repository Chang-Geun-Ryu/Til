//
//  ViewController.swift
//  FaceAppPractice
//
//  Created by CHANGGUEN YU on 04/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
  
  let drawView = FaceView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    view.addSubview(drawView)
    drawView.translatesAutoresizingMaskIntoConstraints = false
    
    drawView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    drawView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    drawView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    drawView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  
}

