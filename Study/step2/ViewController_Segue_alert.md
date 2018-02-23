# ViewController 특징 ,
# VeiwController간 화면 전환(코드/ 인터페이스 빌더) ,
# UIAlertController
---
---

## ViewControlelr


<p align="center">

![screen](/study/image/RootView.jpg) 

</p>

- 앱의 기초가 되는 내부 구조
- 모든 앱은 적어도 한개 이상은 ViewController를 갖고 있으며 대부분 앱은 여러 ViewController로 이뤄져있다.
	- 그리고 그한개 이상의 ViewController는 UI들을 올릴수 잇는 Root View 가 존재한다.
- ViewController는 화면에 보이는 scene을 관리하는 역활을 하며 화면 자체를 뜻하는것은 아님.
	- window 는 하나이상을 뷰컨트롤러를 필요로 한다.
	- 화면전환 : 뷰들이 스택의 형태로 push 된다.
	- ViewController는 하나의 RootView를 갖고 있다.
- 사용자의 인터렉션과 앱의 데이터 사이에서 컨트롤의 역활을 한다.
- ViewController는 View 관리, 사용자 이벤트 핸들링, ViewController간의 전환 등을 위한 메소드와 프로퍼티를 가지 고 있다.

- MVC MVC MVC 가 있으면 각 컨트롤끼리 이어져 있음..
	- Swift에서는 ViewController가 컨트롤이며 해당 컨트롤 끼리 이어지는 구조를 이루게 된다.
- C가 외부와 연결 되어있어야 MVC패턴에 바람직하다. (각 뷰끼리 통신? 모델끼리 통신? 바람직 하지 않다..하지만 언어팩의 데이터를 받아오고자 할떄? 언어팩은 앱에 단 하나만 존재해도 상관이 없는 경우.)
- View에 이벤트가 발생 -> Controller는 델리게이트를 통해 해당 이벤트를 처리.

---
### Container

- 한 화면에 하나의 ViewControlelr를 갖는다고 봐도 상관없다, 하지만 아이패드의 경우에는 ViewController를 두개를 사용하여 하나의 ViewController가 또 다른 ViewController를 컨트롤 하여 하나의 화면을 구성 할 수 있다.
	- Slack의 화면 구성 맹키로..SplitViewController
	- Child UIViewController : 하나의 뷰컨트롤러가 또다른 하나의 뷰컨트롤러의 container를 갖을수 있도록 하는것.

---
### UserInteraction
- **UIViewController는 UIResponder를 상속받은 클래스**로, 이벤트 체인으로부터 오는 이벤트는 효과적으로 처리한다.
- **즉 사용자의 모든 이벤트는 ViewController가 받아서 각 View에 해당되는 Method와 Delegate로 처리**한다.
	- 따라서 UIResponder를 상속 받지 않으면 사용자의 이벤트를 처리 할 수 없다. (UIImageView)

---
### Data Marshaling

<p align="center">

![screen](/study/image/dataMarchal.jpg) 

</p>


- ViewController는 자신이 관리하는 View들과 앱 내부의 데이터와의 중계자 역할을 한다.
	- 직접 모델과 뷰간의 데이터를 주고 받는건 옳지 않다.
- 결국엔 ViewController는 MVC에서 V와 C의 역활을 다 하는 애매한 녀석이다..

### Resource Management
- ViewController안에 있는 모든 View나 Object는 모두 ViewController의 책임이다.
- 메모리가 부족시 didReceiveMemoryWarning() 메소드가 자동 으로 불리며, 오래동안 사용하지 않은 객체와 다시 쉽게 만들수 있는 객체를 제거할수 있어 메모리를 효율적으로 관리한다.
	- 메모리에 문제가 있을때 화면에 문제가 있을때 해당 이벤트는 이 메소드에서 처리가 가능.
	- viewdidload는 화면에 뿌릴 인스턴스를 생성해야 할때 불림.
- 그래서 ViewController가 TableView의 DataSource를 .....

## ViewController 종류

- General View Controller
	1. UIViewController Root View = UIView
		- 일반적인 ViewControlelr를 의미.
		- 각 View Controller가 Root View를 가지고 있다.
	2. UITableViewController Root View = UITableView
	3. UICollectionViewController = UICollectionView

