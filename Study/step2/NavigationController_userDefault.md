# Container View Controller : 
# Navigation ViewController,
# Navigation Bar ( Item)
# UserDefault
---
---

## Container View Controller

- View Controller의 Container역할을 하는 View Controller
- View Controller 간의 구조를 잡는 역할을 한다.
- 일반적으로 Root View를 가지고 있지 않고,View Controller를 Sub View Controller로 가지고 있다.

---
### 종류

|General View Controller(컨텐츠들)  | Container View Controller(컨텐츠들을 관리하기 위해서)|
| :--: | :--: |
| UIViewController | UINavigationController |
|	UITableViewController |	 UITabbarController |
| UICollectionViewController | 	UISpliViewcontroller |


- UINavigationController : 가장 많이 쓰인다. 
- UITabbarController : deapth 가 같거나, View의 성격이 완전이 다른 경우에 사용
	- 대게 커스텀해서 사용하는데, 커스텀하기가 생각보다 까다롭...
- UISplitViewController : child View를 사용하여 구현한다.

---
## NavigationController

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/navigaionControllerExam.jpg)


- UINavigationController class
- Navigation Controllers Manage Stacks of Other View Controllers
	- 다른 뷰 컨트롤러들의 스택을 관리한다.

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/navigation_stack.jpg)

- `NavigationController`는 `stack` 방식으로 동작하기 때문에 자료를 Pop 이나 Push 를 한다. 근데 이게 StackFrema에 남아 있는게 아니라, pop 될때 사라진다. 

- UINavigation Controller 
	- viewControllers
	- topViewController
	- visibleViewController
		- topView == visibleView

### 생성
- 코드로 생성
	- 화면 전환을 present와 dismiss로 하는것이 아니라 네비게이션의 push와 pop을 통해 진행.
	- 자동적으로 네비게이션에서는 탑바에 Back 버튼을 만들어준다.
<pre>
// AppDelegate.swift========================
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 코드를 통해 윈도우 생성하고 Root ViewController 만들기.
        // 스토리 보드를 지정 해 주지 않고 스토리 보드가 존재하는 상황에서 코드를통해 만들어 줄 수 있다.



        // 스토리 보드 사용하지 않고 코드로 ViewController 생성.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        // 네비게이션 컨트롤러 만들기
        let mainNavi = UINavigationController(rootViewController: mainVC)

        // window 인스턴스 만들기
        window = UIWindow(frame: UIScreen.main.bounds)//기기의 스크린 사이즈를 CGRect로 만들고 싶다.
        // 값을 반환해 주느냐 인스턴스를 반환하냐에 따라 타입 프로퍼티로 볼수 있냐 싱글턴으로 볼수 있냐가 정해짐.

        //window rootVC 지정.
        window?.rootViewController = mainNavi
        window?.makeKeyAndVisible()// key window가 존재한다? window가 여러개 존재 할 수 있다.
        
        return true
    }
//ViewController======================================
</pre>

- 스토리 보드로 생성
	- ViewController 선택 후 [에디터] - [임베디드인] - [네비게이션]
		- 화면 전환은 show로 진행.


## Navigation Bar

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/navigationBar.jpg)

- Navigation Bar Item으로 접근이 가능
- 네비게이션 인터페이스를 관리 하는 뷰
- navigation bar의 외관은 customize할수 있다. 하지만 frame, bounds, or alpha values는 절대 직접 바꿀수 없다

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/navigationBar2.jpg)

- Left Bar, Center, Right Bar
	- Left Bar에는 기본으로 <Back이 생김. 기능은 pop, backBarButtonItem이 기본형이라는 이야기임.
	- 커스텀을 통해 변경 가능
		- 커스텀을 통해 변경할때 오토레이아웃이 아닌 프레임 베이스로는 변경이 불가능하다.
		- 네비게이션 바 안에서는 자동적으로 오토레이아웃이 적용되기 때문에(IOS 11) 제약 조건을 정해 주는것으로만 크기 조절을 할 수 있다.(x,y 좌표는 의미가 없다.)


