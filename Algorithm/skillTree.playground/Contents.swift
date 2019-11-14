import Foundation


func getArrayString(text: String) -> [String] {
  var stringArray: [String] = []
  
  text.forEach {
    stringArray.append(String($0))
  }
  return stringArray
}

func solution(skill: String, skillTrees: [String]) -> Int {
  
  guard 1...20 ~= skillTrees.count else { return -1}
  
  var goodSkillCount = 0
  let skillArray = getArrayString(text: skill)
  
//  print("skillArray: \(skillArray)")
  
  skillTrees.forEach { userSkill in
    var skillTreeConfirm: [Int?] = []
    let skillTreesArray = getArrayString(text: userSkill)
//    print("skillTreesArray: \(skillTreesArray)")
    
    skillArray.forEach {
      let num = skillTreesArray.firstIndex(of: $0)
      skillTreeConfirm.append(num)
      print("num: \(num)")
    }
    
    var good = true
    for index in 0..<(skillTreeConfirm.count - 1) {
//      guard let value = skillTreeConfirm[index],
//        skillTreeConfirm[index] > skillTreeConfirm[index + 1] ||
//        skillTreeConfirm[index] == -1 else { continue }
      
//      if skillTreeConfirm[index] > skillTreeConfirm[index + 1] {
        print("\"\(userSkill)\": \(skillArray[index + 1])을 배우기 전에 \(skillArray[index])을 배워야 함니다. 불가능한 스킬트리입니다.")
        good = false
        break
//      }
    }
    
    if good {
      print("\"\(userSkill)\": 가능한 스킬트리 입니다.")
      goodSkillCount += 1
    }
  }
  
  return goodSkillCount
}


let goodCount = solution(skill: "CBD", skillTrees: ["BACDE", "CBADF", "AECB", "BDA"])

print("return: ", goodCount)
