# Error Handiling

* 애러가 발생시 상황에 맞는 적절한 처리하는 과정
* swift에서 런타임 에러가 발생한 경우 그 처리를 위한 error throwing, catching, propagating, manipulating을 지원하는 first-class 제공
* 명령중 항상 완전히 실행되는 것이 보장되지 않는 경우, 옵셔널을 사용해 에러가 발생해 값이 없다는 것을 표시 가능, 하지만 어떤 에러가 발생했는지 확인은 불가능
* 구체적으로 발생한 에러를 확인 할 수 있어야 코드를 작성하는 사람이 각 에러의 경우에 따른 적절한 처리 가능

#### Representing and Throwing Errors

* swift는 Error protocol을 따를는 값으로 에러를 표현
* swift의 열거형은 특별히 이런 관련된 에러를 그룹화하고 추가적인 정보를 제공

~~~swift
enum VendingMachineError: Error {
  case invalidSelection
  case insufficientFunds(coinsNeeded: Int)
  case outOfStock
}

throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
~~~

#### Handling Errors

* 에러가 발생하면 특정 코드영역이 해당 에러를 처리
* 에러가 발생한 함수에서 리턴값으로 에러를 반환해 해당 함수를 호출한 코드에거 에러를 처리
* do-catch 구문을 사용
* 옵셔널 값 반환
* assert를 사용해 강제로 크래쉬를 발생기키는 방법

**Preopagaing Errors Using Throwing Fctions**: 

* 매소드 혹은 inializer가 에러를 발생 시킬 수 있는 것을 알리기 위해 throw 키워드를 함수 선언부의 파라미터 뒤에 붙일 수 있음
* throw 키워드로 표시된 함수를 throwing function, 함수가 리턴값을 명시 한다면 throw 키워드는 리턴값 표시 기호 -> 전에 기입

~~~~swift
func canThrowErrors() throws -> String
func cannotThrowErrors() -> String
~~~~

* throwing function은 함수 내부에서 에러를 만들어 함수가 호출된 곳에 전달

* throwing function이 아닌 함수에서 throw가 발생한다면 반드시 그 함수안에서 throw에 대해 처리

~~~swift
struct Item {
  var price: Int
  var count: Int
}
class VendingMachine {
  var inventory = [
    "Candy Bar": Item(price: 12, count: 7)
    "Chips": Item(price: 10, count: 4)
    "Pretzels": Item(price: 7, count: 11)
  ]
  var coinsDeposited = 0
  func vend(itemNamed name: String) throws {
    guard let item = inventory[name] else {
      throw VendingMachineError.invalidSelection
    }
    guard item.count > 0 else { throw VendingMachineError.outOfStock }
    guard item.price <= coinDeposited else {
      throw VendinMachineError.insufficientFunds(coinsNeeded: item.price - coinDeposited)
    }
    coinsDeposited -= item.price
    var newItem = item
    newItem.count -= 1
    inventory[name] = newItem
    print("\(name)")
  }
}
~~~

* vend(itemNamed:) 매소드의 구현에서 guard 구문을 이용해 snack을 구매하는 과정에서 에러가 발생하면 함수에서 에러를 발생시키고 함수에서 탈출하도록 처리
* vend(itemNamed:) 매소드는 에러를 발생시키기 때문에 호출하는 매소드는 do-catch, try?, try! 등의 구문을 사용해 에러를 처리

~~~swift
let favoriteSnacks = [
  "Alice": "Chips",
  "Bob": "Licorice",
  "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendinMachine: VendingMachine) throws {
  let snackName = favoriteSnacks[person] ?? "Candy Bar"
  try vendingMachine.vend(itemNamed: snackName)
}
~~~

* 위코드의 buyFavoriteSback(person:vendingMachine:) 메소드는 가장 좋아하는 스낵이 뭔지 확인하고 vend(itemNamed:) 를 호출하여 구매 시도

* vend(itemNamed:)는 에러를 발생 시킬수 있기 때문에 호출 앞에 try 키워드 사용

