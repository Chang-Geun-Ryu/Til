## 기본적인 데이터 구조

#### 인접 대이터 구조(Linear data structures)

* 데이터가 매모리 영역에서 인접한 부분에 저장 된다. 배열, 힙, 매트릭스, 해시 테이블
* **배열**: 배열의 인덱스값은 0 부터 시작, 데이터 간의 순서가 있으며, 임의로 특정 요소에 접근할 수 있는 데이터 집합의 성질, 스택 큐, 힙, 해시 테이블, 문자열 등 다양한 데이터 구조를 표현하는 데 활용



#### 연결 데이터 구조(Linked data structures)

* 구분되는 메모리 영역을 가지고 있지만, 포인터로 연결 관리되는 구조, 리스트, 트리, 그래프

* 스위프트는 직접적으로 포인터에 접근하지 않으며, 포인터를 활용할 수 있는 별도의 추상 체졔를 제공



#### 데이터 구조의 종류와 장단점

| 데이터 구조       | 장점                                                         | 단점                                                         |
| ----------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 배열              | 인덱스 값을 미리 알고 있을 경우, 신속히 접근가능, 새로운 요소 신속히 삽입가능 | 크기가 고정되고, 삭제 및 검색이 느림                         |
| 정렬된       배열 | 비정렬 배열에 비해 검색 속도가 빠름                          | 크기가 고정되고, 삭제 및 검색이 느림                         |
| 큐                | FIFO (First In First Out)                                    | 다른요소에 대한 접근 속도가 느림                             |
| 스택              | LIFO (Last In First Out)                                     | 다른요소에 대한 접근 속도가 느림                             |
| 리스트            | 데이터 삽입 및 삭제 속도가 빠름                              | 검색 속도 느림                                               |
| 해시 테이블       | 키값을 미리 알고 있는 경우 해당 데이터에 매우 신속하게 접근, 새로운  요소를 매우 신속하게 삽입가능 | 키값을 모를 경우 접근 속도가 느리고 삭제 속도가 느리며 메모리 효율성이 떨어짐 |
| 힙                | 매우 신속하게 삽입 및 삭제가 가능, 최대 최소 항목에 접근 속도가 빠름 | 다른 요소에 대한 접근 속도는 느림                            |
| 트라이 (Trie)     | 데이터 접근 속도가 매우 빠름, 서로 다른 키값에 대한 충돌 가능성이 없고 삽입과 삭제가 신속함, 문자열 딕셔너리의 정렬, 프리픽스 검색등에 유용 | 특정 상황에서 해쉬 테이블보다 속도각 느릴 수 있음            |
| 이진 트리         | (균형 잡힌 트리 구조인 경우) 삽입, 삭제, 검색 속도가 매우 빠름 | 삭제 알고리즘 작성이 복잡해 질 수 있고, 트리 구조가 삽입 순서에 영향을 받고 성능이 저하될 수 있다. |
| 레드블랙 트리     | 삽입, 삭제, 검색 속도 매우 빠름, 트리는 항상 균형 상태를 유지 | 한계 상황에서 데이터 구조를 운영하므로 구현이 까다로움       |
| R    트리         | 공간적 데이터를 나타낼 때 좋음, 2차원 이상의 구조를 지원     | 역사적으로 성능이 검증 되지 않음                             |
| 그래프            | 실제 세계의 상황을 반영한 모델을 구현                        | 일부 알고리즘은 느리고 복잡                                  |

#### 알고리즘 개요

* **알고리즘이란 입력값을 출력값으로 변환하기 위해 만들어진 일련의 컴퓨터 절차**

* 새로운 데이터 아이템을 삽입하는 방법
* 데이터 아이템을 삭제하는 방법
* 특정 데이터 아이템을 찾는 방법
* 모든 데이터 아이템을 순회하는 방법
* 데이터 아이템을 정렬하는 방법



#### InsertionSrot

```swift
func insertionSort(list: inout [Int]) {
  for indexOuter in 1..<list.count {
    let tmp = list[i]
    var indexInner = indexOuter - 1
    while indexInner >= 0 && list[indexInner] > tmp {
      list[indexInner + 1] = list[indexInner]
      indexInner = indexInner - 1
    }
    list[indexInner + 1] = tmp
  }
}
```

#### mergeSort

```swift
func mergeSort<T:Comparable>( list:inout [T]) {
    if list.count <= 1 {
        return
    }
    
    func merge( left:[T], right:[T]) -> [T] {
        var left = left
        var right = right
        var result = [T]()
        
        while left.count != 0 && right.count != 0 {
            if left[0] <= right[0] {
                result.append(left.remove(at: 0))
            } else {
                result.append(right.remove(at: 0))
            }
        }
        
        while left.count != 0 {
            result.append(left.remove(at: 0))
        }
        
        while right.count != 0 {
            result.append(right.remove(at: 0))
        }
        
        return result
    }
    
    var left = [T]()
    var right = [T]()
    
    let mid = list.count / 2
    
    for i in 0..<mid {
        left.append(list[i])
    }
    
    for i in mid..<list.count {
        right.append(list[i])
    }
    // 재귀
    mergeSort(list: &left)
    mergeSort(list: &right)
    
    list = merge(left: left, right: right)
}
```

**소규모 데이터의 경우 insertionSort가 mergeSort보다 유리 하지만 대규모 데이터의 경우 mergeSort가 유리**

