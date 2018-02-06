# UI Basic/ UIView

## 단위.

- Pixel : 실제 이미지 사이즈
- Point : 화면에 표시되는 이미지 사이즈

레티나 이후부터 pixel을 잘게 더 쪼개어 표현 해주기때문에 단위를 point로 가져감..

## Frame Base

- frame Base, 좌표계 : View 기준 좌측 상단 (0,0)
	- View의 위치를 표현 할때는 상위 view를 기준으로 표현.(기준은 프레임 기준으로 좌표를 인식)
	- Auto resizing Mask등을 통해 화면 변화 대응.
- Autolayout : 제약을 통해 UI를 표현.


### note
<pre>
FrameWork : 응용 프로그램 표준 구조를 구현하는 클래스와 라이브러리 모임.

재사용 가능한 수많은 코드를 프레임웤으로 통합 해 놓음 으로써 개발자가 새로운 Application을 위한 표준 코드를 작성하지 않도록 해줌.

UIKit : cocoa touch framework에서는 UI 관련 기능 클래스가 모여있는 프레임 웤.

UIMapKit, corelocationKit 등등..

objc 에서 넘어온 개념들의 kit들은 NSObject를 상속 받는다.
</pre>

## UIResponder
- 이 클래스는 이벤트와 respond에 관한 객체들의 인터페이스들의 정의한다.

- 주요 항목(메소드)
<pre>
open func becomeFirstResponder() -> Bool
// 첫번째 응답을 갖게 됨.(커서, 포커스)
open func resignFirstResponder() -> Bool
// 응답을 내려놓는다.
open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)//터치했을때 UI 좌표를 계속 움직여야 할때
open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
// 사용자가 UI를 터치했을때, 터치에 관련된 정보가 touches 파라미터에 해당되게 됨.
</pre>


## UIView

- 가장 기본이 되는 VIew
- UIComponent들의 조합으로 화면이 구성됨.
	- (-> UIView를 상속받은 객체들로 화면이 구성.)

- x,y, width, height 로 표현 가능. ( 사각형으로만 표현 가능)
- 이 클래스를 상속받는 UI들이 대부분이기 때문에 지속적으로 봐놓는게 좋다.

## UILable
- String 인스턴스를 뿌려줌.

## UIImageView 
- UIImage 인스턴스를 화면에 뿌려줌.
	- UIViewContentsMode : 화면에 어떻게 보여줄 것인가..
	- 이미지 추가전에는 항상 프로젝트에 copy한 후에 build phase에 copy bundle resources에 가서 추가 해줘야 한다.

	
## UIButton 
- UIComponent에 사용자 인터렉션에 의한 응답에 대해 특별한 액션을 줄수 있게 설정하는 클래스
	- UIControl을 상속 받았음. (addTarget)
	- 생성시 입력하는 타입은 버튼의 타입
		- Sysyem, custom, contentsAdd등..


### note
<pre>
public init(frame: CGRect)// 좌표계 초기화
open var tag: Int// Int자료형 UIView 인스턴스의 식별 프로퍼티
open var layer: CALayer { get }// UI를 원으로 만들고자 할때
open var frame: CGRect// 슈퍼 뷰 기준
open var bounds: CGRect// 주변 값 기준
open var isMultipleTouchEnabled: Bool// 다중 터치 가능여부
open var clipsToBounds: Bool// 다중영역으로 자를떄, 현재 프레임 사이즈 밖의 것들을 잘라 표현할것인지 여부
open var backgroundColor: UIColor?// 배경 값
open var isHidden: Bool// 숨김 여부(alpha: 투명도, 투명도를 높이는것과는 다른 의미, 아예 존재 하지 않도록)
open var contentMode: UIViewContentMode

open func addSubview(_ view: UIView)// 자식 뷰 추가( 메인 UIView 위에 자식 뷰들이어야 화면상에 표시된다)
open func insertSubview(_ view: UIView, at index: Int)// 자식뷰들은 상위뷰 위에 위치가 배열로 들어가기 떄문에 insert로 계층 중간에 넣을 수 있다.)
open func removeFromSuperview()
open func layoutIfNeeded()//
</pre>


####tip!
<pre>
NS_AVAILABLE_IOS(version)// 지원 가능한 최고 버전, 이하 버전일 경우 crash
// 오픈 소스를 사용할때 꼭 확인 하고 사용..
</pre>

#### UI 만들기를 할 때 반복문을 사용하여 코드를 간결하게 하기

