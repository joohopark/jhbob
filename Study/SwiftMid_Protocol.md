# Application Life Cycle / UITextField / Protocol / Delegate / UIScrollView

## The Structure of an App

- IOS는 MVC 패턴을 통해 App을 구성한다.
	- Model : DataModel
	- Controller : Model과 View를 이어주는 컨트롤
		- UIApplication 인스턴스를 생성하며, 이 인스턴스는 Event Loop를 관리.
		- UIApplication 은 Application Delegate와 ViewContoller를 통해 이벤트를 처리
		- 화면 터치 발생 -> 하드웨어(화면)이 인식 -> IOS로 전달 -(특정 App에게 Port를 통해 전달. Event Queue에 전달.)> UIApplication으로 전달.
		- UIApplication : 각 Event, 현재 App의 상태등..
	- View : Controller가 처리할 주체를 정해주면 결과를 전달받은 후 화면에 결과를 보여줌.

<pre>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
 
int main(int argc, char * argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}//ViewController인스턴스 생성전에 위의 메인 코드를 통해 UIApplicationMain인스턴스가 생성된다.
</pre>

## Excution States for App

- App에는 각 상황마다의 상태가 존재.

- Not Running : App이 종료된 상태.
- Foreground : App이 실행되는 상태.
	- Inactive : 실질적으로 이벤트를 받고 있지 않는 상태, 미리 알림이나 여러 푸쉬들이 발생 해서 이벤트를 받을 수 없는 상태.
	- Active : 실질적으로 이벤트를 받을 수 있는 상태.
- BackGround : App이 종료되지 않았지만 화면에 보여지지 않는 상태, 백그라운드 상태에서 실질적인 동작을 하고 있는 상태. 예를들어 백그라운드에서 음악을 실행 하거나, 걸어온 길을 트래킹 하는 등의 동작을 뜻함.
- Suspended : App이 종료되기 직전, 백그라운드 상태에서 활동을 멈춘 상태. 빠른 재실행을 위하여 메 모리에 적재된 상태이지만 실질적으로 동작하고 있지는 않습니다. 메모리가 부 족할 때 비로소 시스템이 강제종료함.

## Call to the methods of your app delegate object

- 대부분의 상태변화를 AppDelegate 객체에 호출되는 메소드를 오버라이드하여 알아챌 수 있다.
	- 개발자는 해당 Class파일에 Override해서 Application의 상태를 조절 하도록 사용이 가능.
	- App의 상태를 관리하는 Delegate 클래스임.
	- UIViewControllerMain 인스턴스의 Delegate.
	- AppDelegate -> mainUI 로드 -> didFinishLaunchingWithOptions -> 

- application:willFinishLaunchingWithOptions:
	- 어플리케이션이 최초 실행될 때 호출되는 메소드
- application:didFinishLaunchingWithOptions:
	- 어플리케이션이 실행된 직후 사용자의 화면에 보여지기 직전에 호출.(ViewDid보다 훨씬 앞에서 호출됨, 실행 될때, Not Running에서 다시 실행 되었을때, push Notification등이 발생 해서 실행 될때.)
- applicationDidBecomeActive:
	- 어플리케이션이 Active 상태로 전환된 직후 호출.
- applicationWillResignActive:
	- 어플리케이션이 Inactive 상태로 전환되기 직전 호출
- applicationDidEnterBackground:
	- 어플리케이션이 백그라운드 상태로 전환된 직후 호출.
- applicationWillEnterForeground:
	- 어플리케이션이 Active 상태가 되기 직전에, 화면에 보여지기 직전의 시점에 호출.
- applicationWillTerminate:
	- 어플리케이션이 종료되기 직전에 호출.( 필수적으로 실행된다는 보장을 하지 않는다.)

<pre>
// print를 통해 상태 확인 결과.
// 막 실행 했을때
didFinishLaunchingWithOptions : 런치가 끝나고 App이 시작전.
applicationDidBecomeActive : App이 Active시작 전.

// 홈버튼 
applicationWillResignActive : App이 Active 상태를 Resign
applicationDidEnterBackground : App이 백그라운드 들어가기전.

// 다시 불러와
applicationWillEnterForeground : App이 ForeGround 가기전.
applicationDidBecomeActive : App이 Active시작 전.

