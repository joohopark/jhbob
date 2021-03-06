
<img src="https://swift.org/assets/images/swift.svg" alt="Swift logo" height="70" >

# Swift4. 

> 제가 Swift4를 정리하면서 뇌피셜을 섞어가며 정리한 Swift 정복 수필이라고 생각해주시면 감사하겠습니다. 
>
>Swift4를 공부하시는 분들이 보신다면, 미천하지만 작은 도움이 되었으면 좋겠습니다.
>
>보시다가 오역, 잘못된 해석, 정리에 대해 도움을 주신다면 가장 하단의 feedBack
>
>  mail로 noti주시거나 PR 주시면 감사하겠습니다.., (꾸벅)
> 
> 제가 공부하기위해서 (사실상 기억력 부재로.. 잊어버렸을때 키워드만 보고 기억력을 되살리기 위한 방안으로 Paper 정리 ..)
> 
> 작성된 글들입니다.. 하지만 궁금하신 부분이 있으시다면 언제나~!

## [IOS 참고하면 좋은 Reference](https://github.com/joohopark/jhbob/blob/master/Study/IOS_Ref.md)

## Rx, Reactive Extension ...

>- 정말 어렵습니다. 3월 현재 딜리게이트 대신 쓰면 좋겠다~ 정도입니다. 
>
>하지만 Side Effect를 줄여준다는 부분은 확실히 공감하는 패러다임이기때문에 맛을 보고잇습니다.
>
>정말 맵네요... 

