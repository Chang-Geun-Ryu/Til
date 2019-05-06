# Enumerations

* 관련된 값으로 이루어진 그룹을 공통의 type으로 선언해 type-safety를 보장하는 방법으로 코드를 구현
* 열거형에 case값이 String, Int, Double 값들을 사용 가능
* 1급 클래스 형으로 계산된 프로퍼티를 제공하거나 초기화를 지정하거나, 초기 선언을 확장해사용 가능

#### Enumeration Syntax

* Enum 키워드를 사용하여 정의

~~~swift
enum CompassPoint {
  case north
  case south
  case east
  case west
}

enum planet { 
	case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
var directionToHead = CompassPoint.west
~~~

#### Switch 구문에서 열거형 값 매칭

~~~swift
directionToHead = .south // type 생략 문법
switch CompassPoint { // switch문은 반드시 열거형의 모든 경우를 완전히 포함 해야 함
case .north:
	print("Lots of planets have a north")
case .south:
	print("Watch out for penquins")
case .east:
	print("Where the sun rises")
case .west:
	print("Where the skies are blue")
}	// Watch out for penguins
~~~

#### Associated Values

* 각 case에 custom type의 추가적인 정보를 저장 가능

~~~swift
enum Barcode {
  case usc(Int, Int, Int, Int)
  case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
  print("UPC: \(numberSystem), \(manufacturer), \(product), \(check)")
case let .qrCode(productCode):
  print("QR code: \(productCode).")
}	// QR code: productCode.
~~~

#### Raw Values

* case에 raw 값을 지정 가능

~~~swift
enum ASCIIControlCharacter: Character {
  case tab = "\t"
  case lineFeed = "\t"
  case carriageReturn = "\t"
}
~~~

* Character, String, Int, Float, Double 형을 raw 값으로 선언 가능, 단 유일한 값으로 지정

**암시적으로 할당된 Raw 값**

* 열거형을 다루면서 raw 값으로 Integer나 String 값을 사용가능

~~~swift
enum Planet: Int {
  case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
} // mercury에 1을 raw 값으로 명시적으로 할당, venus는 암시적으로 2 이후 값은 1증가 된값을 raw 값으로 갖음, String은 raw 값으로 case text를 자동으로 raw 값으로 할당
~~~

**Raw 값을 이용한 초기화**

~~~swift
let possiblePlanet = Planet(rawValue: 7)	// .uraus

let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {	// raw 값이 없는 초기자를 지정하면 nil
  switch somePlanet {
    case .earth:
    	print("지구")
    default:
    	print("다른 것")
  }
} else {
  print("\(positionToFind)")
} // 11
~~~

**Recursive Enumerations**

* 재귀 열거자는 다른 열거 인스턴스를 관계 값으로 갖는 열거형, case 앞에 indirect 키워드를 붙임

~~~swift
enum ArithmeticExpression {
  case number(Int)
  indirect case addition(ArithmeticExpression, ArithmeticExpression)
  indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
~~~

* 관계 값을 갖는 모든 열거형 case 에 indirect 표시 하려면, enum 키워드 앞에 indirect 표시

~~~swift
indirect enum ArithmeticExpression {
  case number(Int)
  case addition(ArithmeticExpression, ArithmeticExpression)
  case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
// 재귀 열거자 처리함수
func evaluate(_ expression: ArithmeticExpression) -> Int {
  switch expression {
    case let .number(value):
    	return value
    case let .addtion(left, left):
    	return evaluate(left) + evaluate(right)
    case let .multiplication(left, right)
    	return evaliate(left) * evaluate(right)
  }
}
print(evaluate(product)) // 18

~~~