// 홈버튼
applicationWillResignActive : App이 Active 상태를 Resign
applicationDidEnterBackground : App이 백그라운드 들어가기전.
</pre>

##Step of After Launch

- Launch Time
	- 사용자의 터치 (AppIcon)
	- main 함수 호출 됨.
	- UIApplicationMain 인스턴스 생성
	- main UI File 불러옴. ( 설정의 Main Interface에 설정. 스토리 보드를 가져옴)
	- First init : willFinishLaunchingWithOptions 시점.
	- Restore UI State
	- Finished Init : didFinishLaunchingWithOptions 시점.

- UIApplication 생성 -> AppDelegate( UIApplication이 호출해줌), mainUI(didFinishedLaunch가 window에 UI 인스턴스(스토리 보드의 UI들)를 올리는 역활을 대신 해줌, Is Initial ViewController(App의 실행시, 초기 VC를 정하는것이 아님, 해당 스토리 보드 안에서의 초기 로딩을 말함.) 속성을 통해 시작점을 변경 할 수 있다.) 불려옴. -> ViewController를 불러옴. -> ViewDidLoad가 호출 됨..


- Running
	- Activate App : applicationDidBecomeActive 시점.
	- Event Loop







#### Note
<pre>
ViewController 의 MainView를 통해 결과를 보여주는 거지 ViewCtroller != View이다.

ViewController간의 계층(상속X)을 통해 다른 ViewController를 컨트롤 할 수 있다.

StoryBoard는 StoryBoard Reference를 통해 이동이 가능하다( 한 프로젝트에 여러 스토리 보드를 갖을 수 있다.)

인터페이스 빌더로 화면 구성은 가능하지만 디테일한 구성을 알기 위해서는 코드로 작성해야 한다.
</pre>

#### Reference
[Apple Doc ALM](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html)



## UITextField 

- 


#### Note
<pre>
command + shift + k = App 구동시 키보드 소환.
</pre>


## Protocol

- 프로토콜은 원하는 작업이나 기능을 구현되도록 **메서드, 프로퍼티등으로 요구 사항의 청사진 혹은 구현해야되는 명세서같은것을 미리 정해서 정의내려놓는 개념.**
- 클래스, 구조체, 열거형은 프로토콜을 채택하면, 프로토콜에서 요구한 사항에 대해 구현해야 됩니다.
- 프로토콜을 통해 공통적인 작업을 강제 할수 있으며, 해당 프로토콜을 채택한 사람이 구현한 메소드에 대한 정보도 알수 있다.
- 구현 안되 있지만 이렇게 만들어라 혹은 만들겠다는 약속.
- 클래스, 구조체, 열거형은 프로토콜 채택시 프로토콜에서 요구 사항을 구현해야 함.
- 공통 작업을 강제 가능, 함수명, 리턴, 매개변수에 대한 강제성이 존재함.
- 프로토콜 또한 프로토콜을 채택 할 수 있다.


- **프로토콜을 채택했다 라는것은 사용하는 입장, 결국엔 구현을 해야한다.**
- **프로토콜을 작성했다 라는것은 제시하는 입장, 구현해야되는 내용을 제시해야한다.**
- 다른 의사소통없이 다수의 개발자가 큰 프로젝트의 일부들을 분업하여 만들 수 있는 설계적인 입장에서의 방법론.

<pre>
//Protocol example

protocol Runable {
	var regCount:Int {get set}
	func run() 
}

protocol Flying :Runable {
	var wingCount:Int {get set} 
}

class Animal: Flying{
	var wingCount: Int = 0 
	var regCount:Int = 0 func run(){
	} 
}

// 프로토콜의 프로퍼티는 모두 연산 프로퍼티의 형을 갖고 있지만, 연산 프로퍼티를 명시한것은 아님.
// 프로토콜에서는 접근제한자는 사용 할 수 없다.

//NSObjectProtocol을 채택하지 않은 경우에는 optional을 사용할 수 없다.
</pre>

- 추상 클래스의 Protocol
	- 프로토콜을 채택 한 클래스의 인스턴스들은 그 프로토콜을 채택 받았다라고 표현함.
	- 상속은 하나밖에 못 받지만 채택은 여러가지 채택이 가능함.
