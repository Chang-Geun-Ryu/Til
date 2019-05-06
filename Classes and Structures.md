# Classes and Structures

* OOP를 위한 필요 요소, swift는 interface파일과 implementation 파일을 분리해서 만들기 않음

#### Comparing Classes and Structures

공통기능

* 값을 저장하기 위한 프로퍼티 정의
* 기능을 제공하기 위한 매소드 정의
* subscript 문법을 이용해 특정 값을 접근할 수 있는 subscript 정의
* 초기상태를 설정할 수 있는 initializer 정의
* 기본 구현에거 기능 확장
* 특정한 종류의 표준 기능을 제공하기 위한 프로토콜 순응

클래스만 가능한 기능

* 상속(Inheritance): 클래스의 여러 속성을 다른 클래스에 물려줌
* 타입 캐스팅(Type casting): 런타임에 클래스 인스턴스의 타입을 확인
* 소멸자(Deinitializer): 할당된 자원을 해제 시킴
* 참조 카운트(Reference Counting): 클래스 인스턴스에 하나 이상의 참조가 가능

~~~swift
struct Resolution {
  var width = 0
  var height = 0
}
class VideoMode {
  var resolution = Resolution()	// 구조체 값 사용
  var interlaced = false
  var frameRate = 0.0
  var name: String?
}
let someResolution = Resolution()	// 구조체 인스턴스 생성
let someVideoMode = VideoMode()		// 클래스 인스턴스 생성
let vga = Resolution(width: 640, height: 480) // 맴버 초기화
~~~

#### Structures and Enumerations Are Value Types

* 값타입이란, 함수에서 상수나 변수에 전달될 때 값이 복사되서 전달 되는 의미

~~~swift
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd	// 값 복사되었기 때문에 hd와 cinema는 다른 인스턴스
cinema.width = 2048
print("\(cinema.width), \(hd.width)")	// 2048, 1080

enum ComassPoint {
  case north, south, east, west
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection = .east	// enum도 값 복사
if rememberedDirection == .west {
  print(".west")
}	// .west
~~~

* 다른 이스턴스의 변화는 그 인스턴스에만 영향을 끼치고 다른 것에 영향이 없음

#### Classes Are Reference Types

* 참조 타입이란, 변수나 상수에 값을 할당을 하거나 함수에 인자로 전달할 때 값이 복사되지 않고 참조 함
* 참조는 값을 가지고 있는 메모리를 바라 보고 있다는 의미

~~~swift
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("\(tenEighty.frameRate)")	// 30.0
~~~

* 상수 alsoTenEighty의 값이 변경되는 것이 아닌 바라보고 있는 메모리의 값을 변경하기 때문

**Identity Operators**: class는 참조 타입이기 때문에 상수와 변수에서 같은 인스턴스를 참조 가능, 같은 이스턴스를 참조하고 있는지 비교하기 위해 식별 연산자를 사용

* **===** : 두 상수나 변수가 같은 이스턴스를 참조하면 참
* **!==** : 두 상수나 변수가 다른 인스턴스를 참조하고 있는 경우 참

~~~swift
if tenEighty === alsoTenEighty {
  print("equal")
} // equal
~~~

#### Choosing Between Classes and Structures

구조체 사용하는것을 고려해 볼수 있는 경우

* 구조의 주 목적이 관계된 값을 캡슐화하기 위한 것인 경우
* 구조의 인스턴스가 참조되기 보다 복사되기 기대하는 경우
* 구조에 의 해 저장된 어떠한 프로퍼티가 참조되기 보다 복사되기를 기대하는 경우
* 구조가 프로퍼티나 매소드 등을 상속할 필요가 없는 경우

위 기술된 경우를 제외한 다른 모든 경우에는 클래스를 사용

#### Assignment and Copy Behavior for Stirngs, Arrays, and Dictionaries

* String, Array, Dictionary 같은 기본 데이터 타입이 구조체로 구현
* NSSting, NSArray, NSDictionary는 클래스로 구현