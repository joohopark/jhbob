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

### note
<pre>
public init(frame: CGRect)// 좌표계 초기화
open var tag: Int// Int자료형 UIView 인스턴스의 식별 프로퍼티
open var layer: CALayer { get }// UI를 원으로 만들고자 할때
open var frame: CGRect// 슈퍼 뷰
open var bounds: CGRect// 주변 값
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

