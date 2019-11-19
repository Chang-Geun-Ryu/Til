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

let fooResource = subscriberRole.union(contributorRole)	// 합집합 요소 포함
let commonPermisstions = authorRole.intersection(contributorRole) // 교집합 요소만 포함
let exclusivePermisstions = authorRole.symmetricDifference(contributorRole) // 차 집합 요소만 포함
~~~

#### 부분 집합 및 동등 연산자

~~~swift
var sourceSet: Set = [1,2,3]
var destSet: Set = [2,1,3]
// 세트의 요소순서는 중요한 것이 아님
var iseqaul = sourceSet == destSet	// true
~~~

* isSubset(of:) : 어떤 세트의 요소가 특정 Set에 모두 포함돼 있는지 확인
* isStrictSubset(of:) : 어떤 세트의 요소가 특정 Set에 모두 포함되있지만, 동등한 집합은 아님을 확인
* isSuperset(of:) : 특정 세트의 모든 요소가 또 다른 Set에 모두 포함되 있는지 확인
* isStrictSuperset(of:) : 특정 Set의 모든 요소가 또 다른 Set에 모두 포함되어 있지만, 동등한 집합은 아님
* isDisjoint(with:) : 두 Set에 공통 요소가 포함되어 있는지 여부 확인



#### 무기명 튜플

~~~swift
let responseCode = (4010, "Invalid file contents", 0x21451fff3b)
let responseCode: (Int, String, Double) = (4010, "Invalid file condtents", 0x8fffffffffffff)
print(resopseCode.dynamicType)	// 튜플의 타입 확인

print(responseCode.0) // 4010

let (errorCode, errorMessage, offset) = resposeCode
print(errorCode)
print(errorMessage)
print(offset)
~~~

#### 기명 튜플

~~~swift
let responseCode = (errorCode: 4010, errorMessage: "Invalid file contents", offset: 0x7fffffffffffff)
print(responsecode.errorCode)
~~~

~~~swift
let responseCode: (errorCode: Int, errorMessage: String, offset: Double) = (4010, "Invalid file condtents", 0x7fffffffffffff)
print(responsecode.errorCode)
~~~



#### 서브스스크립트 문법

~~~swift 
class MovieList {
  private var tracks = ["The godfather", "The Dark Knight", "Pulp Fiction"]
  subscript(index: Int) -> String {
    get {
      return self.tracks[index]
    }
    set {
      self.tracks[index] = newValue
    }
  }
}

var movieList = MovieList()
var aMovie = movieList[0]
print(aMovie)	// The Godfather
movieList[1] = "Forest Gump"
aMovie = movieList[1]
print(aMovie)	// Forest Gump
~~~

#### 컬렉션의 수정가능 속성

~~~swift
struct Person {
  var firstName: String
  var lastName: String
  init(firstName: String, lastName: String) {
    self.firstName = firstName
    self.lastName = lastName
  }
}

class Address {
  var street: String = ""
  var city: String = ""
  var state: String = ""
  var zipcode: String = ""
  init(street: String, city: String, state: String, zipcode: String) {
    self.street = street
    self.city = city
    self.state = state
    self.zipcode = zipcode
  }
}

let person = Person(firstName: "John:", lastName: "Smith")
person.firstName = "Erik" // "컴파일 에러"