<pre>
프로토콜을 추상 클래스처럼 사용할수 있다.
다음과 같은 클래스가 있고, racing 이라는 함수를 구현하려고 한다면!
class Dog: Runable{ //...
}

class Horse: Runable{ //...
}

func racing(animals:[Runable]) -> Runable {
}

//프로토콜타입으로 사용가능하다.
let winner:Runable = racing(animals: [Dog(),Horse()])// 프로토콜 Runable을 채택했다면 같은 타입의 인스턴스로 봐도 상관이 없다
</pre>

## Delegate

- 델리게이트는 **클래스나 구조체에서의 일부분의 할 일을 다른 인스턴스에게 대신 하게 하는 디자인 패턴**
- **뷰가 받은 이벤트나 상태를 ViewController에게 전달해주기 위해 주로 사용**된다.(ex:UIScrollViewDelegate...)
- ViewController를 통해 **View구성에 필요한 데이터를 받는 용도**로도 사용(~DataSource로 어미를 붙여 구현.)(ex:UITableViewDataSource)


- selector 인스턴스를 통해 objc 메소드를 주고 받아 target의 액션을 수행하도록 하는 위임자의 역활을 받는다.
- Data를 주고 받는다. 결국은 메소드를 주고 받는다는 것과 동일 하다.
- notification, delegate 역시 인스턴스간에 메소드를 주고받아 데이터를 주고 받게 된다.


- 대표적인 예제로 UIApplication 는 AppDelegate를 통해 App의 상태를 전달 받는다.
- Delegate를 사용할려면 Protocol을 통해 구현을 해야한다.
	- 같은 Protocol을 채택한 클래스여야 Delegate 패턴을 사용할 수 있다.
	- Protocol은 채택한 Class에서 구현해야 될 프로퍼티, 메소드를 선언만 해놓는다.( 채택한 Class안에서는 이를 필수로 구현해야한다)
	- **optional** 키워드가 앞에 붙어 있을 경우 궃이 구현을 하지 않아도 된다.
	- default는 requierd로 필수적 구현을 해야한다.
	- Protocol > Delegate 정도로 개념이 정리됨.(Delegate가 더 작은 개념)
- Delegate의 메소드이름들은 **호출되는 시점**을 명시하도록 한다.(**Delegate는 이벤트가 발생하는 시점이 중요함**)
	- should 는 대부분 리턴은 갖는다.
	- did는 대부분 리턴이 없다.
- 클래스, 구조체에서 할 일을 다른 인스턴스에게 대신 하라 라고 하는 패턴
- example : 뷰가 해야 할일을 뷰컨이 대신 처리하게 끔 하는형식

- 쫄따구는 델리게이트가 있음 실행이 되도록
	- 어떠한 데이터나 액션이 필요한 시점에 이벤트가 발생하도록 해야 함. (메소드의 실행)
- 대장은 델리게이트를 실행되도록 구현.(ex: ViewController)
	- 쫄따구가 채택한 프로토콜의 메소드등을 구현해서 메소드가 실행되도록 함.

- 델리게이트의 상하 관계는 시간 상의 상하 관계라고 이해해도 될듯.
	- 먼저 구현되는 것이 예전에 구현된것을 쫄따구, 나중에 구현되는것이 대장.

<pre>
// Delegate 선언부
class CustomView: UIView {
	var delegate:CustomViewDelegate?//받아옴...2 특징-1
	override func layoutSubviews() {// 특정 시점이 되면, 해당 메소드가 호출됨....3
		delegate?.viewFrameChanged(newFrame:self.frame)//부모의것을 호출함...4. 특징-3
	}
}

protocol CustomViewDelegate {
	func viewFrameChanged(newFrame:CGRect)// 특징-2
}

// Delegate 구현부
class ViewController: UIViewController, CustomViewDelegate{
	override func viewDidLoad(){
		/**/
		customview.delegate = self // viewcontroller의 인스턴스 주소를 넘겨줌... 1
		/**/
	}
	
	func viewFrameChanged(){
	// 구현 할 부분.... 5번째 실행 부분.
	}
}
</pre>
	

