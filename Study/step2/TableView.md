# UITableView

![screen](/study/image/tableview.jpg)

- UITableView : 데이터를 row들로 정렬하여 단일 column으로 보여줌.
	- TableView는 단일 열에 항목들의 리스트를 표현한다.
	- UITableView는 UIScrollView의 자식클래스로 스크롤 기능은 오직 수직 스크롤만 가능하다.
	- TableView는 ViewController의 RootView(컨버스)위에 위치 하여 작동 하며, ViewDidLoad나 기타 View를 구성하는 lifeCycle위의 함수에서 구현에 사용하기 위해 Protocol(DataSource, Delegate)를 사용한다.
	- DataSource : 프로토콜을 사용하여 테이블뷰에서 보여줄 데이터를 관리할 대리인의 역할을 정의해 둔것, 여기서 대리인은 ViewController
	- Delegate : 프로토콜을 사용하여 테이블뷰의 대리자로써 수행 할 수 있는 역활을 정의해 둔것으로 여기서 대리인은 역시 ViewController


## TableView의 Reusable Queue

- 테이블의 테이블 Cell이(row가) 약 100만개라고 할때 이 Cell들을 한번에 다 생성해 놓고 사용자의 interaction을 기다린다면 어떻까?<br>
 사용자는 모든 UI가 로드되는걸 기다리다 지칠 것이다.<br>
 UITableView는 이것을 지양하기 위해서 ReusableQueue(재사용 큐)를 사용한다.<br>
 사용자가 화면을 움직여 TableView의 Cell이 화면에서 사라지고 나타날때 이 Cell들은 재사용큐에 Enqueue, Dequeue된당.
 ViewController안에서 cellForRowat을 통해 cell을 생성할때, 재사용큐에 현재 들어가있는 Cell이 있는지 확인하고 있다면 dequeue를 통해 이를 재사용한다. 

> 위개념은 정말 중요한 개념이다.. 이것 때문에 CellForRowAt에 UI를 생성해서 사용하여 Cell에 올리거나 해서는 안된다...! 
> 
> 만약 Cell에 뭔가를 추가하거나(UI) 변경하고 싶다면 Custom Cell을 만들어 사용해야함..
> 
> 특정 셀을 지정해야된다..? 그럼 Cell에 Key값을 지정해줘야 줘!


- accessory views
	- Cell은 제목, 이미지들을 갖을 수 있고 오른쪽 가장자리 근처에 엑세서리 뷰들이 있다.( disclosure indicators, detail disclosure)
	- section, row들은 index num으로 구별이 가능하다. (indexpath : (section,row))

<pre>
extension IndexPath {
    /// Initialize for use with `UITableView` or `UICollectionVie
    public init(row: Int, section: Int)
    /// The section of this index path, when used with `UITableVi
    ///
    /// - precondition: The index path must have exactly two elem
    public var section: Int
    /// The row of this index path, when used with `UITableView`.
    ///
    /// - precondition: The index path must have exactly two elem
    public var row: Int
}
</pre>

- 일반적으로 TableView는 데이터(Array, Dictionary등)에 의거하여 row를 구성한다.
	- 음악을 가져와 리스트로 만들어준다던가.. 사진등을 받아와 구성한다던가..

## Plain Table View

![screen](/study/image/plainTableView.jpg)

- 기본적인 Table View
- 여러개의 Section을 가질수 있다.
	- aka 연락처의 ㄱㄴㄷㄹㅁㅂㅅ
	- indexList를 통해 빠르게 검색 및 접근이 가능 하고 이놈은 네비게이터 바로 구성..
- 한 Section에는 여러개의 Row를 포함.
- 각각의 Section에는 Section을 표시하는 header, Footer title을 사용할 수 있다.

## Grouped Table View

![screen](/study/image/groupTableView.jpg)

- 각 Section을 Group의 형태로 나타내는 테이블 뷰
- 데이터의 디테일한 정보를 표현할 떄 많이 사용된다.
- group으로 만들어질 경우에는 header와 footer를 통해 각 섹션을 나누게 된다

