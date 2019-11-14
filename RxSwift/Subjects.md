# Subjects

* Subjects는 Observable Sequence의 특별한 형태, subscribe 할수 있고 동적으로 요소를 추가도 가능하며 4가지 서로 다른 종류의 Subject가 존재

#### **ReplaySubject** 

* n 개의 이벤트를 저장하고 subscribe 가 되는 시점과 상관없이 저장된 모든 이벤트를 전달
* create(bufferSize bufferSize: Int), createUnbounded() 생성 함수를 갖으며, createUnbounded() 는 Subject 생성 이후 발생하는 모든 이벤트를 저장
* 메모리관리을 위해 사용시 버퍼사이즈에 유의해야 함

~~~swift 
let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
replaySubject.on(.next("창근"))
replaySubject.on(.next("창식"))
replaySubject.on(.next("혁태"))
replaySubject.subscribe{print($0)}
						 .disposed(by: disposeBag)
~~~

#### AsyncSubject

* Complete 될 때까지 이벤트는 발생하지 않으며, complete 가 되면 마지막 이벤트를 발생하고 종료
* 에러발생시 마지막 이벤트 전달 없이 에러발생

~~~swift
let asyncSubject = AsyncSubject<String>()
    asyncSubject.subscribe{print($0)}
                .disposed(by: disposeBag)
    
    asyncSubject.on(.next("창근"))
    asyncSubject.on(.next("창식"))
    asyncSubject.on(.next("혁태"))
    
    asyncSubject.on(.completed)
~~~

#### PublishSubject

* subscribe 된 시점 이후부터 발생한 이벤트를 전달
* subscribe 되기 이전의 이벤트는 전달 하지 않음

~~~swift
let publishSubject = PublishSubject<String>()
    publishSubject.subscribe{ print("First subscribe: \($0)")}
                  .disposed(by: disposeBag)
    
    publishSubject.on(.next("창근"))
    publishSubject.on(.next("창식"))
    
    publishSubject.subscribe{ print("Second subscribe: \($0)") }
    
    publishSubject.on(.next("혁태"))
    publishSubject.on(.completed)
~~~

#### BehaviorSubject

* publishSubject와 비슷하며 초기값을 subject
* subscribe 가 발생하면 즉시 현재 저장된 값을 이벤트로 전달
* 마지막 이벤트 값을 저장하고 싶을때 사용
* 에러발생시 에러를 전달

~~~swift
let behaviorSubject = BehaviorSubject<String>(value: "창근")
    behaviorSubject.debug("behavior Subject log: first stream")
                   .subscribe{print($0)}
                   .disposed(by: disposeBag)
    
    behaviorSubject.on(.next("혁태"))
    behaviorSubject.on(.next("창식"))
    
    behaviorSubject.debug("behavior Subject log: second stream")
                   .subscribe{print($0)}
                   .disposed(by: disposeBag)
~~~