<pre>
    /// UI인스턴스 만드는 메소드
    // addsubview만 하고 추가적으로 frame은 정하지 않는다.
    private func createUI()
    {
        //mainView에 추가되는 가장 큰 영역
        displayView = UILabel()
        // label
        // 우측 정렬, 초기화 0, 텍스트 폰트, 텍스트 색상.
        displayView.text = "0"
        displayView.textAlignment = NSTextAlignment.right// 문자 우측 정렬.
        displayView.font = UIFont.systemFont(ofSize: 100)
        displayView.textColor = UIColor.white
        view.addSubview(displayView)
        
        
        keyPadView = UIView()
        view.addSubview(keyPadView)
        
        //keyPad에 추가되는 영역
        etcView = UIView()
        keyPadView.addSubview(etcView)
        operView = UIView()
        keyPadView.addSubview(operView)
        numberPadView = UIView()
        keyPadView.addSubview(numberPadView)
        
        
        //test를 위한 색상 지정
        displayView.backgroundColor = .darkGray
        keyPadView.backgroundColor = UIColor.black
        //        etcView.backgroundColor = UIColor.red
        //        operView.backgroundColor = UIColor.blue
        //        numberPadView.backgroundColor = .yellow
        
        etcBtnList = makeBtn(count: 3)// -> [UIButton]
        let etcTitleList = ["C","+/-","%"]
        //속성이 비슷한 버튼을 반복문으로 처리
        for index in 0 ..< etcBtnList.count
        {
            let title = etcTitleList[index]
            let btn = etcBtnList[index]
            btn.layer.borderWidth = 1//버튼의 테두리 선 굵기 , layer는 렌더링에 사용되는 view의 프로퍼티
            btn.layer.borderColor = UIColor.darkGray.cgColor
            btn.setTitle(title, for: .normal)// .setTitle은 버튼 텍스트. 특정 액션을 정함.
            btn.addTarget(self, action: #selector(self.etcHandler(_:)), for: .touchUpInside)
            etcView.addSubview(btn)
        }
        
        operBtnList = makeBtn(count: 5)
        let operTitleList = ["+","-","*","/","="]
        for index in 0 ..< operBtnList.count
        {
            let title = operTitleList[index]
            let btn = operBtnList[index]
            btn.setTitle(title, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            btn.addTarget(self, action: #selector(self.oprationHandler(_:)), for: .touchUpInside)
            operView.addSubview(btn)
        }
        numberBtnList = makeBtn(count: 10)
        
        let numberTitleList = ["7","8","9","4","5","6","1","2","3","0"]
        for index in 0 ..< numberBtnList.count
        {
            let title = numberTitleList[index]
            let btn = numberBtnList[index]
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.orange, for: .highlighted)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            btn.addTarget(self, action: #selector(self.numberHandler(_:)), for: .touchUpInside)
            btn.addTarget(self, action: #selector(self.numberDown(_:)), for: .touchDown)
            numberPadView.addSubview(btn)
        }
        
    }
    //UI인스턴스 프레임 설정 메소드
    private func updateLayout()
    {
        //버튼은 화면의 가로에 4개씩 배치할 것이기 때문에 전체 뷰/4
        let btnWidth:CGFloat = self.view.frame.size.width / 4
        //아래에서부터 배치
        var offSetY:CGFloat = self.view.frame.size.height - (btnWidth * 5)
        
        //=======================================
        //keyPad영역 프레임
        keyPadView.frame = CGRect(x: 0, y: offSetY , width: view.frame.size.width, height: btnWidth*5)
        //Display영역 프레임
        let displayViewHeight:CGFloat = 150
        offSetY -= displayViewHeight
        displayView.frame = CGRect(x: 0, y: offSetY, width: view.frame.size.width, height: displayViewHeight)
        //=======================================
        //<keyPad안 영역>
        
        //etcView영역 프레임
        etcView.frame = CGRect(x: 0, y: 0, width: btnWidth*3, height: btnWidth)// 3개 들어갈꺼니까..
        arrange(viewList: etcBtnList, collumCount: 3, width: btnWidth)
        //연산자영역 프레임
        operView.frame = CGRect(x: btnWidth * 3, y: 0, width: btnWidth, height: btnWidth * 5)
        arrange(viewList: operBtnList, collumCount: 1, width: btnWidth)
        
        //숫자영역 프레임
        numberPadView.frame = CGRect(x: 0, y: btnWidth, width: btnWidth * 3, height: btnWidth * 4)
        arrange(viewList: numberBtnList, collumCount: 3, width: btnWidth)
        
    }
    
    func arrange(viewList:[UIView], collumCount:Int, width:CGFloat)
    {
        for index in 0 ..< viewList.count
        {
            let col:CGFloat = CGFloat(index % collumCount)// 열은 지정된 갯수이상 행에 포함 안되도록.
            let row:CGFloat = CGFloat(index / collumCount)// 행 넘기도록
            
            viewList[index].frame = CGRect(x:col*width, y: row*width, width: width, height: width)
        }
    }
</pre>

- 인스턴스 생성 하는 것과 프레임 결정하는것, 배치하는 것들을 하나의 메소드를 만들어 관리.
- 중복되는 내용이 많은 것들은 반복문을 통해 간결하게...






