# Function Types

* function types는 parameter types, return type으로 구성

~~~swift
func addTwoInts(_ a: Int, _ b: Int) -> Int {
  return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
  return a * b
}

func printHellowWorld() {
  print("hello, world")
}
~~~

**using function type**: 함수를 변수처럼 정의해서 사용 가능

~~~swift
// 함수의 인자 값과 반환 값 type이 같아 함수가 변수로 할당 가능
var mathFuntion: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2,3))") // Result: 5

mathFuntion = multiplyTwoInts
print("Result: \(mathFunction(2,3))")	// Result: 6

let anotherMathFunction = addTwoInts	// 타입 추론을 통한 함수 할당 가능
~~~

**Function Types as Parameter Types**: 파라미터에 함수 형을 사용 가능

~~~swift 
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
  print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)	// Result: 8
~~~

**Function Types as Return Types**: 함수를 반환하는 함수 사용 가능

~~~swift
func stepforward(_ input: Int) -> Int {
  return input + 1
}
func stepBackward(_ input: Int) -> Int {
  return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
  return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0) // stepBackward()
~~~

#### 중첩함수 Nested Function

* 함수 중에 다른 함수 안에서 동작하는 함수, 함수내에 존재하여 함수 안에서만 접근 가능

~~~swift
func chooseStepFuntion(backward: Bool) -> (Int) -> Int {
  func stepForward(input: Int) -> Int { return input + 1}
  func stepBackward(input: Int) -> Int { return input - 1}
  return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
  print("\(currentValue)...")
  currentValue = movenearerToZero(currentValue)
} // -4...// -3... // -2... // -1...
~~~

