# UITabbarController ,
# UICollectionView ,
# UIGestureRecognizer ,
# pickerView

---
--

## TabbarController: UIViewController

- customize가 되지 않아요..
- ViewController에서 가장 하단에만 위치 할 수 있음.
- 기본적으로 하나 이상의 ViewController를 Contain 할 수 있다.

- 서로 상관 관계가 없는 별개의 ViewController가 모여 만들어 진다. 
	- depth로 이어지지 않는다.
	- depth로 이어진다면, UX적으로 바람직 하지 않다.

### Tabbar의 구조

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/TabbarStruct.jpg)

- Viewcontroller의 배열, 하나의 Tap이 동일한 중요도를 가진 ViewController들의 모임.
- 1 ViewController 는 1 Tabbar Item을 갖는다.
- 다섯개가 넘어가는 ViewController의 경우 more 아이콘 `...` 을 통해 자동으로 뒤에것들을 모아준다.

- Tabbar Item : default.. text+Image 로 이루어 진다.
- 내부 Inset을 변경하여 구역을 변경 할 수 있지만...... 균일한 등분을 갖을 수 밖에 없으며, 그밖의 것들은 그냥 커스텀 하게 만들어진 Tabbar다..
	- Code로 할 수 밖에 없음.

## Story Board vs Code


- ViewController OR NavigationController 선택 
- Editor -> Embad in -> TabBarController 
- TabBarController inital 지정

- Code 
	- NavigationController 처럼 AppDelegate에서 생성
		- ViewController 배열을 선언 해서 Tabbar 인스턴스 만들고, NavigationController와 동일하게 만듬.



## Tabbar

![screen](TabbarItem.jpg)

- tint Color 가 기존 색들에 영향을 많이 줌.
	- UIColor보다 상위 개념. 테마 색이라고 생각.
- 각각의 ViewController를 각 TabBar Item에 매칭 되어 있다.
- TabBarItem은 이미지와 텍스트를 넣을수 있다.
- 각 TabBar Item은 해당 ViewController의 tabBarItem 프로퍼티로 접근 가능하다.
- Tabbar의 위치 == ViewController 배열의 인덱스
- UITabbarControllerDelegate 를 사용해서 현재 Tab된 View들에 접근 할 수 있다.
	- (:didSelect Item:): 선택된 뷰에 접근
	- (:shouldSelect:) : 넘어가? 말아? 할때
- Tabbar의 시작을 정하고 싶다?
	- self.selectedIndex = ViewController의 배열 Index

--

## UICollectionView

- UITable View의 상위 호환정도일까~
	- TableView : 하나의 Cell로 Row만큼 표시됨.. 가로로..
- CollectionView : TableView의 Row에 Cell이 여러개야~
	- Row의 Layout을 통해 결정.(TableView는 그냥 고정인데 얘는 아니야라고 생각하자)
	- Scroll 방향도 세로 가로~
- 재사용 Cell의 특징을 갖는다.
- AutoLayout 생각 할 필요 없어요. Layout은 자동이야 뭐에 대해? Cell 크기, Cell 간 간격..그래서 Flow Layout이라고 부른다.
	- View의 Width가 넘어가면 그냥 아래에 또 그려 이런식으로..
	- Flow Layout

## UICollectionView 구성

- Cell : width 수정, 간격 수정 가능한거 빼곤 Table View
- Decoration view : ibooks의 책장처럼 간격에 Background 같은 img들...
- Supplementary view : header, footer 

## required protocol

- Manager
	- UICollectionView
	- UICollectionViewController 

- protocol
	- UICollectionViewDataSource 
	- UICollectionViewDelegate 

- presentation
	- UICollectionReusableView
	- UICollectionViewCell

- Layout (custom 하게 구성 하고 싶을 떄)
	- UICollectionViewLayout
	- UICollectionViewLayoutAttributes 
	- UICollectionViewUpdateItem 

- FlowLayout
	- UICollectionViewFlowLayout
	- UICollectionViewDelegateFlowLayout(: UICollectionViewDelegate)

## 구성도

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/AboutCollectionView.jpg)

- DataSource를 통해 Cell의 갯수들을 결정, Layout Attribute를 통해 CollectionViewLayout을 결정해서 CollectionView를 구성한다.
	- 커스텀 하게 구성하고자 한다. 
	- 결국 Layout을 만져야 한다..
	- Layout을 구성하지 않으면(Code로 작성시) 충돌..App 구동 X

## Flow Layout

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/FlowLayOut.jpg)

- Flow Layout(UICollectionViewDelegateFlowLayout)
	- Section이 나눠지고 Header, Footer(Supplementary view)를 통해 구분하고, Cell이 그안에 된다. 


- UICollectionViewFlowLayout Class에 정의
- Scroll Direction
	1. Vertical
	2. Horizontal

## Flow Layout Attributes 정의

- UICollectionViewDelegateFlowLayout protocol 이용( 채택 하여 사용)
- UICollectionViewDelegate가 정의된 인스턴스에서 작성해야됨.

- 주요 메소드

```swift

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize

func collectionView(_ collectionView: UICollectionView, layout
collectionViewLayout: UICollectionViewLayout,
minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
// minimumInteritemSpacingForSectionAt : cell spacing 미니멈, 이게 애매해지면 걍 사이 간격을 왕창 띄우고 width 끝에 위치하게 한다. 최소가 고정이라는 이야기는 아니고 cell의 크기에 따른 간격을 이야기 한다.

func collectionView(_ collectionView: UICollectionView, layout
collectionViewLayout: UICollectionViewLayout,
minimumLineSpacingForSectionAt section: Int) -> CGFloat

func collectionView(_ collectionView: UICollectionView, layout
collectionViewLayout: UICollectionViewLayout, insetForSectionAt
section: Int) -> UIEdgeInsets
```