- Container View Controller
	1. UINavigationController 
		- 네비 안에 뷰컨이나 탭바, 네비를 안에 넣을 수 없다..UX 가이드상..
		- 상단에 네비게이션 바가 존재 해야함. 따라서 네비게이션을 또 포함 하게 되면 분기가 생기게 되어 구조가 복잡 해짐
		- 네비게이션 바는 스택의 구조로 이뤄지기 때문에 안됨.
	2. UITabbarController
		- 탭바 안에 뷰컨이나 다른 네비컨등을 포함 시킬 수 있다.
		- 하단에 탭바가 있고 상황에 따라 어떠한 뷰컨트롤러를 호출하는 개념
		- 탭바는 화면 호출이기때문에 다른 뷰들을 포함 할 수 있다.
	3. UISplitViewController
	4. .....etc....

## UIViewController 생명 주기

<p align="center">

![screen](/study/image/viewLifeCycle.jpg) 

</p>

- 프로그래머가 직접 호출 불가
- 필요하다면 오버라이드 해야 하는 메소드이므로 꼭 해당 메소드 내에서 **super.메소드** 을 통해 기존 메소드를 꼭 호출해야 된다

- UI 의 생성.
	- 스토리보드로 UI 만들고 -> 인스턴스 생성
		- xib : 스토리보드를 쪼갠 형태, 하나의 뷰컨트롤러임.
	- 코드로 UI 만들고(viewdidload) -> 인스턴스 생성.

<pre>
// 생명 주기 관련 ViewController 메소드
override func loadView() : UIViewController의 view가 생성될 때 호출
override func viewDidLoad() :  
UIViewController가 인스턴스화 된 직후(메모리에 객체가 올라간 직후) 호출 처음 한 번 세팅해 줘야   하는 값들을 넣기에 적절
override func viewWillAppear(_ animated: Bool) : 
view가 화면에 보여지기 직전에 호출 화면이 보여지기 전에 준비할 때 사용.  
animated 파라미터는 뷰가 애니메이션을 동반하여 보여지게 되는지 시스템에서 전달해주는 불리언 값
override func viewWillLayoutSubviews() : view의 하위뷰들의 레이아웃이 결정되기 직전 호출
override func viewDidLayoutSubviews() :  
view의 하위뷰들의 레이아웃이 결정된 후 호출. 주로 view의 하위뷰들이 사이즈 조정이 필요할 때 호출
override func viewDidAppear(_ animated: Bool) :  
view가 화면에 보여진 직후에 호출. 화면이 표시된 이후 애니메이션 등을 보여주고 싶을 때 유용
override func viewWillDisappear(_ animated: Bool) : view가 화면에서 사라지기 직전에 호출 
override func viewDidDisappear(_ animated: Bool) : view가 화면에서 사라진 직후에 호출
</pre>


## ViewController 간 화면 전환

- 코드로 present와 dismiss 하는 방법.(VC <-> VC)
	- 넘길 VC를 인스턴스로 만드는 방법
		- init을 사용
		- xib를 사용
		- storyboard 인스턴스 생성 해서 사용.
<pre>
// storyboard 인스턴스 생성 해서 사용.
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let storyVC:StoryViewController = storyboard.instantiateViewController
(withIdentifier: "StoryViewController") as! StoryViewController
self.present(storyVC, animated: true, completion: nil)
// xib를 사용
let xibVC: NextViewController = NextViewController(nibName: "NextViewController", bundle: nil)
self.present(xibVC, animated: true, completion: nil)
//init 사용
let initVC: InitViewController = InitViewController()//xib파일이 없고 따로 명시하지 않아도 ViewController 는 생성 된다.
self.present(initVC, animated: true, completion: nil)
</pre>


<p align="center">

![screen](/study/image/seguePresent.jpg) 

</p>


<p align="center">

![screen](/study/image/seguePresent2.jpg) 

</p>

- 인터페이스 빌더에서 세그에를 사용.
	- control키 를 통해서 modally를 설정.

