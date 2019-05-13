//
//  ViewController.swift
//  DiaryPractice
//
//  Created by CHANGGUEN YU on 11/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {
  let tableView = UITableView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
    setTableView()
  }
  
  func autolayout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  func setTableView() {
//    tableView.dataSource = self
//    tableView.delegate = self
    
    view.addSubview(tableView)
    
    
  }
  
  func setNavigationItem() {
    self.title = "일기장"
    let rightButton = UIBarButtonItem(title: "✚", style: .plain, target: self, action: #selector(showDiary))
    navigationItem.rightBarButtonItem = rightButton
  }
  
  @objc func showDiary() {
    let diaryContentVC = DiaryContentViewController()
    navigationController?.pushViewController(diaryContentVC, animated: true)
    
  }
}

//extension DiaryViewController: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return 0
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//    return 0
//  }
//
//  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    <#code#>
//  }
//}
//
//extension DiaryViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    <#code#>
//  }
//}