### Protocol
- DataSource
	- 프로토콜을 사용하여 테이블뷰에서 보여줄 데이터를 관리할 대리인의 역할을 정의.
- Delegate
	- 프로토콜을 사용하여 테이블 뷰의 대리자로써 수행할 수 있는 역활들을 정의.
		1. 헤더 또는 풋터의 높이를 설정 : Variable height support
		2. 헤더 또는 풋터 뷰를 제공 : Section Informations.
		3. 셀을 선택하였을 때 수행할 동작 관리 : Selection
		4. 셀의 삭제 될 때의 동작 등의 관리 : Editing
		5. 기타 등등

<pre>
let tableView: UITableView = UITableView(frame: , style:/*.group .plain*/ )

tableView.datasource = self
tableView.delegate = self
tableView.register(_, forCellReuseIdentifier: )
/*주요 메소드*/
@requires
numberOfRowsInSection : 각 섹션별 Row 갯수
cellForRowAt : Row 별 Cell 객체. Cell이 300번 불리면 300번 불려야 하는데 deqeueReusableCell을 통해 기존에 만들어진 Cell을 재사용하여 오버헤드를 줄인다.
@optional
numberOfSection : 섹션의 갯수.. 해당 메소드가 없다면 섹션은 1개
</pre>

## Implement UITableView Using Code(with: NavigationController)

<pre>
//=================AppDelegate.swift
var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // storyboard 인스턴스 생성
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)// 여기서 스토리보드 인스턴스는 development Info의 Main InterFace를 의미하며 스토리보드의 엔트리 포인트를 의미한다.
        
        // storyboard 인스턴스를 통해 ViewController의 인스턴스를 생성.
        let mainVC = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        // 네비게이션 컨트롤러 인스턴스 생성
        let navi = UINavigationController(rootViewController: mainVC)
        // window 인스턴스 생성
        window = UIWindow(frame: UIScreen.main.bounds)
        // window의 rootVC 지정.
        window?.rootViewController = navi
        // 만든 window를 key Window로 만들고 visible하게 한다.
        window?.makeKeyAndVisible()
        return true
    }
//=================ViewControlelr.swift
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var month = [31, 28, 31, 30, 31, 30, 31, 30, 31, 30, 31, 30]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return month[section]
    }//섹션당 로우 수 결정
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section+1)월 \(indexPath.row+1)일"
        return cell
    }// 로우에 들어갈 셀 결정.
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section+1)월"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NextViewController") as! NextViewController
        nextVC.prevData = tableView.cellForRow(at: indexPath)?.textLabel?.text
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UITableView 인스턴스 생성
        let examTableView = UITableView(frame: view.bounds, style: .plain)
        // UITableView delegate, dataSource 프로퍼티에 ViewController 인스턴스를 넣어줌
        examTableView.delegate = self
        examTableView.dataSource = self
        // deqeue(reusable qeue)에 cell이 없을 경우 선등록 해줌.
        examTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(examTableView)
    }
}
//=================NextViewController.swift
class NextViewController: UIViewController {

    var prevData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        if let _prevData = prevData{
            label.text = _prevData
        }
        view.addSubview(label)
        // Do any additional setup after loading the view.
    }
}
</pre>


## Implement UITableView Using StoryBoard

<pre>
//==================Main.storyBoard
ViewController 선택 - [에디터]-[임베디드인]-[네이게이션 바].
ViewController안에 TableView, TableViewCell을 끌어다가 생성.
ViewController Scene의 TableView와 ViewController간 Delegate,DataSource 관계 설정
TableView의 Attribute inspector에 Reusable Identifier 설정.
//==================ViewController.swift
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var month = [31, 28, 31, 30, 31, 30, 31, 30, 31, 30, 31, 30]
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return month[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section+1)월 \(indexPath.row+1)일"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return month.count
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
</pre>



