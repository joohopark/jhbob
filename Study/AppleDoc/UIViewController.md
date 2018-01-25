# About UIViewControlelr.

**UIViewController**

- window : 사용자의 인터렉션을 제일 먼저 받는 객체
- 하드웨어 -> os -> window 

 - Application은 적어도 한개 이상의 UIViewController를 갖고 있음.
 	- 통상적으로 존재하는 ViewController는 **RootView**를 갖고있음.
 	- viewdidload에서 사용했던 self.view가 바로 RootView임.
 
 - **한 화면**은 하나의 UIViewController로 이루어짐.( 이 인스턴스는 RootView에 속해 존재)
 - 따라서 대부분의 앱은 여러개의 UIViewController로 이루어짐. (여러화면을 갖는다는 의미)

 - MVC에서 C의 역활을 한다.(Controller)
	- 모든 View의 관리( RootView 위에 addsubView되는 View들을 관리한다.)
	- 사용자의 이벤트 핸들링( User's Interaction)
	- UIController간의 전환( Segue)


**UIViewController 특징**

- child ViewController
	- UIViewController는 하나 이상의 child ViewController를 갖는다.(Container로써의 역활)
	- Container ViewController(부모와 비슷한 느낌.) 는 child ViewController의 RootView를 자신의 RootView에 addSubView하여 표현한다.
	- -> contain과 addSubView는 다른 개념임.

- UserInteraction 처리
	- 사용자로 부터의 모든 이벤트는 ViewController가 받아서 각 View에 해당되는 Method(Targeting)과 Delegate로 처리하게 된다.

- Data Marshaling
	- Data Model과 RootView위의 모든 UIView간의 중계 역활.

- Resource Management
	- UIViewController가 관리 하는 View, Instance들에 대해 Memory Issue가 발생 할 경우 인스턴스들에 대한 소멸 권한을 갖는다.. viewdidLoad하면 다시 불러올수있는데 이것을 스스로 해결하도록 구현되어 있음.
	- -> 메모리 부족 -> didReceiveMemoryWarning() -> ViewDidLoad()

	
	