- [preView.. 얼마나 맵길래?!](https://github.com/joohopark/jhbob/blob/master/Study/RxSwift/Rx01.md)
- [Observable?](https://github.com/joohopark/jhbob/blob/master/Study/RxSwift/Observable.md)
- [Subject...T-T..](https://github.com/joohopark/jhbob/blob/master/Study/RxSwift/Subject.md)


## TDD, (Test Driven Development)
>- Without QA! 이 테스트는 내가 집도하도록 하지..

- [TDD, Test Driven Development](https://github.com/joohopark/jhbob/blob/master/Study/TDD/TDD_UsingXcode.md)

## Project_Practice
>- 혼자해보는 Swift4
> Step0~, 에서 만들어본 자그마한 예제 코드들..

- [FrameBase, UserDefault를 이용한 BlackJack miniGame](https://github.com/joohopark/jhbob/blob/master/Project/smallProject/BlackJack.md)
- [NotifiocationCenter, Autolayout(Using StroyBoard)를 이용한 Signing Up, DetailMemberView](https://github.com/joohopark/jhbob/blob/master/Project/smallProject/NotificaionCenter_Autolayout.md) 
- [bundle(load plist),data modelling,customcell,Autolayout(Using StroyBoard)를 이용한 tableView](https://github.com/joohopark/jhbob/blob/master/Project/smallProject/TableViewCell_AutoLayout.md)
 
## Step 0.

>- 기본적인 Swift 문법들을 정리

- [Swift 변수& 상수, 자료형, 산술 & 비교 & 논리 연산자, 타입 추론, Condition Syntax](https://github.com/joohopark/jhbob/blob/master/Study/step0/SwiftBasic_var_let_if_switch.md)
- [Iterator Syntax, 삼항/논리/범위 연산자, Function](https://github.com/joohopark/jhbob/blob/master/Study/step0/SwiftBasic_for_while.md)
- [Array, Set, Dictionary, Collection Type](https://github.com/joohopark/jhbob/blob/master/Study/step0/SwiftBasic_CollectionType.md)


## Step 1.

>- OOP, Property, Property Observer등 Swfit의 특색있는 문법 및 디자인 패턴들을 정리

- [Class& Structure, init(), ValueType VS Reference Type, OOP](https://github.com/joohopark/jhbob/blob/master/Study/step1/ClassOOPStructure.md)
- [Tuple, Any, nil, Type Casting, Access Controll, Optional & Optional Binding](https://github.com/joohopark/jhbob/blob/master/Study/step1/Optional.md)
- [Property, Property observer](https://github.com/joohopark/jhbob/blob/master/Study/step1/Property_Observer.md)

## Step 2.

>- AppLifeCycle, UI등을 정리

- [MVC, ApplifeCycle, UITextField, Protocol, Delegate, UIScrollView](https://github.com/joohopark/jhbob/blob/master/Study/step2/AppLifeCycle.md)
- [UIBasic, UIView](https://github.com/joohopark/jhbob/blob/master/Study/step2/UIViewStart.md)
- [UIViewController, 화면 전환, UIAlertController](https://github.com/joohopark/jhbob/blob/master/Study/step2/ViewController_Segue_alert.md)
- [Container ViewController(NavigationControlelr), UserDefault](https://github.com/joohopark/jhbob/blob/master/Study/step2/NavigationController_userDefault.md)
- [UITableView](https://github.com/joohopark/jhbob/blob/master/Study/step2/TableView.md)
- [AutoLayoout](https://github.com/joohopark/jhbob/blob/master/Study/step2/About_AutoLayout.md)
- [NotificationCenter](https://github.com/joohopark/jhbob/blob/master/Study/step2/Notification.md)

## Step 3.

>- Singleton Pattern, error exception... 주로 DataModelling에 관련된것들을 정리

- [Singleton, DataModel??](https://github.com/joohopark/jhbob/blob/master/Study/step3/Singleton_datamodel,.md)
- [enumulation, Error, bundle, FileLoad](https://github.com/joohopark/jhbob/blob/master/Study/step3/Enumulation_error_bundle.md)
- [ARC, 코드의 확장, generic](https://github.com/joohopark/jhbob/blob/master/Study/step3/ARC.md)
- [UITabBarController, UICollectionView, UIGestureRecognizer, pickerView](https://github.com/joohopark/jhbob/blob/master/Study/step3/UITabbarController.md)
- [FRPP?, Closure, High-Order Function, map, Filter, Reduce](https://github.com/joohopark/jhbob/blob/master/Study/step3/highOrderFunction.md)

## Step 4.

>- Error Handling, URL Scheme, Dependency Manager등.. 개발에 도움이 될만한 이론 & 툴 설치 방법등을 정리

- [URL Scheme, Dependency Manager, Meta-Type](https://github.com/joohopark/jhbob/blob/master/Study/step4/URLScheme.md)

## extension
>- Swift4가 아니더라도 할수 있지만, 쓸모있는 IOS Developer가 되기위해..!

- Sketch

- DataStructure

- Algorithm
	- [Recursive, 재귀가 뭐임?](https://github.com/joohopark/jhbob/blob/master/Study/Recursive/Recursive01.md)
	- [Recursive Think!](https://github.com/joohopark/jhbob/blob/master/Study/Recursive/Recursive02.md)
	- [Designing Recursion](https://github.com/joohopark/jhbob/blob/master/Study/Recursive/Recursive03.md)
	- [Maze, FindPath](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/maze_findPath.md)
	- [Counting Cells in a Blob](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/countedCells.md)
	- [Dynamic Programming - Recursive Vs Memoization](https://github.com/joohopark/jhbob/blob/master/Study/Recursive/Recursive04.md)
	- [Programmers Level 01](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers01.md)
	- [Programmers Level 02](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers02.md)
	- [Programmers Level 03](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers03.md)
	- [Programmers Level 04](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers04.md)
	- [Programmers Level 05](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers05.md)
	- [Programmers Level 06](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers06.md)
	- [Programmers Level 07](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/Programmers/Programmers07.md)
	- [FastCamp](https://github.com/joohopark/jhbob/blob/master/Study/Algorithm/fastcamp/Swift_Array.md)

- Apple Docs 해석 및 정리.
	- [UIViewController](https://github.com/joohopark/jhbob/blob/master/Study/AppleDoc/UIViewController.md)
	- [TableView](https://github.com/joohopark/jhbob/blob/master/Study/AppleDoc/TableView.md)
	- [preInterfaceBuilder](https://github.com/joohopark/jhbob/blob/master/Study/AppleDoc/prepareInterfaceBuilder.md)


- [시간복잡도](https://github.com/joohopark/jhbob/blob/master/Study/TimeComplexity.md)

- Git 관리 전략
	- [GitFlow](https://github.com/joohopark/jhbob/blob/master/Study/git_flow.md)

- UX/UI를 고민한다면 ...
	- [UX_UI](https://github.com/joohopark/jhbob/blob/master/Study/UI_UX.md)

- shortCuts
	- [shortCuts](https://github.com/joohopark/jhbob/blob/master/Study/Shortcuts.md)

- [API Design Guideline](https://github.com/joohopark/jhbob/blob/master/Study/API_Design_Guidelines.md)
	- [FactoryMethodPattern](https://github.com/joohopark/jhbob/blob/master/Study/FactoryMethodPattern.md)

- [SandBox](https://github.com/joohopark/jhbob/blob/master/Study/sandBox.md)

### **:Email:**  : <bobplesae88@gmail.com>
> - 조언 및 오역, 잘못된 해석등에 대해서 feedBack을 **구걸!!** 합니다.

