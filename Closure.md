#Closures

* 전역함수: 이름이 있고 어떤값도 캡쳐하지 않는 클로저
* 중첩함수: 이름이 있고 관련한 함수로 부터 값을 캡쳐 할 수 있는 클로저
* 클로저 표현: 경량화 된 문법으로 쓰여지고 관련된 context으로부터 값을 캡쳐할 수 있는 이름이 없는 클로저

 swift에서 closure 표현은 최적화 되어서 간결하고 명확

* context에서 prameter type과 return type의 추론
* 단일 표현 클로저에서의 암시적 반환
* 축약된 인자 이름
* 후휘 클로저 문법

#### Closure Expressions

* 클로저의 표현은 코드의 명확성과 의도를 잃지 않으면서 문법을 축약해 사용할 수 있는 다양한 문법의 최적화 제공

**Sorted Method**: sorted(by:)  알려진 타입의 배열 값을 정렬하는 매스드의 by: 에 해당하는 어떤 방법으로 정렬을 수행할 것인지에 대해 기술한 클로저를 넣으면 기술된 클로저 대로 정렬된 배열 반환 가능

sorted(by:) 매소드는 배열의 콘텐츠와 같은 타입을 갖고 두개의 인자를 갖는 클로저를 인자로 사용

~~~swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
  return s1 > s2
}
var reversedNames = name.sorted(by: backward) // ["Ewa", "Deniella", "Chris", "Barry", "Alex"]
~~~

**Closure Expression Syntax**

~~~swift
{ (parameters) -> return type in	// 인자로 넣을 prameters, return type
  statements											// 인자 값을 처리할 statements
}
reveredNames = names.sored(by: { (s1: String, s2: String) -> Bool in
	return s1 > s2                               
})
~~~

* 위 코드와 같이 따로 정의된 형태가 아닌 인자로 들어가 있는 형태의 클로저를 **인라인 클로저**라 함, 클로저의 몸통은 in 키워드 다음에 시작하며 parameters, returns type을 알고 있으며 코드가 짧아 한줄로 표현 가능

~~~swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })
~~~

**Inferring Type from Context (문맥에서 타입 추론)**

* 정렬 클로저는 String 배열에서 sored(by:) 매소드의 인자로 사용, 매소드에서 (String, String) -> Bool 타입의 인자가 들어와야 하는지 알기 때문에 클로저에서 타입들은 생략 가능

~~~swift
reversedNames = names.sorted(by: {s1, s2 in returns s1 > s2})
~~~

**Shorthand Arguments Names(인자 이름 축약)**

* swift는 인라인 클로저에 자동으로 축약 인자 이름을 제공, 인자값의 순서대로 \$0, \$1, \$2 등으로 사용 가능
* 축약 인자 이름을 사용하면 인자 값과 그 인자로 처리할 때 사용하는 인자가 같다는 것을 알기에 인자 입력과 in 키워드 생략 가능

~~~swift
reversedNames = names.sorted(by: { $0 > $1 })
~~~

**Operator Methods(연산자 매소드)**

* swift의 Stirng 타인 연산자에는 String끼리 비교할 수 있는 비교 연산자 (>) 구현

~~~swift
reservedNames = names.sorted(by: >)
~~~

#### Trailing Closures

* 함수의 마지막 인자로 클로저를 넣고 그 클로저가 길다면 후위 클로저를 사용 가능

~~~swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
  // function body here
}

someFunctionThatTakesAClosure(closure: {	// 인자 값 입력 부분과 반환 형 부분을 생략
  // closure's body goes here
})

someFunctionThatTakesAClosure() {	// 후위 클로저의 표현
  // trailing closure's body goes here
}
~~~

* 앞 예제의 후위 클로저 표현

~~~swift
reversedNames = names.sorted() { $0 > $1 }
// 후위 클로저 사용시 () 생략 가능
reversedNames = names.sorted { $0 > $1 }
~~~

* 후위 클로저를 이용한 Int를 Stirng으로 Mapping하는 예제

