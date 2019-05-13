//
//  DiaryData.swift
//  DiaryPractice
//
//  Created by CHANGGUEN YU on 11/05/2019.
//  Copyright © 2019 유창근. All rights reserved.
//

import Foundation

struct DiaryDateList {
  var isOpen: Bool = false
  var diaryList: [DiaryData]
  var date: String
  
  mutating func diaryDelete(index: Int) {
    diaryList.remove(at: index)
  }
  mutating func addDiaryData(title: String, content: String, date: Date) {
    diaryList.append(DiaryData(dateTime: date, diaryTitle: title, diaryContent: content))
  }
}

struct DiaryData {
  
  var dateTime: Date
  var diaryTitle: String
  var diaryContent: String
  
  mutating func diaryModifyToData(dateTime: Date, diaryTitle: String, diaryContent: String) {
    self.dateTime = dateTime
    self.diaryTitle = diaryTitle
    self.diaryContent = diaryContent
  }
}
