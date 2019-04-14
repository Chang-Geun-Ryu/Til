# ARC

* 참조타입은 하나의 인스턴스가 참조를 통해 여러곳을 접근하기 때문에 언제 어디서 메모리가 해제 되는지가 중요한 문제
* 인스턴스가 적절한 시점에서 해제되지 않으면 한정적인 메모리자원을 낭비하여 전체적인 성능 저하로 이어짐
* 스위프트는 메모리 관리 기법으로 ARC를 사용

#### ARC란

* Automatic Reference Counting으로 자동으로 메모리를 관리
* 더이상 필요하지 않은 클래스의 인스턴스를 메모리에서 해제하는 방식으로 동작
* ARC의 참조 카운팅 시점: 컴파일 시

**장점**

* 컴파일 당시 이미 인스턴스의 해제 시점이 정해져 있어 인스턴스가 언제 메모리에서 해제될지 예측
* 컴파일 당시 이미 인스천스의 해제 시점이 정해져 있어 메모리 관리를 위한 시스템 자원이 불필요

**단점**

* ARC의 작동 규칙을 모르고 사용하면 인스턴스가 메모리에서 영원히 해제되지 않을 가능성이 존재

#### 강한참조

* 인스턴스가 계속 메모리에 남아 있어야 하는 명분을 만들어주는 것
* 인스턴스는 참조 횟수가 0 이 되는 순간 메모리에서 해제
* 인스턴스를 프로퍼티, 변수, 상수,에 할당할 때 강한참조를 사용하면 참조 횟수가 1 증가
* 강한참조를 사용하는 프로퍼티, 변수, 상수 등에 nil을 할당하면 할당되어 있던 인스턴스의 참조 횟수가 1 감소
* 참조의 기본은 강한참조이며, 클래스 타입의 프로퍼티, 변수, 상수 등을 선언할 때 별도의 식별자를 사용하지 않으면 강한참조

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initalized")
    }
    deinit {
        print("\(name) is being deinitialzed")
    }
}
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "rcg")// rcg is being initailized 참조 횟수 1 증가
reference2 = reference1 // 인스턴스 참조 횟수 : 2
reference3 = reference1 // 인스턴스 참조 횟수 : 3

reference3 = nil    // 인스턴스의 참조 횟수 : 2
reference2 = nil    // 인스턴스의 참조 횟수 : 1
reference1 = nil    // 인스턴스의 참조 횟수 : 0 rcg is being deinitialzed
func foo() {
    // 인스턴스 참조 횟수 : 1
    let yagom: Person = Person(name: "yagom") // yagom is being initialzed
  
    //함수 종료 시점 인스턴스의 참조 횟수 : 0
} // yagom is being deinitialized
foo()
```

#### 강한참조순환 문제

* **강한참조의 순환**: 인스턴스끼리 서로가 서로를강한 잠조를 할 때

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
    var room: Room?
    deinit {
        print("\(name) is being deinitialized")
    }
}
class Room {
    let number: String
    init(number: String) {
        self.number = number
    }
    var host: Person?
    deinit {
        print("Roo, \(number) is being deinitialized")
    }
}
var yagom: Person? = Person(name: "yagom") // Person 참조 횟수: 1
var room: Room? = Room(number: "505") // Room 참조 횟수: 1
room?.host = yagom // Person 참조 횟수: 2
yagom?.room = room // Room 참조 횟수: 2
yagom = nil // Person 참조 횟수: 1
room = nil  // Room 참조 횟수: 1
// Person 인스턴스 참조할 방법 상실 - 메모리 잔존
// Room 인스턴스 참조할 방법 상실 - 메모리 잔존
```

* deinit이 호출이 안되어 메모리가 호출 되지 않고 잔존

#### 약한참조

* 강한참조와 달리 자신이 참조하는 인스턴스의 참조 횟수를 증가 시키지 않음
* 참조 타입의 프로퍼티나 변수 선언 앞에 weak 키워드 선언