~~~swift
let figitNames = [
  0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
~~~

* map(_:)을 이용해 특정 값을 다른 특정 값으로 매핑하는 크로저를 구현

~~~swift
let string = numbers.map { ( number) -> String in
	var number = number
  var output = ""
	repeat {
    output = digitNames[number % 10]! + output
    number /= 10
  } // let Strings는 타입 추론으로 [Stirng] 형
}	// ["OneSix", "FiveEight", "FiveOneZero"]
~~~

* numver값은 상수 인데, 이 상수 값을 클로저 안에서 변수 var로 재정의 했기에 값 변환이 가능

#### Capturing Values

* 특정 문맥의 상수나 변수의 값을 캡쳐 가능, 원본값이 사라져도 크로저의 Body 안에서 값 활용 가능

~~~swift
func makeIncrementer(forIncrementer amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer // 반환값이 클로저
} 
~~~

~~~swift
func incrementer() -> Int {
  runningTotal += amount
  return runningTotal
}	// runningTotal과 amount가 선언되어 있지 않지만 실행 가능 runningTotal과 amount가 캡쳐링

let incrementByTen = makeIncrementer(forIncrement: 10) // incrementer 매소드 반환
incrementByTen()	// 10을 반환
incrementByTen()	// 20을 반환
incrementByTen()	// 30을 반환
~~~

#### Closures Are Reference Types

* incrementByTen은 상수이지만 runningTotal 변수를 계속 증가 시킬수 있는 이유는 클로저는 참조 타입이기 때문

~~~swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen() // 50 반환
~~~

#### Escaping Closures

* 클로저를 함수의 파라미터로 넣을 수 있으며, 함수 밖에서 실행되는 클로저, 비동기로 실행되거나 copletionHandler로 사용되는 클로저는 파라미터 타입 앞에 @escaping 이라는 키워드를 명시

~~~swift
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
  completionHandler.append(completionHandler)
} // 인자로 전달된 completionHandler는 someFunctionWithEscapingClosure 함수가 끝나고 나중에 처리, 만약 함수가 @escaping 키워드를 붙이지 않으면 컴파일시 오류 발생
~~~

* @escaping을 사용하는 클로저는 self를 명시적으로 사용해야 함

~~~swift
func someFuntionWithNonescapingClosure(clcosure: () -> Void) {
  closure()	// 함수 안에서 끝나는 클로저
}
class SomeClass {
  var x = 10
  func dp Something() {
    someFunctionWithEscapingClosure { self.x = 100 } // 명시적 self
    someFuntionWithNonescapingClosure { x = 200}
  }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)	// 200
completionHandlers.first?()
print(instance.x)	// 100
~~~

#### Autoclosures

* 자동클로저는 인자 값이 없으며 특정 표현을 감싸서 다른 함수에 전달 인자로 사용할 수 있는 클로저
* 자동클로저는 클로저를 실행하기 전까지 실제 실행되지 않음

~~~swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)	// 5
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)	// 5

print("Now serving \(customerProvider())!")	// Now serving Chris!
print(customersInLine.count)	// 4
~~~

* 자동 클로저는 적혀진 라인 순서대로 바로 실행되지 않고, 실제 사용될 때 지연 호출

~~~swift
func serve(customer customerProvider: () -> String) { 
  print("Now serving \(customerProvider())!")
}
// 명시적으로 클로저 직접삽입
serve(customer: { customersInLine.remove(at: 0) } )	// Now serving Alex!

// @autoclosure 키워드 사용으로 인자값이 자동으로 오토클로저로 변환
func serve(customer customerProvider: @autoclosure () -> String) {
  print("Now serving \(customersInLine.remove(at: 0))!")
}
serve(customer: customersInLine.remove(at: 0))	// Now serving Ewa
~~~

* @autoclosure는 @escaping과 같이 사용 가능

~~~swift
var customerProviders: [() -> Stirng] = []	// 클로저를 저장하는 배열
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
  customerProvider.append(customerProvider)
}	// 클로저를 인자로 받아 customerProviders 배열에 추가하는 함수 선언
collectCustomerProviders(customersInLine.remove(at: 0))	// 클로저를 customerProviders 배열에 추가
collectCustomerProviders(customersInLine.remove(at: 0))
print("Collected \(customerProviders.count) cloures.") // Collected 2 closures.

for customerProvider in customerProviders {
  print("\(customerProvider())!")	// 클로저를 실행하면 배열의 0번째 원소를 제거 하며 제거된 원소 출력
} // Barry! // Daniella!
~~~

* collectCustomerProviders 함수가 종료 후에 실행되는 클로저이기 때문에 인자 앞에 @escaping 키워드 붙임