#### Hot Observable

* 생성과 동시에 이벤트를 방출하기 시작, 또, 이후 subscribe 되는 시점과 상관없이 옵저버들에게 이벤트를 중간부터 전송
* ReactiveX 에서는, connectable Observable 이라고 하기도 함

#### Cold Observable

* Observer가 subscribe 되는 시점부터 이벤트를 생성하여 방줄 하기 시작
* 기본적으로 Hot Observable 로 생성하지 않은 것들은 Cold Observable로 이해