- collection View의 Cell은 기본형이 없기 떄문에 무조건 customCell을 만들어 넣어야 한다.

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/Exam_CellSpacing.jpg)

- 최소의 cell spacing은 Cell과 View.width간의 상관관계에서 남는 여백이 최소 이정도는 되야 된다~ 라는 의미이지 무조건적인 수치는 아님..

## Flow Layout Exam

```swift

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var mainCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = mainCollection.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.scrollDirection = .horizontal
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }// number of item
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.title.text = "\(indexPath.item)"
        cell.backgroundColor = .black
        return cell
    }// cell
    
    // cell의 크기를 ...
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }//line spacing
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 100
    }// cell spacing
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }// inset 
    
}
```

## Layout of Section 

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/SectionLayout.jpg)

- 헤더
- 푸터
- Cell(view.width - (Section Inset + cell spacing)을 한 구역에 들어갈 만큰 들어가고 다음 라인으로 넘어감)
- Cell Spacing
- Cell Line Spacing
- Section Inset

- 이걸 가로 스크롤로 된다면? 저 그림을 90도 회전시켜 생각해야된다.

- scrollView는 재사용을 하지 않아요..

--

## UIGestureRecognizer

- 사용자의 입력을 받기 위해 만들어진 타입
	- touch( in UIResponder, 사용자가 누른 위치의 좌표를 가져올수 있다.)
	- gesture를 통해 이벤트를 이미 만들어 놨어용..
	- tap, rotation, pinch등의 제스쳐를 사용자가 하였을때 해당되는 제스쳐와 메칭된 selector가 실행 되도록 만들어 놨음..( 이러한 제스처를 인지하는 subClass가 존재한다)

- View 위에 얹어(Add 의 느낌) Action을 Handlling 한다.( 여러개의 제스쳐가 존재 할 수 있다.)
	- tap을 통해 모든 View를 버튼 처럼 만들 수 있다.

## UIGestureRecognizer 종류

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/gesture.jpg)

- object Library
	- tap : touch
	- pinch: 두손가락으로 늘리기
	- rotation : 두손가락으로 돌릴떄 발생
	- swipe : 슥 넘기는거
	- pan : drag하듯이 움직일때
	- screen edge : 가장자리에 이벤트를 줄때
	- long press : 길게 touch

- delegate에 대한 처리도 가능.

## gesture exam

```swift
let tapGesture = UITapGestureRecognizer(target: self,
                             action: #selector(ViewController.tapAction(_:)))
self.view.addGestureRecognizer(tapGesture)// gesture add

//ViewController내 존재 하는 함수
@objc func tapAction(_ sender:UITapGestureRecognizer) {

}
```

## using Stroyboard

- gesture add

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/gestureUsingStroy.jpg)


## PickerView

- Delegate or Event 를 통해 사용자의 행동을 받아와

- Date Picker View
	- UIControl을 상속 받기 때문에 addTarget에 ValueChanged를 통해 값을 확인.
- UI Picker View
	- Delegate : Action
	- DataSource : Data 전달

- Component로 이루워짐.(Component == Section)

- textField를 눌렀을때 키보드 대신 inputView를 통해 PickerView를 넣어 그 자리에 PickerView가 오도록.
	- AccessoryView에 버튼을 올려 return 하도록 만드는게 보통임.

## PickerView Exam

![screen](https://github.com/joohopark/jhbob/tree/master/Study/image/pickerExam.jpg)


```swift
import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let list = ["남자", "여자", "??"]

    @IBOutlet var tf:UITextField!
    var picker:UIPickerView!
    var toolbar:UIToolbar!
    var doneBtn:UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //textField를 눌렀을때 키보드 위치에 picker가 들어가도록 하려면..
        // 1. UIPickerView 인스턴스를 만든다.
        // 2. UIPickerView에 대해 DataSource와 Delegate에 ViewController를 넣어준다.
        // 3. 텍스트 필드의 inputView 프로퍼티에 UIPickerView 인스턴스를 위치..
        // 4. UIBarButtonItem 인스턴스를 만든다.
        // 5. UIToolBar 인스턴스생성 후에 setItems 메소드를 통해 UIBarButtonItem를 넣는다.
        // 6. 텍스트 필드의 inputAccessoryView 프로퍼티에 ToolBar 인스턴스를 넣어준다.
        
        picker = UIPickerView()
        picker.delegate = self
        picker.delegate = self
        
        tf.inputView = picker
        doneBtn = UIBarButtonItem(title: "done", style: .done, target: self, action: #selector(didSelectedDoneBtn(_:)))
        toolbar = UIToolbar()
        toolbar.setItems([doneBtn], animated: true)
        tf.inputAccessoryView = toolbar
    }
    
    @objc func didSelectedDoneBtn(_ sender: UIBarButtonItem){
        tf.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }// delegate에 있는걸 구현할 경우에는 해당 picker에 component 안을 채우려 할때 ..
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedTitle = self.pickerView(pickerView, titleForRow: row, forComponent: component)// 이렇게하면 현재 선택되는 애들의 값을 가져올수 있다.. 
        print(selectedTitle)
        self.tf.text = selectedTitle
        
    }

}
```


### - tip

<pre>
- Color를 정할때는 한 View에 많아도 4개 이상 넘어 가지 않게 할것.
- Main Color를 하나 정하고 ....
</pre>


