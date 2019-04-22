# iOS 앱의 구조와 코코아 터치 프레임워크

**시스템 프레임워크**: iOS 기반의 앱이 실행되는 필요한 기반 환경을 제공

**커스텀 코드**: 프로그래머가 코드를 작성하여 원하는 기능과 형태를 구현

* app은 기본적으로 시스템 프레임 워크에 정의된 원리에 따라 동작
* 스스템 프레임 워크 외 영역을 커스텀 코드를 통하여 원하는 기능과 유저 인터페이스를 구현 가능

#### 엔트리 포인트와 앱의 초기화 과정

* C 언어에 뿌리를 둔 모든 app은 main() 함수로 부터 시작, main()을 엔트리 포인트
* Objective-C 또한 C 언어 기반으로 main() 함수로 시작 
* main() 함수는 실행시, 시스템으로 받은 두개의 인자값, AppDelegate 클래스를 이용하여 UIApplicationMain() 함수를 호출하고, UIApplication 객체를 반환
* UIApplication 객체는 UIKit 프레임워크에 속해있어 app 제어권은 UIKit 프레임워크로 이관
* UIApplicationMain() 함수는 iOS app에 속하는 뿐의 엔트리 포인트로서, app의 핵심 객체를 생성하는 프로세스를 핸들링, 스토리보드 파일로부터 앱의 인터페이스를 읽고 커스텀 코드를 호출하여 app 생성 초기에 필요한 설정을 구현 할수 있게 도움을 줌
* UIApplicationMain() 함수가 생성하는 UIApplication은 앱의 본체에 해당하는 객체
* 작성된 커스텀 코드, 객체, 기능으로 생각 되는 모든 것은 UIApplication에 포함된 하위 객체
* 모바일 디바이스에 설치된 app 실행시 초기구동 과정을 거쳐 app 프로세스가 메모리에 등록될때의 프로세스는 UIApplication 객체라 할 수 있음
* UIApplication 객체는 프로그래머의 의도와 목적에 맞게 처리하기 위해 AppDelegate라는 대리 객체를 이용하여 커스텀 코드를 처리할 수 있도록 약간의 권한을 위임함
* AppDelegate는 UIApplication으로부터 위임받은 일부의 권한을 이용하여 커스텀 코드와 상호작용하는 역활을 담당

**UIApplication 객체와 AppDelegate 객체가 연관되어 앱이 실행되는 과정**

1. main() 함수 실행
2. main() 함수는 다시 UIApplicationMain() 함수를 호출
3. UIApplicationMain() 함수는 앱의 본체에 해당하는 UIApplication 객체를 생성
4. UIApplication 객체는 Info.plist 파일을 바탕으로 앱에 필요한 데이터와 객체를 로드
5. AppDelegate 객체를 생성하고 UIApplication 객체와 연결
6. 이벤트 루프를 만드는 등 실행에 필요한 준비 진행
7. 실행 완료 전, AppDelegate의 application(_:didFinishLaunchingWithOptions:) 메소드 호출

<img width="501" alt="appsLifeCycle" src="https://user-images.githubusercontent.com/45986486/56454675-9868f800-638f-11e9-8a7a-59ee2541c251.png">

* 스위프트의 경우  C언어 기반이 아니어서 main.m 파일이 따로 존재하지 않으며 엔트리 포인트도 없음
* 스위프트는 위 1~5의 과정을 @UIApplicationMain 의 어니테이션 표기로 대체
* App이 실행 목적을 모두 완료하고 사용되지 않으면 시스템은 app을 메모리에서 제거하기 위한 준비를 시작
* AppDelegate 클래스의 applicationWillTerminate(:) 메소드를 호출하여, 메소드 내부에 종료에 관한 커스텀 코드로 작성

#### MVC 패턴

* iOS 앱의 객체관계는 MVC 패턴에 기반
* Model - View - Controller로 이어지는 세개의 핵심 구조를 이용하여 애플리케이션을 설계하는 것
* **Model**: 데이터 담당
* **View**: 데이터에 대한 화면 표현
* **컨트롤러**: 모델과 뷰 사이에 위치하여 데이터를 가공 뷰에 전달, 뷰에서 발생하는 이벤트를 받아 처리하는 역

<img width="582" alt="스크린샷 2019-04-20 17 40 14" src="https://user-images.githubusercontent.com/45986486/56454948-6b1e4900-6393-11e9-8da9-25d81edab961.png">

