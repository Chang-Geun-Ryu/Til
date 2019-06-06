# Subjects

* Subjects는 Observable Sequence의 특별한 형태, subscribe 할수 있고 동적으로 요소를 추가도 가능하며 4가지 서로 다른 종류의 Subject가 존재

**PublishSubject**: subscribe 이후에 발생하는 모든 이벤트를 전달 받음

**BehaviourSubject**: subscribe 전에 발생한 최근 요소와 이후에 발생하는 모든것들을 전달

#### **ReplaySubject** 

* Observer 가 subscribe를 시작한 시점과 관계없이 Observable이 배출한 모든 항목들을 모든 Observer 에 배출
* 몇개의 생성자 오버로드를 제공하여 