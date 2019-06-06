# Observable

###Observable Sequences

* RxSwift는 Observable Sequences 를 연산하거나, Observable Sequences 에서 발생한 이벤트를 subscribes 하는 것으로 이루어 진다
* Array, String, Dictionary는 RxSwift에서 Observable Sequences로 전환, swift 표준 라이브러리의 Sequence Protocol 에 적합하면 어떤 객체라도 Obsevable Sequences로 생성 가능

~~~swift
let helloWorld = Observable.just("Hello World")
let numbers = Observable.from([0,1,2,3,4,5])
let dictionary = Observable.form([1: "one", 2:"two"])
~~~

* subscribe(on: (Event) -> ()) 메소드를 오출하면 Observable Sequences를 subscribes 할수 있으며, 전달된 블록엔 Sequence에서 발생되는 모든 이벤트를 전달 받음

~~~swift
let helloWorld = Observable.of("Hello World")
helloWorld.subscribe { event in 
                     print(event)
                     }
~~~

* Observable Squences 는 0개 이상의 이벤트를 발생, 이벤트를 3가지 상태의 열거형 값을 가진다.
  * .next(value: T): Observable Sequences에 하나 이상의 값이 추가되면 다음 이벤트를 subscribes에 전달
  * .error(error: Error): 에러를 만나면 시퀀스는 에러 이벤트를 발생, 시퀀스 종료
  * .completed: 시퀀스가 정상적으로 끝나면 완료 이벤트를 subscribesdp 전달

~~~swift
let hello = Observable.from(["H", "e", "l", "l", "o"])
hello.subscribe { event in
                  switch event {
                    case .next(let value): print(value)
                    case .error(let error): print(error)
                    case .completed: print("completed")
                  }
                }
~~~

* subscribe를 취소하기 위해서는 dispose를 호출, deinit 시 등록된 모든 subscribes 를 취소해주는 DisposeBag에 subscribes를 등록하는 방법도 가능

~~~swift
let bag = DisposeBag()

Observable.just("Hello World")
					.subscribe(onNext: {print($0)})
					.disposed(by: bag)
~~~