* 데이터와 로직을 시각적으로 분리 표현하여 화면을 신경 쓰지 않고 데이터나 비즈니스 로직을 작성 가능
* MVC 패턴은 프로그램을 특성에 따라 서로 영향을 미치지 않을 수 있는 범위로 분리

#### 앱 상태 변화

* 앱은 실행하는동안 상태란 화면에 나타나거나, 화면에서 숨거나, 시작하거나, 종료등의 상태가 변화 됨
* 앱의 상태변화는 iOS 운영체제가 담당하여 처리하는 영역이며, 시스템에서 발생하는 특정 상황에 맞춰 앱의 상황에 맞게 상태를 변화 시키고 제어 함

1. **Not Running**: 앱이 시작되지 않았거나 실행되었지만 시스템에 의해 종료된 상태
2. **Inactive**: 앱이 전면에서 실행중이지만 아무런 이벤트를 받지 않고 있는 상태
3. **Active**: 앱이 전면에 실행중이며 이벤트를 박고 있는 상태
4. **BackGround**: 앱이 백그라운드에 있지만 코드기 실행되고 있는 상태, 대부분의 앱은 Suspended 상태로 이생하는 도중 일시적으로 이 상태에 진입, 파일 다운로드나 업로드, 연산처리 등 여분의 실행 시간이 필요한 앱일 경우 특정 시간 동안 이 상탱에 남아 있는 경우가 있음
5. **Suspended**: 앱이 메모리에 유지되지만 실행되는 코드가 없는 상태, 메모리가 부족한 상황이 오면 iOS 시스템은 포그라운드에 있는 앱의 여유메모리 공간을 확보하기 위해 Suspended 상태에 있는 앱들을 특별한 알림 없이 정리

* iOS 앱은 Not Running - Inactive - Active - Suspended 상태를 마지막으로 다시 Not Running 상태로 돌아감, 이를 앱의 **라이프 사이클 (Life Cycle, 생명주기) **라 

<img width="451" alt="스크린샷 2019-04-21 13 37 57" src="https://user-images.githubusercontent.com/45986486/56465567-b93a5780-643a-11e9-9b60-da5f3b0b9fab.png">

* 앱의 싱행상태가 변화하 때마다 앱 객체는 AppDelegate에 정의 된 메소드를 호출
* AppDelegate에 정의된 메소드들이 호출 될때 커스텀 코드를 작성하여 App의 상태변화 마다 원하는 작업을 실행 가능

1. **application(_: willFinishLaunchingWithOptions:)**: app이 구동되어 필요한 초기 실행 과정이 직전에 호출되는 메소드
2. **application(_:didFinishLaunchingWithOptions:)**: app이 사용자에게 화면으로 표기되기 직전에 호출되는 메소드, app이 실행 후에 진행할 커스텀마이징 초기화를 위한 코드를 여기에 작성
3. **applicationDidBecomeActive(_:)**: 실행된 app이 forground, 화면 전면에 표시될때 호출되는 메소드, 앱이 Inactive 상태에 들어가면서 일시 중지된 작업이 있다면 이를 재시작 하는 코드를 여기에 작성
4. **applicationDidEnterBackground(_:)**: app이 **BackGround** 상태에 진입시 호출되는 메소드, 미래의 어느순간에 앱이 종료된다는 의미로, 잃어서는 안되는 사용자 데이터를 종료 전에 미리 저장하거나 공유자원을 점유 하고 있었다면 해제가 필요, 종료된 app이 다시 실행될 때 현재의 상태를 복구할 수 있도록 필요한 정보도 이 메소드에서 저장 처리하는것을 지향
5. **applicationWillTerminate(_:)**: app이 종료되기 직전에 소출되는 메소드, 사용자 데이트 등을 종료 전에 한번 더 저장 하는것을 추천

#### iOS, cocoaTouch Framework

* 애플 개발 환경에서 클래스 이름 앞에 공통으로 붙는 접두어는 대부분 소속을 나타냄
  * UI*** 가 붙는 형식의 클래스는 모두 UIKit 프레임워크에 속함