- present modally
	- 현재 화면의 정보와 상관없이 새로운 정보를 제공하고자 할때 
	- 아래에서 위로 올라오는 에니메이션이 기본.(enum으로 만들어진 transition을 통해 설정)
		- ViewController.modalTransitionStyle 프로퍼티에 enum case를 넣어 설정.
	- dismiss로 다시 전환을 해야지 딴방법으로는 사용해선 안됨.


<p align="center">

![screen](/study/image/unwindSegue.jpg) 

</p>

- segue(<=> unwind segue)
	- 세그에 또한 하나의 객체. 
	- 앱의 인터페이스 흐름을 정의하는 데 사용.
	- Storyboard 파일 내 두 개의 ViewController사이의 화면전환을 정의.
	- Segue의 시작점은 button, tableView의 row, gesture등으로 시작하며 끝점은 전환되는 다음 ViewController이다.
	- segue는 일반적으로 다음 ViewController로 진행되는 것을 가 르키나, unwind segue를 통해 ViewController를 닫는 역할도 할수 있다.
	- 로그인 화면과 같이 특정 정보 확인이 후 화면 전환이 이뤄지거나, 특정 데이터를 다음 화면으로 넘겨주거나 하는 기능이 필요하다. segue에 대한 메소드등을 통해 화면간 전환을 설정해야한다,
	- show 옵션의 경우에는 NC와 VC간의 이동 모두에 화면 전환 용으로 사용됨.(present modally와 동일하게 이어짐.)
	- show detail, popover등은 아이패드에 서 사용되는 속성..




### Modifying a Segue’s Behavior at Runtime

<p align="center">

![screen](/study/image/excuteSegue.jpg) 

</p>

- 화면 전환 시작
- 세그에 식별자 확인(shoudperformsegue 메소드) -> Bool
	- override해서 식별자를 통한 조건을 정해줌.
- 세그에 인스턴스 생성
- 세그에 준비(prepareforsegue, prepare메소드)
	- override해서 세그에 전에 데이터를 넘겨주려 할때, 전에 뭔가 수행 해야 할때 사용.
		- prepareForSegue: 세그전에 Bool을 통해 세그를 진행 할것인지 말것인지를 결정.
		- prepare : 세그가 진행된다면 세그가 됨에 있어 정보를 넘겨주거나 해야 할경우 이 메소드에 넣어 넘겨준다. 
- 새로운 화면 전환

####tip
<pre>
//옵셔널과 다운케스팅을 한번에!
if let test = down.testing as! donwCasting{
// 다운캐스팅이 실패 한다면 test가 nil이 되기떄문에 이곳은 무시된다.
}
</pre>


##UIAlertController
- Alert 창을 띄울수 있도록 Alert창을 만들어 줄수 있도록 하는 Class
- UIAlertController인스턴스 안에 UIAlertAction 인스턴스를 addACtion하여 Alert에 Action을 처리하도록 할 수 있다.
- self(현재 뷰)에 present를 사용하여 alert를 화면에 뿌려줄 수 있음.
- preferredStyle은 .action과 .actionSheet가 있음. 각 종류별로 Alert창의 모양이 다르다.

<pre>
  @IBAction func actionSheet(_ sender: UIButton) {
        let alert = UIAlertController(title: "title", message: "액숀쉿", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "OK", style: .destructive) { (action) in
            self.viewB.backgroundColor = .black
        }
        let action2 = UIAlertAction(title: "No", style: .cancel) { (action) in
            self.viewB.backgroundColor = .yellow
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func action(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: .alert)//preferredStyle은 enum .actionSheet action 버튼 위치가 바뀜..
        //alert의 버튼은 action 이라고 칭함.
        
        let action1 = UIAlertAction(title: "오케이", style: .default) { (action) in
            //해당 버튼 클릭 되면 발생될 이벤트
            // addTaget 같은 느낌.
            self.viewA.backgroundColor = .green
        }
        
        let action2 = UIAlertAction(title: "취소", style: .cancel) { (action) in
//            취소시 발생될 이벤트
            self.viewA.backgroundColor = .red
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true, completion: nil)// 프레젠트로 화면을 전환.
    }
</pre>

#### - 결과


<p align="center">

![screen](/study/image/alert.jpg) 

</p>

<p align="center">

![screen](/study/image/actionsheet.jpg) 

</p>