let address = Address(street: "1 Infinite Loop", city: "Cupertino", state: "CA", zipcode: "
95014")
address.city = "19111 Pruneridge Avenue"

// address가 상수여서 컴파일 에러 발생
address = Address(street: "19111 Prunerighe Avenue", city: "Cupertino", state: "CA", zipcode: "95014") 
~~~



#### 오브젝티브C 초기화 방식

~~~swift
import Foundation // Foundation에 포함된 모든 오브젝티브C 클래스를 사용가능하게 된다
~~~

* Swift Method -> ObjectiveC Messages
* Receiver, selector, parameters
* Receiver : 메소드가 실행 결과를 받개될  대상 객체
* selector : 메소드 이름
* Parameters : 메소드에 전달되는 실행될 객체

[myInstance fooMethod: 2322 forKey: X]: 

- fooMethod 메시지를 myInstance 객체에 전달하되, 두개의 값 2322와 X를 파라미터로 전달

~~~objc
// objc
NSString *postalCode = [[NSString alloc] initWithFormat:@"%d-%d",32259,1234]; 
// postalCode = 32259 - 1234
// receiver: postalCode
// selector: length (별도의 파라미터 없음)
int len = [postalCode lenght];
// len = 10
~~~

~~~swift
// swift
var postalCode: NSString = NSString(format: "%d-%d", 32259, 1234)
var len = postalCode.length
// len = 10
~~~

* 클래스가 NSObject를 상속하지 않는 경우에도 @objc 속성을 사용해서 해당 매소드에 접근 가능
* @objc 속성은 스위프트 메소드, 프로퍼티, 초기화 객체, 서브스크립트, 프로토콜, 클래스, 열거형 등 모두 적용가능

* ObjectiveC 코드에서 쓸 다른 이름으로 오버라이딩 하고 싶다면 @objc(name)속성을 사용 가능

~~~swift
@objc(ObjCMoveList)
class MovieList: NSObject {
  private var tracks = ["The Godfather", "The Dark Knight", "Pulp Fiction"]
  subscipt(index: Int) -> String {
    get {
      return self.tracks[index]
    }
    set {
      self.tracks[index] = newValue
    }
  }
}
// NSObject를 상속할 경우 @objc를 붙이지 않아도 컴파일러가 자동으로 붙인다.
// ObjMovieList라는 심벌을 붙여 이클래스 접근에 사용
~~~



#### 스위프트 타입의 호환성

~~~swift
if let url - NSURLComponents(string: "http://www.google.com") {
  // URL 이 올바르고, 초기화에 사용 가능할 때 실행할 코드
} else {
  // URL 중 하나 이상의 요소가 올바르지 않을 경우
  // url = nil
}
~~~

구조체와 클래스를 개발 할 때, SOLID 원칙을 준수한다.

* **단일 책임 원칙**: 하나의 클래스는 오직 단 하나의 책임만 부담
* **개방과 폐쇄의 원칙**: 소프트웨어는 확장이라는 측면에서는 개방되 있어야 하고, 수정이라는 측면에서는 폐쇠 
* **리스코프 대체원칙**: 특정 클래스에서 분화되 나온 클래스 원본 클래스로 대체 가능
* **인터레이스 세분화 원칙**: 개별적인 목적에 대응할 수 있는 여러개의 인터페이스가 일반적인 목적에 대응 할 수 있는 하나의 인터페이스 보다 낫다
* **의존성 도치의 원칙**: 구체화가 아닌 추상화를 중시

~~~swift
import AppKit
public struct Particle {
  private var name: String
  private var sumbol: String
  private var statistics: String
  private var image: NSImage
  
  public init(name: String, symbol: String, stateistics: String, image: NSImage) {
    self.name = name
    self.sybol = sybol
    self.statistics = statistics
    self.image = image
  }
}

extension Particle {
  public func particalAsImage() -> NSImage {
    return self.image
  }
}

var aURL = NSURL(string: "https://wikimedia.org/wikipedia/commons/thumb/6/62/Quark_structure_pion.svg/200px-Quark_structure_pion.svg.png")

let anImage = NSImage(contentsOfURL: aURL!)

var quarkParticle = Particle(name: "Quark", symbol: "q", statistics: "Fermionic", image: anImage!)

let quarkImage = quarkParticle.particalAsImage()
~~~



## 컬랙션 클래스 브릿징

스위프트는 Foundation 컬랙션 타입인 NSArray, NSSet, NSDictionary를 스위프트 Array, Set, Dictionary 타입으로 브릿징 할 수 있도록 지원

#### NSArray를 Array로 브릿징

~~~swift
let nsFibonacciArray: NSArray = [0,1,1,2,3,5,8,13,21,34]
let swiftFibonacciArray: [Int] = nsFibonacciArray as! [Int] // NSArray 강제 언래핑
if let swiftFibonacciArray: [Int] = nsFibonacciArray as? [Int] {
  // swiftFibonacciArray 배열 사용
}

let mixedNSArray: NSArray = NSArray(array: [0,1, "1", 2, "3", 5, "8", 13, 21, 34])
let swiftArrayMixed: [Int] = mixedNSArray as! [Int] // error 발생!
if let swiftArrayMixed: [Int] = mixedNSArray as? [Int] {
  // swiftArrayMixed 사용
} else {
  // swiftArrayMixed 는 nil
} 
~~~



## 스위프트 프로토콜 지향 프로그래밍

스위프트 프로토콜은 메소드.프로퍼티, 연관 타입과 특정 타입을 지원하기 위한 타입 alias 등으로 구성된 목록

#### 명령 전달을 위한 디스패치 기법

* 스위프트 프로토콜은 ObjectiveC 프로토콜의 Superset
* objc의 모든 메소드는 런타임시 메시지를 이용하여 Dynamic dispatch 또는 동적 명령 전달 기법을 사용, swift는 다양한 기법 제공

#### 프로토콜 작성 문법

~~~swift
protocol Particle {
  var name: String { get }
  func particalAsImage() -> NSImage
}
~~~

#### 타입으로서의 프로토콜

* 함수, 메소드, 초기화 객체에서 반환 타입 또는 파라미터 타입
* 배열, 세트, 딕셔너리에서 개별 아이템 타입
* 변수, 상수, 프로퍼티의 타입

#### Array 리터럴 문법

~~~swift
var myIntArray = Array<Int>() // 컬랙션 타입 Array, 데이터 타입 Int

var myIntArray = [Int]() // ExpressibleByArrayLiteral 프로토콜은 배열 형식의 문법을 이용하여 구조체, 클래스, 열거형을 초기화 할 수 있도록 도와줌
init(arrayLiteral elements: Self.Element...) // 프로토콜 사용시 프로토콜에 부합되기 위한 메소드
~~~

~~~swift
struct Particle {
  var name: String
  var symbol: String
  var statistics: String
}

struct ParticleList: ExpressibleByArrayLiteral {
  private let items: [Particle]
  init(arrayLiteral: Particle...) {
    self.items = arrayLiteral
  }
}

var p1 = Particle(name: "Quark", symbol: "q", statistics: "Fermionic")
var p2 = Particle(name: "Lepton", symbol: "l", statistics: "Fermionic")
var p3 = Particle(name: "Photon", symbol: "Y", statistics: "Bosonic")

var particleList = [p1, p2, p3] // ExpressibleByArrayLiteral 프로토콜을 채택함으로서 Array Literal 초기화 가능
~~~