* UIApplication, UIButton 등은 swift 언어 자체에서 제공하는 클래스가 아닌 프레임 워크를 통해 제공되는 클래스
* swift 자체적으로 제공되는 것이 아니기 때문에 import 라는 키워드를 이용하여 특정 프레임워크를 반입 시킴
* 파운데이션, UIKit, 웹킷  프레임워크 등의 계층을 거슬렁 올라가면 코코아 터치라는 하나의 거대한 프레임 워크가 존재함
* app을 만들고 실행할 때 필요한 iOS 기반 기술은  모두 코코아 터치 프레임 워크를 통해 구현되기 때문에, app을 제작하기 위해서는 결국 코코아 터치 프레임 워크 전체를 이해해야 함

#### iOS

* 애플이 개발하여 제공하는 임베디드 운영체재
* iOS는 기본적으로 하나의 홈 스크린을 사용, 원하는 대로 창을 띄우는 것이 아닌 하나의 화면을 분할해서 사용하는 것이 일반 컴퓨터와 차이
* iOS에서 제공하는 SDK는 기기의 홈스크린에 표현될 native app을 개발하고 설치하여 실행하고 테스트 하는 데 필요한 도구와 화면을 모두 포함
  * SDK가 존재하지 않는다는 것은 특정 OS에서 동작하는 app을 만들도록 허용치 않는 것
* **native app**: iOS system framework를 기반으로 하고 swift objective-C로 개발되며 iOS를 통해 직접 실행되는 app을 가리킴
* **web app**: safaly browser를 통해 실행되는 app으로 Phone Gap, Titanium 등의 개발 도구를 사용하여 HTML 페이지와 CSS, 자바스크립트 등의 기술만으로 native app과 유사한 UI, 기능을 제공할 수 있도록 제작하는 app
* app은 하드웨어와 직접 커뮤니케이션 할수 없으며, iOS에서 제공하는 시스템 인터페이스를 통해서만 하드웨어와 커뮤니케이션할 수 있음
* hardware와 app을 중계해주는 iOS interface가 cocoa touch framework, iOS app을 만드는 것은 cocoa touch framework를 다루는 것과 동일한 의미라고 볼수 

#### cocoa touch framework

* 애플 환경에서 터치기반의 application을 제작하기 워한 도구들의 모음
* 도구들은 용도에 따라 여러개의 하위 framework로 나누어 짐

| Foundation Framework | 설명                                                         |
| -------------------- | ------------------------------------------------------------ |
| Foundation           | 어플리케이션의 핵심 객체와 네트워크, 문자열 처리 등의 서비스를 제공 |
| UIKit                | 아이폰이나 아이패드, 애플 와치나, 애플 TV 등에서 실행되는 어플리케이션의 유저 인터페이스를 제공 |
| GameKit              | 게임 실행시 게임 센터를 연동 하거나 근거리 P2P 연결을 제공   |
| iAd                  | app 내 배너 형태 또는 팝업 형태의 광고를 삽입할 수 있도록 해주는 광고관련 제공 |
| MapKit               | 위치 정보나 지도 관련 서비스를 이용할 수 있도록 제공         |
| Address Bool UI      | 번들 어플리케이션으로 제공되는 주소록 app의 인터페이스와 기능을 커스텀 app 내에서도 사용하도록 제공 |
| EventKit UI          | 이벤트 처리에 필요한 유저 인터페이스를 제공                  |
| Message UI           | 번들 어플리케이션으로 제공되는 메시지 app의 인터페이스를와 기능을 커스텀 app 내에서도 사용할 수있도록 제공 |
| UserNotifications    | 번들 어플리케이션으로 제공되는 메시지 app의 인터페이스와 기능을 커스텀 app 내에서도 그대로 사용할 수 있도옥 제공 |
| WebKit               | 웹 관련 기능을 구현하기 위해 필요한 객체들을 제공            |

* 위 프레임워크 중 UIKit, Foundation 프레임워크는 app을 개발하기 위해서 반드시 필요한 도구들로, cocoa touch framework를 이루는 주 framework로 간주 됨

**cocoa toush framework와 cocoa framework**

* 코코아 터치 프레임 워크는 코코아 프레임워크를 바탕으로 만듬

* 코코아 프레임워크는 메킨토시등의 운영체제인 OS X에서 실행 되던 어플리케이션을 개발하기 위한 프레임워크

* 두 프레임워크는 Foundation framework를 공유하며 유저 인터펫이스는 서로 다, 데스크탑 인터페이스와 터치 인터페이는 서로 호환해서 사용하기 어려워, 코코아 프레임워크의 AppKit은 코코아 터치 프레임워크의 UIKit으로 대체

  <img width="538" alt="스크린샷 2019-04-21 16 31 16" src="https://user-images.githubusercontent.com/45986486/56466903-ed217700-6452-11e9-9a5e-f214dd573dd4.png">

