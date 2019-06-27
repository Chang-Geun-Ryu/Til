#터미널 명령어 정리
terminal 에게 전달하는 명령어 중 가장 기본적인 것들에 대해서 정리해 보았다.

$pwd
Print Working Directory

현재 자신이 어느 디렉토리에 위치하는 지 출력한다.

$cd + [경로명]
Change Directory

디렉토리(경로)를 변경한다.

$cp + [원본파일] [대상파일]
$mv + [원본파일] [대상파일]
Copy 원본파일을 복사한다.

Move 원본파일을 이동한다.

파일을 가르킬 때에는 파일경로 + 이름 으로 명시한다.

$ls + [옵션명] + [경로명]
List Segement

경로의 구성요소(파일, 디렉토리)를 나열한다.

$touch
파일생성

$mkdir
Touch / MaKe DIRectory

파일을 / 디렉토리를 생성한다.

$rm
$rmdir
ReMove / ReMoveDIRectory

파일을 / 디렉토리를 삭제한다.

$rm -rf
기본적으로 디렉토리 안에 파일이 존재하면 디렉토리를 지울수가 없다.

이 명령어를 사용하면 디렉토리 하위에 파일이 있어도 강제로 디렉토리를 삭제한다

.[원본파일]
앞에 '.' 이 붙어 있으면 숨김 파일이다.

git commit message 예시
Categories
feat - feature(기능) docs - documentations(문서) fix - bug fix(픽스) conf - set configurations(설정)

commit message 는 제목은 구나 절로 쓰고 내용은 문장단위로 코드에 대한 설명을 하는것이 좋다.
