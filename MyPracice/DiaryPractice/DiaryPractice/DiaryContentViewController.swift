//
//  DiaryContentViewController.swift
//  DiaryPractice
//
//  Created by CHANGGUEN YU on 11/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit

protocol DiaryDataUpdateDelegate: class {
  func updateDiary(titleText: String, contentText: String, date: Date)
}

class DiaryContentViewController: UIViewController {
  private let titleTextField = UITextField()
  private let contentTextField = UITextField()
  private let titleLabel = UILabel()
  var addTitle = true
  
  var delegate: DiaryDataUpdateDelegate? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
    setUp()
    
    autolayout()
  }
  
  private func autolayout() {
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: titleTextField.leadingAnchor, constant: -10).isActive = true
    titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    titleTextField.translatesAutoresizingMaskIntoConstraints = false
    titleTextField.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
    titleTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    titleTextField.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
    titleTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
    
    contentTextField.translatesAutoresizingMaskIntoConstraints = false
    contentTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
    contentTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
    contentTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
    contentTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
    contentTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
  }
  
  private func setNavigationItem() {
    let leftButton = UIBarButtonItem(title: "⇦", style: .plain, target: self, action: #selector(getBackVC))
    navigationItem.leftBarButtonItem = leftButton
    
    let rightButton = UIBarButtonItem(title: addTitle ? "Add" : "Edit", style: .plain, target: self, action: #selector(addDiaryContent))
    navigationItem.rightBarButtonItem = rightButton
  }
  
  private func setUp() {
    titleTextField.font = UIFont.systemFont(ofSize: 30)
    titleTextField.borderStyle = .roundedRect
    titleTextField.textAlignment = .left
    titleTextField.placeholder = "제목"
    view.addSubview(titleTextField)
    
    contentTextField.font = UIFont.systemFont(ofSize: 20)
    contentTextField.borderStyle = .roundedRect
    contentTextField.textAlignment = .natural
    contentTextField.contentVerticalAlignment = .fill
    view.addSubview(contentTextField)
    
    titleLabel.text = "제목 :"
    titleLabel.font = UIFont.systemFont(ofSize: 30)
    view.addSubview(titleLabel)
  }
  
  func setEditDiary(title: String, content: String) {
    titleTextField.text = title
    contentTextField.text = content
    addTitle = false
  }
  
  @objc func getBackVC() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func addDiaryContent() {
    delegate?.updateDiary(titleText: titleTextField.text ?? "", contentText: contentTextField.text ?? "", date: Date())
    navigationController?.popViewController(animated: true)
  }
  
}
