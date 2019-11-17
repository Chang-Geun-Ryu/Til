## 스위프트 기본 데이터 구조의 활용

#### 배열의 초기화

~~~swift
var intArray = Array<Int>()						// 정식 표현 문법	
intArray = [Int]()										// 단축 표션 문법
var intLiteralArray: [Int] = [1,2,3]	// 리터럴 선언 방식
intLiteralArray = [1,2,3]							// 리터럴 단축 선언 방식
intLiteralArray = [Int](count: 5, repeatedValue: 2)	// 기본값으로 배열 생성

~~~

#### 배열 요소 추가, 업데이트

~~~swift
var intArray = [Int]()
intArray.append(50)
intArray.append([60,65,70,75])
intArray.insert(newElement: 50, at: 1)
intArray[2] = 63
~~~

#### 배열에서 요소 가져오기 및 삭제

~~~swift
let five = intArray[5]
let subRange = intArray[2..<5]
let arraySlice = intArray[2...5]
for element in intArray {
  print(element)
}
intArray.contains(55) // return true
~~~

#### 딕션너리 초기화하기

~~~swift
var myDict = Dictionary<Int, String>()	// 정식 선언 문법
var myDict = [Int: String]							// 단축 선언 문법
var myDict: [Int: String] = [1: "One", 2: "Two", 3: "Three"]	// 명시적 선언
var myDict = [1: "One", 2: "Two", 3: "Three"]	// 단축형 선언
~~~

#### 키/값 쌍 추가, 변경, 삭제

~~~swift
myDict.updateValue("Four", forKey: 4)
myDict[5] = "Five"
let removePair = myDict.removeValue(forKey: 1) 	// 키/값 삭제하고 반환
removePair: String? = "One"
myDict[2] = nil																	// 키/값 삭제
~~~

#### 딕셔너리에서 값 가져오기

~~~swift
var myDict = [1: "One", 2: "Two", 3: "Three"]
if let optResult = myDict[4] {	// 옵셔널 바인딩
  print(optResult)
} else {
  print("Key not found")
}

let result = myDict[3]!
print(result)										// 강제 언래핑

let states = ["AL": "Alabama", "CA": "California", "AK": "Alaska", "AZ": "Arizona", "AR": "Arkansas"]
for (stateAbbr, stateName) in states { // 튜플 반환
  print("The state abbreviation for \(stateName) i \(stateAbbr)")
}

for (stateAbbr) in states.keys {
  print("State abbreviation: \(stateAbbr)")
}
for (stateName) in states.values {
  print("State abbreviation: \(stateAbbr)")
}

let sortedArrayFromDictionary = states.sort({$0.0 < $1.0})	// 키값 기준 정렬

for (key) in sortedArrayFromDictionary.map({$0.0}) {
  print("The key: /(key)")
}

for (value) in sortedArrayFromDictionary.map({$0.1}) {
  print("The value:")
}
~~~

#### Set 초기화

~~~swift
var stringSet = Set<String>() 			// 정식 문법
var stringSet: Set = ["Mary", "John", "Sally"]	// 배열요소로 초기화
print(stringSet.debugDebugDescription)
~~~

#### Set 요소 변경 및 가져오기

~~~swift
var stringSet: Set = ["Erik", "Mary", "Michael", "John", "Sally"]
stringSet.insert("Patrick")

if stringSet.contains("Erik") {
  print("Found element")
} else {
  print("Element not found")
}

stringSet.remove("Erik")

if let idx = stringSet.index(of: "John") {
  stringSet.remove(at: idx)
}

stringSet.removeFirst()
stringSet.removeAll()
~~~

#### 정렬

~~~swift
var stringSet: Set = ["Erik", "Mary", "Michael", "John", "Sally"]

for name in stringSet {
  print("name = \(name)")
}

for name in stringSet.sorted() {
  print("name = \(name)")
}
~~~

#### Set 비교연산

~~~swift
let adminRole: Set = ["READ", "EDIT", "DELETE", "CREATE", "SETTINGS", "PUBLISH_ANY", "ADD_USER", "EDIT_USER", "DELETE_USER"]
let editerRole: Set = ["READ", "EDIT", "DELETE", "CREATE", "PUBLISH_ANY"]
let authorRole: Set = ["READ", "EDIT_OWN", "DELETE_OWN", "PUBLISH_OWN", "CREATE"]
let contributorRole: Set = ["CREATE", "EDIT"]
let subscriberRole: Set = ["READ"]

let fooResource = subscriberRole.union(contributorRole)	// 두개 세트에 있는 요수 모두 포함
let commonPermisstions = authorRole
~~~

