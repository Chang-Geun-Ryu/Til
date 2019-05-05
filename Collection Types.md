# 콜렉션 타입 (Collection Types)

* swift는 주된 콜렉션으로 Array, Set, Dictionaly 세가지를 지원

#### 콜렉션 변경

* Array, Set, Dictionaly 를 var 에 할당하면 이 콜렉션은 변경가능하고 let 에 할당하면 변경 불가능

#### Array

**배열의 축양형 문법**: 배열 타입은 Array로 적을 수 있으며 [Element] 형태로 사용 가능

**빈 배열의 생성**

~~~swift
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")

someInts.append(3)	// 배열에 3추가
someInts = [] 			// 배열을 비움, 배열의 아이템 타입은 그대로 Int로 유지
~~~

**기본 값으로 빈 배열 생성**: repeating 매소드와 count 매소드를 이용해 기본 값으로 빈 배열을 생성

~~~swift
var threeDoubles = Array(repeating: 0.0, count: 3) // Double type [0.0, 0.0, 0.0]
~~~

**다른 배열을 추가한 배열의 생성**: "+" 연사자를 이용해 배열 함치기 가능

~~~swift
var anotherThreeDoubles = Array(repeating: 2.5, count: 3) // [2.5, 2.5, 2.5]
var sixDoubles = threeDoubles  + anotherThreeeDoubles // [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
~~~

**리터럴을 이용한 배열의 생성**: [value1, value,2,value3] 형태를 이용해 배열을 생성 가능

~~~swift
var shoppingList: [String] = ["Eggs", "Milk"]
var shoppingList2 = ["Eggs", "Milk"]
~~~

**배열의 접근 및 변환**

~~~swift
shoppingList.append("Four")	// shoppingList.count : 3
shoppingList += ["Baking Powder"]	// shoppingList.count : 4
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]	// shoppingList.count : 7

var firstItem = shoppingList[0]	// "Eggs"
shoppingList[4..6] = ["Bananas", "Apples"]	// 4, 5, 6번째 인덱스 아이템을 Bananas, Apples 변환
shoppingList.insert("Maple Syrup", at: 0)

let mapleSyrup = shoppingList.remove(at: 0)
firstItem = shoppingList[0]	// : "Six eggs"

let apples = shoppingList.removeLast()
~~~

**배열의 순회**: for-in loop 를 이용해 배열을 순회 가능

~~~swift
for item in shoppingList {
  print(item)
} // Six eggs, Milk, Flour, Baking Powder, Bananas
~~~

배열의 값과 인덱스가 필요할 때 enumerated() 매소드를 사용

~~~swift
for (index, value) in shoppingList.enumerated() {
  print("Item \(index + 1): \(value)")
} // Item 1: Six eggs, Item 2: Milk, Item 3: Flour, Item 4: Baking Powder, Item 5: Bananas
~~~

#### Set

* Set 형태로 저장되기 위해서는 반드시 타입이 hashable 이어야 함, swift에서 String, Int, Double, Bool 같은 기본 타입은 기본적으로 hashable

**빈 Set 생성**

~~~swift
var letters = Set<Character>()
print("\(letters.count) items.")	// 0 items.
letters.insert("a")
letters = []
~~~

**배열 리터럴을 이용한 Set 생성**

~~~swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres2 Set = ["Rock", "Classical", "Hip hop"]
~~~

**Set의 접근과 변경**

~~~swift
print("\(favoriteGenres.count)") // 3

favoriteGenres.insert("Jazz")

if let removedGenre = favoriteGenres.remove("Rock") { // data delete
  print("\(removedGenre)")
} else {
  print ("I never much cared for that.")
}	// Rock

if favoriteGenres.constains("Funk") {
  print("Find it")
} else {
  print("It's too funky in here.")
}	// It's too funky in here.
~~~

**Set의 순회**: for-in loop

~~~swift
for genre in favoriteGenres {
  print("\(genre)")
} // Classical // Hip Hop // Jazz
~~~

**Set 명령**

~~~swift
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted() // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted() // []
oddDigits.substructing(singleDigitPrimeNumbers).sorted()	// [1, 9]
oddDigits.symmetrucDifference(singleDigitPrimeNumbers).sorted()	// [1, 2, 3]
~~~

#### Dictionary

* swift의 Dictionary타입은 Foundation 클래스의 NSDictionary를 bridge한 타입

**축약형 Dictionary**: [Key: Value] 형태로 Dictionary를 선언 가능

**빈 Dictionary**

~~~swift
var namesOfIntegers = [Int: String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers = [:] // 빈 배열
~~~

**리터럴을 이용한 Dictionary의 생성**: [key1: value1, key2: value2, key3: value3] 형태로 Dictionary 선언가능

~~~swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": :"Dublin"]
~~~

**Dictionary의 접근과 변경**

~~~swift
print("\(airports.count")	// 2
if airports.isEmpty {
  print("empty")
} else {
  print("not empty")
} // not empty

airports["LHR"] = "London"
~~~

