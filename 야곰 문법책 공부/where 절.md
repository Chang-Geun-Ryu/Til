# where 절

* Where 절은 특정 패턴과 결합하여 조건을 추가하는 역활
* 조건을 추가하고 싶을 때, 특정 타입에 베한을 두고 싶을때 등 활용

#### where 절의 활용

* 패턴과 결합하여 조건 추가, 타입에 대한 제약 추가
* 특정 패턴에 Bool타입 조건으 지정하거나 어떤 타입의 특정 프로토콜 준수 조건을 추가하는 기능 등이 있음

```swift
let tuples: [(Int, Int)] = [(1,2), (1,-1), (1,0),(0,2)]
// 값바인딩, 와일드 카드 패턴
for tuple in tuples{
    switch tuple {
    case let (x,y) where x == y: print("x == y")
    case let (x,y) where x == -y: print("x == -y")
    case let (x,y) where x > y: print("x > y")
    case (1,_): print("x == 1")
    case (_,2): print("y == 2")
    default: print("\(tuple.0), \(tuple.1)")
    }
} // x == 1, x == -y, x > y, y == 2

var repeatCount: Int = 0
for tuple in tuples {
    switch tuple {
    case let (x,y) where x == y && repeatCount > 2: print("x == y")
    case let (x,y) where repeatCount < 2: print("\(x), \(y)")
    default: print("Nothing")
    }
    repeatCount += 1
} // 1, 2 // 1, -1 // Nothing // nothing
let firstValue: Int = 50
let secondValue: Int = 30
// 값바인딩 패턴
switch firstValue + secondValue {
case let total where total > 100: print("total > 100")
case let total where total < 0: print("wrong value")
case let total where total == 0: print("zero")
case let total: print(total)
} // 80
```

* 옵셔널 패턴과 결합된 where

```swift
let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]
for case let number? in arrayOfOptionalInts where number > 2 {
    print("Found a \(number)")
} // Found a 3 // Found a 5
```

* 타입캐스팅 패턴과 결합된 where

```swift
let anyValue: Any = "ABC"
switch anyValue {
case let value where value is Int: print("value is Int")
case let value where value is String: print("value is String")
case let value where value is Double: print("value is Double")
default: print("Unknown")
}
var things: [Any] = [Any]()
things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("Hello")
things.append((3.0, 5.0))
things.append({(name: String) -> String in "Hello, \(name)"})

for thing in things {
    switch thing {
    case 0 as Int:
    print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where  someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x,y) as (Double, Double):
        print("an (x,y) point at \(x), \(y)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
} 
// zero as an Int // zero as a Double // an integer value of 42
// a positive double value of 3.14159 
// a string value of "hello"
// an (x,y) point at 3.0, 5.0
// Hello, Michael
```

* Where 절을 표현 패턴으로 결합 가능

```swift
var point: (Int, Int) = (1, 2)
switch point {
case (0,0): print("원점")
    case (-2...2, -2...2) where point.0 != print("\(point.0), \(point.1)은 원점과 가깝습니다.")
default: print("point \(point.0), \(point.1)")
} // point (1,2)
```

* 프로토콜 익스텐션에 where 절을 사용하면 특정 프로토콜을 준수 하는 타입에만 적용 될수 있도록 제약 가능
* where 절 이후에 제시되는 프로토콜을 준수하는 타입만 익스텐션이 적용

```swift
struct Person: SelfPrintable {}
extension Int: SelfPrintable {}
extension UInt: SelfPrintable {}
extension String: SelfPrintable {}
extension Double: SelfPrintable {}

extension SelfPrintable where Self: BinaryInteger, Self: Comparable {
    func printSelf() {
        print("BinaryInteger와 Comparable을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}
extension SelfPrintable where Self: CustomStringConvertible {
    func printSelf() {
        print("CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}
extension SelfPrintable {
    func printSelf() {
        print("그외 SelfPrintable을 준수하는 타입 \(type(of:self))")
    }
}
// BinaryInteger와 Comparable을 준수하면서 SelfPrintable을 준수하는 Int 타입
Int(-8).printSelf()
// BinaryInteger와 Compareble을 준수하면서 SelfPrintable을 준수하는 UInt타입
UInt(8).printSelf()
// CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 String 타입
String("RCG").printSelf()
//CustomStringConvertible을 준수하면서 SelfPrintable을 준수하는 Double
Double(8.0).printSelf()
Person().printSelf()

```

* 타입 매개변수와 연관 타입의 제약을 추가하는 데 where절이 사용 가능
* 제네릭 메서드의 반환 타입 뒤에 where 절을 포함하면 타입 매개변수와 연관 타입에 요구사항을 추가, 요구사항이 여러개일 경우 쉼표로 구별
* 제네릭의 where절을 사용한 요구사항은 타입 매개변수가 특정 클래스를 상속 받았는지 또는 특정 프로토콜을 준수하는지 표현

```swift
// 타입 매개변수 T가 binaryInteger 프로토콜을 준수하는 타입
func double<T>(integerValue: T) -> T where T: BinaryInteger {
    return integerValue * 2
}
// 위 함수와 같음
func double<T: BinaryInteger>(integerValue: T) -> T {
    return integerValue * 2
}
// 타입매개 변수 T와 U가 CustomStringConvertible 프로토콜을 준수하는 타입
func prints<T, U>(first: T, second: U) where T: CustomStringConvertible, U: CustomStringConvertible {
    print(first)
    print(second)
}
//위 함수와 같음
func print<T: CustomStringConvertible, U: CustomStringConvertible>(first: T, second: U) {
    print(first)
    print(second)
}
// 타입 매개변수 S1과 S2가 Squence 프로토콜을 준수하며, S1과 S2가 준수하는 프로토콜인 Sequence 프로토콜dml dusrhks xkdlqdls SubSequence가 같은 타입
func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S1.SubSequence: Equatable, S2: Sequence, S2.SubSequence: Equatable {
    // ...
}
// 위 함수와 같음
func compareTwoSequences<S1, S2>(a: S1, b: S2) where S1: Sequence, S2: Sequence, S1.SubSequence: Equatable, S1.SubSequence == S2.SubSequence {
    // ...
}
// 위 함수와 같음
func compareTwoSequences<S1: Sequence, S2: Sequence>(a: S1, b: S2) where S1.SubSequence: Equatable, S1.SubSequence == S2.Iterator.Element {
    // ...
}
// 프로토콜의 연관 타입에도 타입 제약 가능
protocol Container {
    associatedtype ItemType where ItemType == BinaryInteger
    var count: Int {get}
    mutating func append(_ item:ItemType)
    subscript(i: Int) -> ItemType {get}
}
// 위와 같은 표현
protocol Container where Itemtype == BinaryInteger {
    associatedtype ItemType
    var count: Int {get}
    mutating func append(_ item: ItemType)
    subscript(i: Int) -> ItemType {get}
}
```

* where 절은 다른 패턴과 조합하면 원하는 추가 요구사항을 자유롭게 추가 가능
* 익스텐션과 제네릭에 사용하면 프로토콜 또는 타입에 대한 게약을 추가 가능
* 조건구문이나 논리 연산으로 구현한 코드보다 명확하고 간편하게 사용 가능