<pre>
// 예제...
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //left, 기본 을 사용 할 수 잇고, 커스텀도 가능.
        // 이미지를 넣을거면 오토 레이아웃으로 해야함.
        // 버튼을 넣고 이미지를 넣거나 하면 프레임 베이스로 해도 상관 X
        
        
        
//        let leftItem: UIBarButtonItem = UIBarButtonItem(title:"뒤로", style: .done, target: self, action: #selector(back(_:)))
        let leftItem: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(leftAction(_:)))
        leftItem.tintColor = .red// tintColor 시스템 자체의 색, 아이템 위에 addsubView되어 있는 view들에 대한 색 처리.
        //title
        self.navigationItem.title = "메인"// self.title = "타이틀" 동일.
        
        //right
        let rightItem: UIBarButtonItem = UIBarButtonItem(title: "???", style: .plain, target: self, action: #selector(alertAction(_:)))

        
        self.navigationItem.leftBarButtonItem = leftItem//item과 items는 하나를 넣을 것이냐 배열의 여러개를 다 넣을 것인가에 대한차이.
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    @objc func leftAction(_ sender: UIBarButtonItem){
   
        self.navigationController?.popViewController(animated: true)
        
    }

    @objc func alertAction(_ sender: UIBarButtonItem){
        let alert = UIAlertController(title: "pop 실행" , message: "오케이 눌러", preferredStyle: .alert)
        //alert의 버튼은 action 이라고 칭함.
        
        let action1 = UIAlertAction(title: "오케이", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func back(_ sender: UIBarButtonItem){
        
        self.navigationController?.popViewController(animated: true)
    }
</pre>


### tip
<pre>
- 인스턴스의 메소드에 파라미터들에 접근 하려면 인스턴스의 프로퍼티에 접근해보면 되겠죠?
- viewdidload에 만 히든 속성을 부여하면 화면이 전환될때 항상 유지되기 어렵다.( 뷰컨트롤러에 해당)
- viewwillappear에 히든 속성을 부여해야 잘 먹는다.
</pre>



## UserDefault

- 데이터 저장 방법
	- 파일 저장(프로퍼티 리스트(plist), sqlite, 아카이빙)
	- ios DataBase 이용. core Data
	- 서버 DB 이용.

### 설명

- 사용자의 정보를 저장하는 싱글톤 인스턴스(plist에 저장이 되게 된다)
- 간단한 사용자 정보를 저장/불러오기가 가능하게 만든 인스턴스이다.
- 내부적으로 Plist 파일로 저장되어 보안이 강하지 않다.(필요에따라 암호화 필요)
- 처음에 생성되면 Data 영역에 올라가게 되고, 다음에 불려질때에는 Data 영역에 접근해서 가져온다.
- 내부적으로 하나의 plist파일 하나를 갖고있다.

### 주요 프로퍼티, 메소드
<pre>
open class var standard: UserDefaults { get }
//데이터 불러오기
open func object(forKey defaultName: String) -> Any? 
open func string(forKey defaultName: String) -> String? 
open func array(forKey defaultName: String) -> [Any]?
//데이터 저장하기(plist 저장)
open func set(_ value: Any?, forKey defaultName: String)
//데이터 지우기
open func removeObject(forKey defaultName: String)
</pre>

### 예제
<pre>
    @IBAction func addAction(_ sender: UIButton) {
        
        if var list = UserDefaults.standard.array(forKey: key) as? [String]{// 불러와
            list.append(inputTxtField.text!)// 있으면 넣어줘
            UserDefaults.standard.set(list, forKey: key)
        }else{
            let newNameList = [inputTxtField.text]// 아니면 만들어 넣어줘.
            UserDefaults.standard.set(newNameList, forKey: key)
            
        }
        
    }
    
    @IBAction func printAction(_ sender: UIButton) {
    
        if let list = UserDefaults.standard.array(forKey: key) as? [String]{
            for n in list{
                if n == inputTxtField.text {
                    print("find")
                }
                
            }
        }
    }
    
</pre>