~~~swift
struct PurchasedSnack {
  let name: String
  init(name: String, vendingMachine: VendinMachine) throws {
    try vendingMAchine.vend(itemNamed: name)
    self.name = name
  }
}
~~~

**Handling Error Using Do-Catch**: do-catch를 이용해 에러를 처리하는 코드 블럭을 작성 가능, 에러가 do 구문 안에서 발생하면 에러의 종류를 catch 구문으로 구분해 처리 가능

~~~swift
do {
  try expression
  statements
} catch pattern 1 {
  statements
} catch pattern 2 where condition {
  statements
} catch {
  statements
}
~~~

* catch 구문 뒤에 어떤 에러인지 적고 그것을 어떻게 처리할 것인지 명시 가능
* catch 구문 뒤에에러 종류를 명시 하지 않으면 발생하는 모든 에러를 지역 상수인 error로 바인딩

~~~swift
var vendingMachine = VendingMachine()
vendingMachine.coinDeposited = 8
do {
  try buyFavoriteSnack(person: "Alice", vendinMachine: vendingMAchine)
  print("Success")
} catch VendingMAchineError.invalidSelection {
  print("Invalid Selection")
} catch VendingMachineError.outOfStock {
  print("Out of Stock")
} catch VendingMAchineError.insufficientFunds(let coinsNeeded) {
  print("please \(coinsNeeded) coins")
} catch {
  print("\(error)")
}	// please 2 coins
~~~

* buyFavoriteSnack(person:vendingMAchine:) 메소드는 try 표현 안에서 호출, 이 메소드는 에러를 발생시킬 수 있기 때문에 에러가 발생하자마자 catch 구문에 전달해 적절한 처리

~~~swift
func nourich(with item: String) throws {
  do {
    try vendingMachine.vend(itemNamed: item)
  } catch is VendingMachineError {	// 모든 VendingMachineError 구분을 위한 is
    print("Inavlid serection, out of stock, or not ecough money.")
  }
}
do {
  try nourich(with: "Beet-Flavored Chips")
} catch {
  print("Unexpected non-vending-machine-related error: \(error)")
}	// Inavlid serection, out of stock, or not ecough money.
~~~

* nourish(with:) 메서드에서 만약 vend(itemNamed:) initializer에서 VendingMachineError 열거형 중 한가지의 에러가 발생한 경우, nourish(with:) 메서드가 에러 처리해 메시지를 출력
* nourich(with:) 메서드는 그것을 호출한 곳에 에러를 발생, 발생한 에러는 일반 catch 구문에서 처리

**Converting Errors to Optional Values**: try? 구문을 사용해 에러를 옵셔널 값으로 변환 가능

~~~swift
func someThrowingFunction() throws -> Int {
  // something to do
}
let x = try? someThrowingFunction()
let y: Int?
do {
  y = try someThrowingFunction()
} catch {
  y = nil
}
~~~

* someThrowingFunction() 이 에러를 발생하면 x와 y는 nil, 에러가 없으면 함수의 리턴값을 갖음
* x, y는 someThrowingFunction() 리터나입 어떤 것이든 상관없이 옵셔널

~~~swift
func fetchData() -> Data? {
  if let data = try? fetchDataFromDisk() { return data }
  if let data = try? fetchDataFromServer() { return data }
  return nil
}
~~~

**Disabling Error Propagation**: 함수나 매소드에서 에러가 발생되지 않을 것을 확식하는 경우 try! 사용

#### Specifying Cleanup Actions

* defer 구문을 이용해 함수가 종료된 후 파일 스트림을 닫거나, 사용했던 자원을 해지하는 등의 활동 가능
* defer 구문이 여러개 있는 경우 가장 마지막 defer 부터 실행

~~~swift
func processFile(filename: String) throws {
  if exists(filename) {
    let file = open(filename)
    defer {
      close(file)	// block이 끝나기 직전에 실행, 주로 자원 해제나 정지에 사용
    }
    while let line = try file.readline() {
      // some work with file
    }
  }
}
~~~