```swift
class Room {
    let number: String
    init(number: String) {
        self.number = number
    }
    weak var host: Person?
    deinit {
        print("Roo, \(number) is being deinitialized")
    }
}
var yagom: Person? = Person(name: "yagom") // Person 참조 횟수: 1
var room: Room? = Room(number: "505") // Room 참조 횟수: 1
room?.host = yagom // Person 참조 횟수: 1
yagom?.room = room // Room 참조 횟수: 2

yagom = nil // Person 참조 횟수: 0, Room 인스턴스 참조 횟수: 1
// yagom is being deinitialized
print(room?.host) // nil
room = nil  // Room 참조 횟수: 0
// Room 505 is being deinitialized
```

* Room클래스의 host프로퍼티에 weak 키워드를 붙여 약한 참조 변수로 할당
* Person클래스를 참조가 사라질때 Room 참조 횟수도 같이 줄어드는 효과

#### 미소유참조

* 참조 횟수를 증가 시키지 않는 인스턴스의 종류
* 미소유 참조는 인스턴스가 항상 메모리에 존재 할것을 전제로 한 키워드
* 자신이 참조하는 인스턴스가 해제되어도 스스로 nil을 할당 하지 않음
* 미소유참조를 하는 변수나 프로퍼티는 옵셔널이나 변수가 아니어도 상관 없음
* 참조타입의 변수나 프로퍼티 정의 앞에 unowned 키워드를 사용\

```swift
class Person {
    let name: String
    // 카드를 소지할 수조, 소지하지 않을 수도 있시 때문에 옵셔널로 정의
    // 카드를 한번 가진후 잃어버리면 안 되기 때문에  강한 참조를 해야함
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name), is being deinitialized")
    }
}
class CreditCard {
    let number: UInt
    unowned let owner: Person // 카드는 소유가자 분명히 존재
    init(number: UInt, owner: Person) {
        self.number = number
        self.owner = owner
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}
var jisoo: Person? = Person(name: "jisoo") // Person 인스턴스의 참조 횟수: 1
if let person: Person = jisoo {
    // CreditCard 인스턴스 참조 횟수: 1
    person.card = CreditCard(number: 1004, owner: person)
    // Person 인스턴스의 참조 횟수: 1
}
jisoo = nil // Person 인스턴스의 참조 횟수 : 0
// CreditCard 인스턴스의 참조 횟수 : 0
// jisoo is being deinitialized
// Card #1004 is being deinitialized
```

#### 미소유참조와 암시적 추출 옵셔널 프로퍼티

* 서로 참조해야 하는 프로퍼티에 값이 꼭 있어야 하면서 한번 초기화되면 그이후에는 nil을 할당할 수 없는 조건을 갖추는 경우

```swift
class Person {
    let name: String
    // 카드를 소지할 수조, 소지하지 않을 수도 있시 때문에 옵셔널로 정의
    // 카드를 한번 가진후 잃어버리면 안 되기 때문에  강한 참조를 해야함
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name), is being deinitialized")
    }
}
class CreditCard {
    let number: UInt
    unowned let owner: Person // 카드는 소유가자 분명히 존재
    init(number: UInt, owner: Person) {
        self.number = number
        self.owner = owner
    }
    deinit {
        print("Card #\(number) is being deinitialized")
    }
}
var jisoo: Person? = Person(name: "jisoo") // Person 인스턴스의 참조 횟수: 1
if let person: Person = jisoo {
    // CreditCard 인스턴스 참조 횟수: 1
    person.card = CreditCard(number: 1004, owner: person)
    // Person 인스턴스의 참조 횟수: 1
}
jisoo = nil // Person 인스턴스의 참조 횟수 : 0
// CreditCard 인스턴스의 참조 횟수 : 0
// jisoo is being deinitialized
// Card #1004 is being deinitialized

class Company {
    let name: String
    // 암시적 추출 옵셔널 프로퍼티 (강한 참조)
    var ceo: CEO!
    init(name: String, ceoName: String) {
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    func introduce() {
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}
class CEO {
    let name: String
    // 미소유참조 상수 프로퍼티
    unowned let company: Company
    init(name: String, company: Company) {
        self.name = name
        self.company = company
    }
    func introduce() {
        print("\(name)는 \(company.name)의 CEO입니다.")
    }
}
let company: Company = Company(name: "무한상사", ceoName: "김태호")
company.introduce() // 무한상사의 CEO는 김태호 입니다.
company.ceo.introduce() // 김태호는 무한상사의 CEO입니다.
```

