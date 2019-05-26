# Optional Chaining

* 옵셔널 체이닝은 nil일 수도 있는 프로퍼티나, 매소드 그리고 서브스크립트에 질의(query)를 하는 과정
* 옵셔널이 프로퍼티나 매소드, 서브스크립트에 대한 값을 갖고 있다면 반환하고, nil 이면 nil을 반환
* 여러 query를 연결하여 연결된 query에서 어느 하나라도 nil 이면 젙체 결과는 nil

#### Optional Chaining as an Alternative to Forced Unwrapping

* 옵셔널 체이닝은 옵셔널 값 뒤 ( ? )를 붙여 표현 가능
* 프로퍼티, 메소드, 서브스크립트 등이 옵셔널 사용가능
* 옵셔널 체이닝에 의해 nil 값이 호출 될 수 있기 때문에 옵셔널 체이닝의 값은 항상 옵셔널 값, 옵셔널 값을 반환하지 않는 프로퍼티, 메소드, 서브스크립트를 호출 하더라도 옵셔널 체이닝에 의해 옵셔널 값이 반환

~~~swift
class Person {
  var residence: Residence?
}
class Residence {
  var numberOfRooms = 1
}
if let roomCount = john.residence?.numberOfRooms {
  print("\(roomCount)")
} else {
  print("no one")
}	// no one

let roomCount = john.residence!.numberOfRooms	// runtime error
~~~

nil 이었던 residence 값에 Residence 인스턴스를 생성해 추가

~~~swift
john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
  print("\(roomCount)")
} else {
  print("no one")
}	// 1
~~~

#### Defining Model Classes for Optional Chaining

* 옵셔널 체이닝을 프로퍼티, 매소드, 서브스크립트에 사용 가능, 한단계가 아닌 여러 level로 사용

~~~swift
class Person {
  var residence: Residence?
}
class Residence {
  var rooms = [Room]()
  var numbarOfRooms: Int {
    return rooms.count
  }
  subscript(i: Int) -> Room {
    get {
      return rooms[i]
    }
    set {
      rooms[i] = newValue
    }
  }
  func printNumberOfRooms() {
 		print("\(numberOfRooms)"")
  }
  var address: Address?
}	// Residence가 Room 인스턴스의 배열을 소유하고 있기 때문에 numberOfRooms 프로퍼티는 계산된 프로퍼티로 선언, rooms 배열에 접근하기 위한 단축으로 서브스크립트 선언
class Room {
  let name: Stirng
  init(name: String) { self.name = name }
}
class Address {
  var buildingName: String?
  var buildingNumber: String?
  var street: String?
  func buildingIdentifier() -> Stirng? {
    if let buildingNumber = buildingNumber, let street = street {
      return "\(buildingNumber) \(street)"
    } else if buildingName != nil {
      return buildingName
    } else {
      return nil
    }
  }
}
~~~

#### Accessing Properties Through Optional Chaining

~~~swift
let john = Person()
if let roomCount = john.residence?.numberOfRooms {
  print("\(roomCount)")
} else {
  print("no one")
} // no one
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
john.residence?.address = someAddress	// residence가 nil 이므로 할당 불가(왼쪽항이 nil 이므로 오른쪽 항이 아예 실행 안함)
~~~

#### Calling Methods Through Optional Chaining

* 옵셔널 체이닝을 이용한 메소드 호출

~~~swift
if john.residence?.printNumberOfRooms() != nil {
  print("ok")
} else {
  print("nil")
}	// nil
~~~

* 매소드 호출결과가 nil 인지 아닌지 비교 후 결과 처리 printNimberOfRooms() 는 직접적인 반환값이 명시되어 있지 않지만 암시적으로 Void를 반환하고 이 매소드 호출이 옵셔널 체이닝을 이루기 때문에 Void?를 반환 하여 nil 비교 가능

#### Accessing Subscripts Through Optional Chaining

* 옵셔널 체이닝을 이용해 옵셔널 값을 서브스크립트로 접근 가능

~~~swift
if let firstRoomName = john.residence?[0].name {
  print("\(firstRoomName).")
} else {
  print("Unable")
}	// Unable
// john.residence가 nil이기 때문에 서브스크립트 접근은 실패
~~~

~~~swift
let johnHouse = Residence()
johnHouse.rooms.append(Room(name: "Living Room"))
johnHouse.rooms.append(Room(name: "Kitchen"))
john.residence = johnsHouse

if let firstRoomName = john.residence?[0].name {
  print("\(firstRoomName)")	
} else {
  print("Unable")
}	// Living Room
~~~

#### Accessing Subscripts of Optional Types

* Dictionary Type 같이 서브스크립트 결과로 옵셔널을 반환한다면 ? 를 붙여줌

~~~swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brain"]?[0] = 72
~~~

#### Linking Multiple Levels of Chaining

* 옵셔널 체이닝의 상위 레벨 값이 옵셔널인 경우 현재 값이 옵셔널이 아니더라도 값은 옵셔널 값
* 옵셔널 체이닝의 상위 레벨 값이 옵겨널이고 현재 값이 옵셔널 이라고 해서 더 옵셔널하게 되지 않음
* 옵셔널 체이닝을 통해 값을 검색하거나 매소드를 호출하면 단계에 상관없이 옵셔널을 반환

~~~swift
if let johnsStreet = john.residence?.address?.street {
  print("\(johnStreet)")
} else {
  print("Unable")
}	// Unable

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john.residence?.address = johnsAddress

if let johnsStreet = john.residence?.address?.street {
    print("\(johnsStreet).")
} else {
    print("Unable")
}	// Laurel Street
~~~

#### Chaining on Methods with Optional Return Values

* 반환값이 있는 옵셔널 체이닝에서 반환값이 있는 매소드를 호출 가능

~~~swift
if let buildingIdentifier = john.residence?.address?.buildingIdentifier() {
  print("\(buildingIdentifier)")
}	// The Larches.
~~~

* 매소드값을 갖추고 더 추가적인 행동을 하기위해서는 ( ? ) 를 붙이고 행동 기입
* 옵셔널 체이닝에 물려 있기 때문에 매소드의 반환 값도 옵셔널이 되서 표시해야 함

~~~swift
if let beginsWithThe = john.residence?.address?.buildingIdentfier()?.hasPrefix("The") {
  if beginWithThe {
    print("begins with \"The\".")
  } else {
    print("not begins with \"The\".")
  }
}	// begins with "The".
~~~

