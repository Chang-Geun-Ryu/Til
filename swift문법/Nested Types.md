# Nested Types

* 중첩타입은 특정 문맥에서 좀더 복잡한 타입을 위해 사용할 수 있는 유틸리티 클래스나 구조체를 정의

#### 중첩타입의 사용

~~~swift
struct BlackjackCard {
  // nested Suit enumeration
  enum Suit: Charactor { // struct 안에 enum이 선언 가능
    case spades = "♠︎", hearts = "♡", diamonds = "♢", clubs = "♣︎"
  }
  enum Rank: Int {	// nested Rank enumeration
    case two = 2, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king, ace
    struct Values {	// enum안에 struct가 들어가는 것도 가능
      let first: Int, second: Int?
    }
    var values {
      switch self {
        case .ace: return Values(first: 1, second: 11)
        case .jack, .queen, .king: return Values(first: 10, second: nil)
        default: return Values(first: self.rawValue, second: nil)
      }
    }
  }
  // BlackhackCard properties and methods
  let rank: Rank, suit: Suit
  var ddescription: String {
    var output = "suit is \(suit.rawValue),"
    output += " value is \(rank.values.first)"
    if let second = rank.values.second {
      output += " or \(second)"
    }
    return output
  }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)") 
// theAceOfSpades: suit is ♠︎, value is 1 or 11
~~~

* Suit enum 값은 카드에서 사용하는 4가지 모양을 표현, Rank enum 값은 카드에서 사용 가능한 13가지 카드 등급을 표현

#### Referring to Nested Types

* 중첩 타입을 선언 밖에서 사용하려면 선언된 곳의 시작부터 끝까지 적여야함

~~~swift
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue // hearts is ♡
~~~