- 델리게이트 선언부를 구현 == 대리자
	- 테이블 뷰 에서 처럼 이전 구현자가 그 당시 결정 하지 못하거나 결정 할 필요 없는것들을 추상화 시켜놓는다는것.
	- 이전에 구현한 놈이 나중에 구현할 놈에게 코딩을 대리시키는거임.
	- 재사용성을 높이기위한 개념으로 OOP적 특성을 내포한다.
	- 스택뷰의 내용에 따라 스택뷰가 변하기도 함.
	- 안의 내용의 크기가 유동적으로 변함에 따라 스택뷰의 사이즈가 커지기도함.
	- 텍뷰, 레이블, 스택뷰 등이 내용물의 양에 따라 height가 정해지기때문에 사이즈가 결정된다.. 이말은 내용물의 height가 결국 담고있는 것의 height이기때문인듯...헌데 뷰는 안됨...

<pre>
//예를들어 키보드의 return 키를 눌렀을때 자판이 내려가는 textField를 구현 하고자 할 때 
//textField의 UITextFieldDelegate 프로토콜을 VC가 채택했을 경우.
//textFiedl안에는 아마 이런식일 거임.
class textField: UIView {
	var delegate: UITextFieldDelegate?
	override func ~~메소드() {
		delegate?. textFieldShouldReturn(textField:self.frame/*선언부의 self가 들어감을 주목 : VC에서 VC의 주소값을 받아오고 입력값으로 선언부의 인스턴스를 집어 넣으므로써 구현 됨 여부와 상관없이 서로 이어지는(?) 역활을 하게 된다.*/)
	}
}


//===============VC===========================================
	override viewDidLoad(){
	//...........
	}
	
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     // 구현부
        textField.resignFirstResponder()// responder를 빼앗는다.
        return true
    }
</pre>



## UIScrollView

- ViewSize 보다 확장된 뷰를 보기위한 View
	- ContentsView : 전체 화면 
	- ScrollView : 실질적으로 보이는 화면

- lable 은 String, imageView는 image, ScrollView는 UIVIew를 보여주는 역활.
	- ScrollView위에 무엇인가 표현 할려면 당연히 ScrollView 위에 subView 해줘야 겠져~?
- isPagingEnable 속성은 페이지 단위로 보여줄지를 결정하는 속성.
- 컨텐츠 뷰의 오프셋은 스크롤 뷰의 원점을 표시하게 된다. CGPoint 타입의 x, y값.
	- 강제로 오프셋을 지정 할 수도 있고, 애니메이션 또한 넣을 수 있다.
- scrollView는 컨텐츠 뷰의 사이즈가 이미 정해져 있는 상태에서 만들 수 있다.
	- 유동적인 스크롤이 들어가야 될 경우에는 테이블 뷰가 적당하다.
- 스크롤 뷰를 화면에서 터치해서 움직이려 할 경우 해당 이벤트는 VC가 받게 된다. 
	- 스크롤 뷰 인스턴스가 갖고 있는 속성을 VC에서 컨트롤 하고 싶어? 그래서 델리게이트가 구현되어있어요~

<pre>

class ViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sc = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        sc.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        sc.delegate = self// 델리게이트 여 있네~
        
        view.addSubview(sc)
        
        for num in 0..<20{
            
            let row = CGFloat(num%10)
            let colum = CGFloat(num/10)
            
            let view = UIView(frame: CGRect(x: colum*100, y: row*100, width: 100, height: 100))
            view.tag = num
            view.backgroundColor = UIColor(red: CGFloat(colum)*0.1, green: CGFloat(row)*0.1, blue: CGFloat(num)*0.1, alpha: 1)
            
            sc.addSubview(view)
        }
        
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX: CGFloat = scrollView.contentOffset.x
        let colorValue:CGFloat = 1 - (offsetX/(scrollView.contentSize.width - scrollView.frame.size.width))
        
       
        print("current OffsetX : \(offsetX)")
        print("current scrollView.contentSize.width : \(scrollView.contentSize.width)")
        print("current scrollView.frame.size.width : \(scrollView.frame.size.width)")
        print("current scrollView.bounds.origin.x : \(scrollView.bounds.origin.x)")
        print("current ColorValue : \(colorValue)")
        scrollView.backgroundColor = UIColor(red: 0, green: colorValue, blue: 0, alpha: 1)
    }
    

}

</pre>

