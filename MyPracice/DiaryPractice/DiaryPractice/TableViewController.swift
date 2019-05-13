//
//  TableViewController.swift
//  DiaryPractice
//
//  Created by CHANGGUEN YU on 12/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  var headerList: [DiaryDateList] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigationItem()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  func setNavigationItem() {
    self.title = "일기장"
    let rightButton = UIBarButtonItem(title: "✚", style: .plain, target: self, action: #selector(showDiary))
    navigationItem.rightBarButtonItem = rightButton
  }
  
  @objc func showDiary() {
    let diaryContentVC = DiaryContentViewController()
    diaryContentVC.delegate = self
    navigationController?.pushViewController(diaryContentVC, animated: true)
  }
  
  @objc func handleDropDown(_ sender: UIButton) {
    let section = sender.tag
    
    // we'll try to close the section first by deleting the rows
    var indexPaths = [IndexPath]()
    for row in headerList[section].diaryList.indices {
      print(0, row)
      let indexPath = IndexPath(row: row, section: section)
      indexPaths.append(indexPath)
    }
    
    let Open = headerList[section].isOpen
    headerList[section].isOpen = !Open
    
    if Open {
      tableView.deleteRows(at: indexPaths, with: .automatic)
    } else {
      tableView.insertRows(at: indexPaths, with: .automatic)
    }
  }
  
  func deleteDiary(indexPath: IndexPath) {
    headerList[indexPath.section].diaryDelete(index: indexPath.row)
    if headerList[indexPath.section].diaryList.count == 0 {
      headerList.remove(at: indexPath.section)
    }
    
    tableView.reloadData()
  }
  
  func editDiary(indexPath: IndexPath) {
    let diaryContentVC = DiaryContentViewController()
    diaryContentVC.delegate = self
    let title = headerList[indexPath.section].diaryList[indexPath.row].diaryTitle
    let content = headerList[indexPath.section].diaryList[indexPath.row].diaryContent
    diaryContentVC.setEditDiary(title: title, content: content)
    navigationController?.pushViewController(diaryContentVC, animated: true)
  }
  
}

// tableView
extension TableViewController {
  override func numberOfSections(in tableView: UITableView) -> Int {
    print("numberOfSections :", headerList.count)
    return headerList.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("numberOfRowsInSection", headerList[section].diaryList.count, section)
    guard headerList[section].isOpen else { return 0}
    return headerList[section].diaryList.count
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let button = UIButton(type: .system)
    button.setTitle(headerList[section].date, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .white
    button.addTarget(self, action: #selector(handleDropDown(_:)), for: .touchUpInside)
    button.tag = section
    return button
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Diary") ?? UITableViewCell(style: .default, reuseIdentifier: "Diary")
    cell.textLabel?.text = headerList[indexPath.section].diaryList[indexPath.row].diaryTitle
    return cell
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let deleteButton = UITableViewRowAction(style: .default, title: "delete") { (action, indexpath) in
      self.deleteDiary(indexPath: indexPath)
    }
    
    deleteButton.backgroundColor = .red
    
    let editButton = UITableViewRowAction(style: .default, title: "edit") { (extion, indexpath) in
      self.editDiary(indexPath: indexPath)
    }
    
    editButton.backgroundColor = .green
    
    return [deleteButton, editButton]
  }
}

// delegate
extension TableViewController: DiaryDataUpdateDelegate {
  func updateDiary(titleText: String, contentText: String, date: Date) {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_kr")
    formatter.timeZone = TimeZone(abbreviation: "KST")
    formatter.dateFormat = "yyyy-MM-dd"
    let dateString = formatter.string(from: date)
    
    for idx in headerList.indices {
      guard headerList[idx].date != dateString else{
        headerList[idx].addDiaryData(title: titleText, content: contentText, date: date)
        print(headerList[idx].diaryList.count)
        return
      }
    }
    
    headerList.append(DiaryDateList(isOpen: false, diaryList: [DiaryData(dateTime: date, diaryTitle: titleText, diaryContent: contentText)], date: dateString))
  }
}
