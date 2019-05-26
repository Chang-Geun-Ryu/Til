# Subscripts

* 클래스, 구조체 그리고 열거형에서 스크립트를 정의해 사용 가능
* 콜렉션, 리스트, 시퀀스등 집합의 특정 멤버 엘리먼트에 간단하게 접근할 수 있는 문법
* 서브스트립트를 이용하면 추가넉인 매소드없이 특정 값을 할당하거나 가져올 수 있음

#### Subscript Suntax

* 서브스크립트는 인스턴스 매소드와 다른 점으로 read-write 혹은 read only만 가능
* 정의는 computed property 방식과 같이 setter, getter 방식을 따름

~~~swift
subscript(index: Int) -> Int {
  get {
    // 반환
  }
  set(newValue) {
    // set action
  }
}
subscript(index: Int) -> Int {
  // 반환
}
struct TimesTable {
  let multiplier: Int
  subscript(index: Int) -> Int {
    return multiplier * index
  }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("\(threeTimesTable[6])")	// 18
~~~

#### Subscript Usage

~~~swift
var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["Bird"] = 2	// numberOfLegs에 key bird에 value 2를 넣는 서브스크립트 문법
~~~

**Subscript Option**

* 입력 인자의 숫자에 제한이 없고, 입력 인자의 타입과 반환 타입의 제한이 없음
* In-out인자, 기본인자를 제공 불가, 오버로딩 허용하여 인자형, 반환형에 따라 원하는 수 만큼 서브스크립트 선언 가능

~~~swift d
struct Matrix {
  let rows: Int, columns: Int
  var grid: [Double]
  init(rows: Int, columns: Int) {
    self.rows = rows
    self.columns = columns
    grid = Array(repeating: 0.0, count: rows * columns)
  }
  func indexIsValid(row: Int, column: Int) -> Bool {
    return row >= 0 && row < rows && column >= 0 && column < columns
  }
  subscript(row: Int, column: Int) -> Double {
    get {
      assert(indexIsValid(row: row, column: column), "Index out of range")
      return grid[(row * columns) + column]
    }
    set {
      assert(indexIsValid(row: row, column: column), "Index out of range")
      grid[(row * columns) + column] = newValue
    }
  }
}
~~~

* 위 코드에서 subscript(row: Int, column: Int) -> Double 코드와 같이 row, column 2개 인자를 받고, Double을 반환하는 서브스크립트
* get, set 각각에 indexIsValid 매소드를 사용해서 유효한 인덱스가 아닌 경우 프로그램이 바로 종료 되도록 assert를 호출
* 선언한 서브스크립트 문법을 이용해 var matrix = Matrix(rows: 2, columns: 2) 2x2 행렬 선언