**프레임워크의 계층관계**

* 코코아 프레임워크나 코코아 터치 프레임워크를 구성하는 작은 단위의 프레임 워크들은 계층관계를 이룸
* 하위 계층의 프레임 워크에서 상위 계층의 프레임 워크로 나열되며, 이중에 주로 프로그래밍에 사용하는 것은 상위 레벨의 프레임워크
* 상위 계층은 사용자에 가까운 구체적으로 구현이 되어있어 app을 만들때 가장 손쉽게 구현 가능한 형태를 말함, 이를 ''구체화되어 있다'' 표현
* 하위 계층은 추상적이며 하드웨어에 가까워 다루기 번거로워 작은기능기능 하나하나 모두 제어해 주어야 하지만 그만큼 범용적이고 원천적이기 때문에 다양한 형태로 확장 가능
* 대부분의 경우 상위 프레임워크는 하위프레임워크에 의존적, 하위프레임워크를 통해 구현된 기능에 구체[적인 기능을 덧붙여 놓은것이 상위 프레임워크

<img width="264" alt="스크린샷 2019-04-21 17 23 25" src="https://user-images.githubusercontent.com/45986486/56467517-c1a28a80-645a-11e9-85c1-9fb884d7cddb.png">

**코어 OS 계층** : 커널,파일 시스템, 네트워크, 보안, 전원 관리, 디바이스 드라이버드이 포함, iOS가 운영 체제로 기능을 하기위한 핵심 영역

**코어 서비스 계층**: 문자열 처리, 제이터 집합 관리, 네트워크, 주소록 관리, 환경 설정 등 핵심적인 서비스들과, GPS, 나침판, 가속도 센서나 자이로스코프 센서등의 디바이스등의 하드웨어 특성 기반 서비스 제공

**미디어계층**: 코어 서비스 계층에 에의존적이며, 상위 계층인 코코아 터치 계층에 그래픽 관련 서비스나 멀티미디어 관련 서비스를 제공

**코코아 터치 계층**: application framework 계층이라고도 불리며, 직접 지원하는 역활 iOS에 설치되고 실행되는 모든 app는 코코아 터치 계층에서 제공하는 여러사지 기술이나 서비스를 이용하여 기능을 구현하고 동작, UIKit도 이계층에 속함

<img width="426" alt="스크린샷 2019-04-21 17 52 40" src="https://user-images.githubusercontent.com/45986486/56467781-52c73080-645e-11e9-84cd-753abd9f31da.png">

* iOS의 프레임워크 계층은 hardware와 app 사이를 중계하는 위치, 프레임워크 계층 중 가장 아래에 위치한 OS계층은 개념적으로 hardware와 연결되며, 최상단에 위치한 코코아 터치 계층은 app과 연결

| 프레임워크        | 접두어 | 주요객체                                                     |
| ----------------- | ------ | ------------------------------------------------------------ |
| Foundation        | NS     | NSDate, NSData, NSURL, NSLong, NSArray, NSRange, NSSearchPathForDiectoriesinDomains, NSDictionary, NSExeption |
| UIKit             | UI     | UIApplication, UIViewController, UIView, UIButton, UIBarButtonItem, UIImageView, UIControl, UIResponder |
| UserNotifications | UN     | UNNotification,UNNotificationContent, UNNotificationRequest, UNNotificationResponse, UNNotificationTrigger |
| MapKit            | MK     | MKAnnotationView, MKCircle, MKDirections, MKLocalSearch, MKMapItem, MKMapShapshot, MKMapView, MKOverlayView |
| Core              | CF     | CFBundle, CFData, CFError, CFBoolean, CFRunLoop, CFSocket, CFPlugin, CFXMLParser, CFUUID, CFUserNotification |
| Core Graphics     | CG     | CGColor, CGContext, CGImage, CGGradient, CGLayer, CGPoint, CGRect, CGSize, CGAffineTranstform, CGPattern, CGPattern, CGPath |
| AVFoundation      | AV     | AVAssetReader, AVAssetResourceLoadingRequest, AVAssetInputGroup, AVAoudioConverter, AVAudioEngine, AVAudioBuffer, AVAudioUnit |


