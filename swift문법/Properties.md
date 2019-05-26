# Properties

* Class, Structures, Enumerations와 관련되 값
* Stored, Computed Properties 가 있으며, Stored는 값을 저장, Computed는 특정하게 계산한 값을 반환 해주는 프로퍼티
* Computed Properties는 Class, Structures, Enumerations에서 모두 사용 가능
* Stored Properties는 Class, Structures 만 사용가능

#### Stored Properties

~~~ swift
struct FixedLengthRange {
  var firstValue: Int
  let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3) // 0..<3
rangeOfThreeItems.firstValue = 6	// 6..<9
~~~

**Stored Properties of Constant Structures Instances**

* 구조체를 let으로 선언하면 그 인스턴스의 프로퍼티 수정 불가
* 클래스는 let으로 선언해도 그 인스턴스는 프로퍼티 수정 가능

**Lazy Stored Properties**

* 값이 처음으로 사용되기 전에 계산 되지 않는  프로퍼티, lazy 키워드 사용
  * 반드시 var로 선언 (lazy var somepropertie)

~~~swift
class DataImporter { // 외부에서 파일을 읽어오는 클래스 시간이 많이 걸린다고 가정
  var fileName = "data.txt"
}
class DataManager {	// 테이터 관리 클래스로 가정
  lazy var importer = DataImporter()
  var data = [String]()
}
let manager = DataManaager()
manager.data.append("Some data")
manager.data.append("some more data") // importer 는 아직 초기화 전

print(manager.impoter.filename)	// DataImporter 인스턴스 생성
~~~

#### Computed Properties

* 실제 값을 저장하는 것이 아닌 getter와 Optional한 setter를 재공하여 값을 탐색하고 간접적으로 다른 프로퍼티 값을 설정

~~~swift
struct Point {
  var x = 0.0, y = 0.0
}
struct Size {
  var width = 0.0, height = 0.0
}
struct Rect {
  var origin = Point()
  var size = Size()
  var center: Point {
    get {
      let centerX = origin.x + (size.width / 2)
      let centerY = origin.y + (size.height / 2)
      return Point(x: centerX, y: centerY)
    }
    set(newCenter) {
      origin.x = newCenter.x - (size.width / 2)
      origin.y = newCenter.y - (size.height / 2)
    }
  }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), 
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("\(square.origin.x), \(square.origin.y)")	// 10.0, 10.0
~~~

* x, y좌표가 어떤 값을 가져야 하는지 계산해서 x, y에 적절한 좌표값을 넣음

**Shorthand Setter Declaration**: 위 코드 중(newCenter)라고 지정하지 않는 경우 newValue로 사용

**Read-Only Computed Properties**: getter만 있고 setter를 제공하지 않을 경우  읽기전용 계산 프로퍼티

~~~swift
struct cuboid {
  var width = 0.0, height = 0.0, depth = 0.0
  var volume: Double {
    return width * height * depth
  }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("\(fourByFivebyTwo.volume)")	// 40.0
~~~

#### Property Observers

* 새 값이 설정될 때마다 감지 할 수 있는 옵저버를 제공, 새값과 이전 값이 같더라도 항상 호출
* lazy store propertie에서는 사용 불가, compued property의 경우 setter 에서 감지 가능
* **willSet**: 값이 저장되기 바로 직전 호출, 새 값에 파라미터명을 지정가능, 지정 안할 사 newValue 사용
* **didSet**: 새 값이 저장되고 난 직후에 호출 됨, 바뀌기 전의 값의 파라미터명을 지정 가능, 지정 안할 시 oldValue 사용

~~~swift 
class StepCounter {
  var totalSteps: Int = 0 {
    willSet(newTotalSteps) {
      print("Set \(newTotalSteps)")
    }
    didSet {
      if totalSteps > oldValue {
        print("Add \(totalSteps - oldValue)")
      }
    }
  }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200	// Set 200	// Add 200
stepCounter.totalSteps = 360	// Set 360	// Add 160
stepCounter.totalSteps = 896	// Set 896	// Add 536
~~~

#### Global and Local Variables

* Computed properties, Opsevers properties 기능은 전역, 지역 변수 모두에서 사용 가능

#### Type Properties

* 인스턴스 프로퍼티: 특정 인스턴스에 속한 프로퍼티, 새로운 인스턴스가 생성될 때마다 새로운 프로퍼티도 생성
*  타입 프로퍼티: 특정 타입에 속한 프로퍼티로 그타입에 해당하는 하나의 프로퍼티만 생성

**Type Property Syntax**: static 키워드를 사용, 클래스에서는 static, class 2가지 타입 프로퍼티를 선언 가능하며, 두가지 타입의 차이는 자식클래스에서 overriding 가능 여부, class로 선언된 프로퍼티는 서브클래스에서 overriding 가능

~~~swift
struct SomeStructure {
  static var storedTypeProperty = "Some value."
  static var computedtypeProper: Int {
    return 1
  }
}
enum SomeEnumeration {
  static var storedTypeProperty = "Some value."
  static var computedTypeProperty: Int {
    return 6
  }
}
class SomeClass {
  static var storedTypeProperty = "Some value."
  static var computedTypeProperty: Int {
    return 27
  }
  class var overrideableComputedTypeProperty: Int {
    return 107
  }
}
print(SomeStructure.storedTypeProperty)			// Some value.
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)			// Another value.
print(SomeEnumeration.computedTypeProperty)	// 6
print(SomeClass.computedTypeProperty)				// 27
~~~

