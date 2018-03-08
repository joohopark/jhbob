# Shortcuts ,
# CodeSnippet
---

## Symbols

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/symbols_shortcuts.jpg)

- Symbols Notation

## Basic
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/basic_shortcuts.jpg)
## Assistance
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/assistance_shortcuts.jpg)
## Tap_Widow
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/tap_Window_shortcuts.jpg)
## Delete
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/delete_shortcuts.jpg)
## Apperance
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/apperance_shortcuts.jpg)
## Text
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/Text_Shortcuts.jpg)
## Build
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/build_shortcuts.jpg)
## debugging
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/debugging_shortcuts.jpg)
## Etc
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/etc_shortcuts.jpg)
## storyBoard
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/storyboard_shortcuts.jpg)
## Simulator
![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/simul_shortcuts.jpg)

# CodeSnipet

- 미리 만들어놓은 자동완성같은 느낌의 코드 덩어리들..

## CodeSnipet Library

![screen](codeSnippet.jpg)

## SystemCodeSnippets

- system에서 제공하는 CodeSnippet..

![screen](systemSni.jpg)

## custom CodeSnippets

![screen](sni_exam.jpg)

### location
![screen](sni_UserLocation.jpg)

- pc를 옮길때는 저 위치의 codesnippet 파일을 옮기면 된다..


## CodeSnippets Implement Exam
```swift
// Top Level

class MyViewController: UIViewController {
  // Class Implementation
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Function or Method
    // Code Expression
    
    print(/* Code Expression */)
    
    let _ = "String or Comment"
    
    DispatchQueue.main.async {
      // Top Level
    }
  }
}
```

## 언제 쓰면 좋을까?

- 시스템이 제공해주는 override 함수들에 super를 해줘야 할때.. 추가해서 만들어 놓는것도 좋다.

- extension DataSource 들을 사전에 미리 만들어서 넣어놓는거.. 이건진짜 좋은듯..!!

- UI 생성에 꼭 들어가야 되는것들 일련의 것들을 아예 스니펫으로..

- 맥북 쓸때는 사전에 IBOutlet, IBAction들을 스니펫으로 만들면 편하다.

- IBOutlet은 뷰컨의 속성
- IBAction은 뷰컨에게 전해주는 이벤트이기때문에 연결하는 방법이 반대에용

- `#available` 을 나눌때...

### PlaceHolder안에 넣으려면.
<pre>
<#place holder#>
</pre>

### - tip
<pre>
- Swift 문서가 빈약하다면 objc 설명을 참고하는것도 나쁘지 않다.

- 설정 부분( Command + , )
	- Behaviors : Xcode안에서 행해지는 행동들에 대한 설정( 빌드 완료시 소리 같은..)
	- Navigation : 정의 같은거 보고싶을때 설정들..이나 소스 코드 어케 보고싶은지 .. 옵션키에 대한 창 어케 띠울지에 대한 설정들.. 창을 어찌 이동시킬거야~?
	- Font& Color : 폰트랑 색상 정의
	- Text Editing : 개발 작성시에 어찌 text들을 관리 할거야
	- key Binding : 단축키 커스텀..


- comparison : 코드 비교
- blame : 마지막 커밋 사용자
- Log : 해당 코드들에 대한 로그

- Option (⌥) 키는 사용자를 위해 비워두었으니 커스텀 단축키로 사용할 것!

- 프로젝트가 커지면 디버그 로그 생성에 아래의 것들이 필요 할 수 도 있따.
	- 상세 정보.. 시간, 파일이름, 메서드, 라인
print?
debugPrint?
dump?

- // MARK : 
- // MARK : - 
- 위 두개는 차이가 있어


</pre>
