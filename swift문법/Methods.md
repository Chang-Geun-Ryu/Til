# Methods

* 특정 타입의 클래스, 구조체, 열거형과 관련된 함수
* 인스턴스 메소드: 특정 타입의 인스턴스에서 실행할 수 있는 메소드

#### Instance methods

* 특정 클래스, 구조체, 열거형의 인스턴스에 속한 메소드, 인스턴스 내 값을 제어하거나 변경 가능

~~~swift
6class Counter {
  var count = 0
  func increment() {
    count += 1
  }
  func increment(by amount: Int) {
    count += amount
  }
  func reset() {
    count = 0
  }
}	// 각 increment(), increment(amount:), reset()를 정의해 count Property를 변경
let counter = Counter()	// count 초기값: 0
counter.increment()			// count: 1
counter.increment(by: 5)// count: 6
counter.reset()					// count: 0
~~~

**self Property**: 모든 프로퍼티는 암시적으로 인스턴스 자체를 의미하는 self 프로퍼티를 갖음

~~~swift
func increment() {
  self.count += 1
}	// 사실상 self 키워드를 사용하고 있음

struct Point { 
  var x = 0.0, y = 0.0
  func isToTheRightOf(x: Double) -> Bool {
    return self.x > x	// self.x를 이용해 프로퍼티 x와 파라미터 x를 구분
  }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTherightOf(x: 1.0) {
  print("x == 1.0")
}	// x == 1.0
~~~

**Modifying Value Types from Within Instance Methods**

* 구조체, 열거형은 값타입이므로 인스턴스 매소드 내에서 값타입의 프로퍼티는 기본적으로 변경 불가,
* mutating 키워드를 이용하여 매소드가 계산이 끝난후 원본 구조체에 그결과를 덮어써 변경

~~~swift
struct Point {
  var x = 0.0, y = 0.0
  mutating func moveBy(x dletaX: Double, y deltaY: Double) {
    x += deltaX
    y += deltaY
  }
}
var somePoint = Point(x: 1.0, y: 1.0)
somePoint.moveBy(x: 2.0, y: 3.0)
print("(\(somePoint.x), \(somePoint.y))")	// (3.0, 4.0)
~~~

**Assigning to  self Within a Mutating Method**

* mutating 매소드에 self 프로퍼티를 이용해 완전 새로운 인스턴스를 생성 가능

~~~swift
struct Point {
  var x = 0.0, y = 0.0
  mutating func moveBy(x deltaX: Double, y deltaY: Double) {
    self = Point(x: x + deltaX, y: y + deltaY)
  }
}
enum TriStateSwitch {
  case off, low, high
  mutating func next() {
    switch self {
      case .off:
      	self = .low
      case .low:
      	self = .high
      case .high:
      	self = .off
    }
  }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()	// ovenLight .high
ovenLight.next()	// ovenLight .off
~~~

#### Type Methods

* 인스턴스 매소드는 특정 타입의 인스턴스에서 호출되며, 타입매소드는 특정 타입 자체에서 호출
* 인스턴스 매소드의 선언은 매소드 키워드 func 앞에 static, class 키워드를 붙임

~~~~swift
class SomeClass {
	class func sometypeMethod() {
  }
}
SomeClass.someTypeMethod()	// 타입 매소드 호출

struct LevelTracker {
  static var highestUnlockedLevel = 1
  var currentLevel = 1
  static func unlock(_ level: Int) {
    if level > highestUnlockedLevel { hightestUnlockedLevel = level }
  }
  static func isUnlocked(_ level: Int) -> Bool {
    return level >= hightestUnlockedLevel
  }
  @discardableResult	// 이 결과 값을 버릴수 있는 결과 값으로 표시하여 경고가 발생 안되도록 처리
  mutating func advance(to level: Int) -> Bool {
    if LevelTracker.isUnlocked(level) {
      currentLevel = level
      return true
    } else {
      return false
    }
  }
}

class Player {
  var tracker = LevelTracker()
  let playerName: String
  func complete(level: Int) {
    LevelTracker.unlock(level + 1)
    tracker.advance(to: level + 1)
  }
  init(name: String) {
    playerName = name
  }
}
var player = Player(name: "Argyrios")
prlayer.complete(level: 1)
print("\(LevelTracker.highestUnlockedLevel)")	// 2

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
  print("level 6")
} else { 
	print("level 6 has not yet")
}	// level 6 has not yet
~~~~