#### 클로저의 강한참조 순환

* 클로저는 참조타입이기 때문에 클로저를 클래스의 인스턴스의 프로퍼티로 할당하면 클로저의 참조가 할당되어 서로 강한 참조로 할당되기 때문에 강한 참조 순환 문제 발생

```swift
class Person {
    let name: String
    let hobby: String?
    lazy var introduce: () -> String = {
        var introduction: String = "My name is \(self.name)"
        guard let hobby = self.hobby else {
            return introduction
        }
        introduction += " "
        introduction += "My hobby is \(hobby)."
        return introduction
    }
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}
var yagom: Person? = Person(name: "yagom", hobby: "eating")
print(yagom?.introduce()) // My name is yagom. My hobby is eating
yagom = nil
```

* lazy로 선언된 introduce 프로퍼티를 통해 클로저를 호출하면 클로저는 자신의 내부에 있는 참조 타입 변수 등을 획득
* 크로저는 자신이 호출되면 언제든지 자신 내부의  참조들을 사용할수 있도록 자신의 참조 횟수를 증가시켜 메모리에 해제되는 것을 방지 함
* 문제는 자신의 참조 횟수를 증가 시키면서 자신을 프로퍼티로 갖는 인스턴스의 참조 횟수도 증가 시킴으로 **강한참조 순환이 발생**

**획득목록**

* 위의 참조 순환 문제는 **획득목록**을 통해 해결 가능, 클로저 내부에 참조타입을 획득하는 규칙을 제시해 줄 수 있는 규칙을 제시하믄 기능
* 클로저 내부의 self참조를 약한 참조, 강한참조로 지정 가능 하도록 지정 가능한 기능
* 획득목록은 클로저 내부의 매개 변수 목록 이전 위치에 작성, []로 둘러싼 목록 형식으로 작성하며 획득목록 뒤에 in 키워드를 작성
* 획득목록에 명시된 요소가 참조 타입이 아니라면해당 요소들은 클로저가 생성될 때 초기화

```swift
var a = 0
var b = 0
let clousre = { [a] in
    print(a,b)
    b = 20
}
a = 10
b = 10
clousre() // 0 10
print(a,b)// 10 20
```

* 참조타입의 경우 초기화는 이뤄지지 않음

```swift
class SimpleClass {
    var value: Int = 0
}
var x = SimpleClass()
var y = SimpleClass()
let closure = { [x] in
    print(x.value, y.value)
}
x.value = 10
y.value = 10
clousre() // 10, 10
```

* 획득목록에서의 참조 타입은 어떤 방식으로 참조 할것인지 결정, 참조 횟수를 증가 시킬것인지 결정
* 강한 획득, 약한 획득, 미소유 획득을 결정
* 약한 획득의 경우 획득 목록에서 상수가 옵셔널 상수로 지정 됨

```swift
class SimpleClass {
    var value: Int = 0
}
var x: SimpleClass? = SimpleClass()
var y = SimpleClass()
let closure = { [weak x, unowned y] in
    print(x?.value, y.value)
}
x = nil
y.value = 10
closure() // nil, 10
```

* y의 경우 미소유 참조를 했기 때문에 클로저가 참조 횟수를 증가 시키지 않지만, 메모리에서 해제된 상태에서 사용하려한다면 실행 중에 오류로 강제종료 가능성이 있음
* 문제의 소지가 있을 때는 약한 참조를 해야 함

