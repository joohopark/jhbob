# how to use tableview in swift3.

- UITableView 정의 : 데이터를 row들로 정렬하여 단일 column으로 보여주는것.
	- SingleColumn == Cell
	- IndexPath == Section.Row

Swift3 문서
(https://developer.apple.com/documentation/uikit/uitableview)

A table view displays a list of items in a single column. 

- TableView는 단일 열에 항목들의 리스트를 표현한다.

UITableView is a subclass of UIScrollView, which allows users to scroll through the table, although UITableView allows vertical scrolling only. 

- UITableView는 UIScrollView의 자식클래스로 스크롤 기능은 오직 수직 스크롤만 가능하다.

The cells comprising the individual items of the table are UITableViewCell objects; 

- 테이블의 개별 항목들을 구성하는 Cell들은 UITableViewCell 객체임.

UITableView uses these objects to draw the visible rows of the table. 

- UITableView는 테이블의 row들을 가시화되도록 그리는데 UITableViewCell객체를 사용함.

Cells have content—titles and images—and can have, near the right edge, accessory views. 

- Cell은 제목, 이미지들을 갖을 수 있고 오른쪽 가장자리 근처에 엑세서리 뷰들이 있다.(?)

Standard accessory views are disclosure indicators or detail disclosure buttons; 

- 엑세서리 뷰들의 표준은 disclosure indicators 또는 상세보기 기능을 제공하는 버튼임.

the former leads to the next level in a data hierarchy and the latter leads to a detailed view of a selected item. 

- disclosure indicators는 data hirarchy에서 다음 단계로 넘어가는거고, 상세보기는 선택 항목에 대한 자세히 볼수 있는 view로 넘어간다.

Accessory views can also be framework controls, such as switches and sliders, or can be custom views. 

- 엑세서리 뷰가 여러 기능을 한다라는 의미 문장인듯..(스위치, 슬라이더 또는 사용자가 정의한 view같은 framework control이다)

Table views can enter an editing mode where users can insert, delete, and reorder rows of the table.

- TableView들은 사용자가 Table의 row(Cell을 의미하는듯.)를 삽입,삭제, 재정렬 할수 있도록 편집모드를 구현할수도 있다는 뜻인듯.

A table view is made up of zero or more sections, each with its own rows. 

- TableView는 0개 이상의 Section들로 구성되며 각각에는 자체적인 row들이 있다.

Sections are identified by their index number within the table view, and rows are identified by their index number within a section.

- section, row들은 index num으로 구별이 가능하다. (indexpath : section.row)

Any section can optionally be preceded by a section header, and optionally be followed by a section footer.

- section들은 section header와 footer를 갖을수 있음.


Table views can have one of two styles, plain and grouped. 
When you create a UITableView instance you must specify a table style, and this style cannot be changed. 
- TableView는 생성할때 plain, grouped 두가지 선택가능, 생성시만 선택가능하며 이후 변경 불가.

In the plain style, section headers and footers float above the content if the part of a complete section is visible.
- plain은 전체 section의 일부가 보일경우 header, footer가 내용위에 보이게 됨.

 A table view can have an index that appears as a bar on the right hand side of the table (for example, "A" through "Z"). You can touch a particular label to jump to the target section. 
- TableView는 (연락처의 A~Z)오른쪽 측면의 라벨을 통해 indexing이 가능 하다.

**The grouped style of table view provides a default background color and a default background view for all cells.**

- grouped 의 경우 셀의 기본배경색과 배경 view를 제공한다(?)

The background view provides a visual grouping for all cells in a particular section.
- 배경 view는 cell들의 특정 section에 대한 가시화된 그룹화를 제공.

 For example, one group could be a person's name and title, another group for phone numbers that the person uses, and another group for email accounts and so on. 
See the Settings application for examples of grouped tables. Table views in the grouped style cannot have an index.
- 예로 연락처를 드는듯. 연락처의 이름과 제목은 하나의 그룹, 연락처 그룹, 이메일 그룹등을 갖고있는데 이건 grouped tableview 임. 
tableview가 grouped면 index를 갖을수 없음.

Many methods of UITableView take NSIndexPath objects as parameters and return values.
- UITableView는 어지간하면 NSIndexPath 객체를 매개변수, 반환값으로 사용.

 UITableView declares a category on NSIndexPath that enables you to get the represented row index and section index , and to construct an index path from a given row index and section index. 
- UITableView는 너가 주어진 row, section으로(NSIndexPath 를 통해 알아낸) cell의 범주를 선택할수 있다는건가????  경로구성을 줄때는  (init(row:section:) method)사용한다.

(row property) 
(section property)
 (init(row:section:) method)


Especially in table views with multiple sections, you must evaluate the section index before identifying a row by its index number.
- row를 통해 cell을 식별하기 전에 행을 명시해줘야 한다는 뜻인듯. (tableview의 section이 여럿일때)

A UITableView object must have an object that acts as a data source and an object that acts as a delegate; 
- UITableView 개체는 데이터소스와 델리게이트 역활을 하는 개체가 있어야함.
( 역활을 하는 개체라고 표현을 한 이유는??)

typically these objects are either the application delegate or, more frequently, a custom UITableViewController object. 
The data source must adopt the UITableViewDataSource protocol and the delegate must adopt the UITableViewDelegate protocol.
- 일반적으로 UITableView객체는 응용 델리게이트나 혹은 커스텀 UITableViewController 객체임. 
- UITableViewDataSource, UITableViewDelegate 프로토콜을 채택하고 사용해라라는 뜻인듯.

 The data source provides information that UITableView needs to construct tables and manages the data model when rows of a table are inserted, deleted, or reordered. 
- 데이터 소스는 UITableView이 테이블을 구성하고 테이블의 rows(Cell)을 삽입,삭제,재정렬할때의 데이터 모델을 관리하는데 필요한 정보를 제공한다.

The delegate manages table row configuration and selection, row reordering, highlighting, accessory views, and editing operations.
- 델리게이트는 테이블 설정과 테이블 선택, row 재정렬, highlighting ,accessory view 그리고 편집 작업들을 관리한다.

When sent a setEditing message, the table view enters into editing mode where it shows the editing or reordering controls of each visible row, depending on the editingStyle of each associated UITableViewCell. 
(_:animated:) 
 (with a first parameter of true)
- setEditing 메시지가 보내질때 매개변수가 true면 TableView는 편집모드로 들어가게 되는데, 각각의 연관된 UITableViewCell의 편집 스타일에 의존하는 놈들을 편집 또는 재정렬 할수 있다.


Clicking on the insertion or deletion control causes the data source to receive a tableView(_:commit:forRowAt:) message. 
- 삽입 , 삭제 컨트롤 클릭시(편집모드서) 데이터소스는 tableView(_:commit:forRowAt:) 메시지를 받게 된다. ( 이 함수를 구현해서 삽입, 삭제 컨트롤을 진행 할 수 있도록 하는듯)

You commit a deletion or insertion by calling deleteRows(at:with:) or insertRows(at:with:), as appropriate. Also in editing mode, if a table-view cell has its showsReorderControl property set to true, the data source receives a tableView(_:moveRowAt:to:) message. 
- 앞선 메시지를 받게되면 deleteRows(at:with:), insertRows(at:with:)를 호출하여 적절히 tableview에 적용이 가능하다,  또한 편집 모드서, TableView 셀의 showsReorderControl 속성이 true면 데이터 소스는 tableView(_:moveRowAt:to:) 를 받게 됨.

The data source can selectively remove the reordering control for cells by implementing tableView(_:canMoveRowAt:).
- 데이터소스는 tableView(_:canMoveRowAt:) : 를 구현 함으로써 선택적으로 으로 Cell들에 대한 재정렬 제어를 제거 할수 있음 .

UITableView caches table-view cells for visible rows.
- UITableView는 가시화된 row들에 대해 tableview cell들을 캐쉬한다.

 You can create custom UITableViewCell objects with content or behavioral characteristics that are different than the default cells;
 A Closer Look at Table View Cells explains how.
- UITableViewCell을 커스텀해서 만들수 있는데, 기본 cell들과 다른 특성을 가진 내용 또는 동작 특성을 갖게 할수 있다. 
- Closer Look이 뭐지??? 이게 TableView Cell들을 어찌해야할지 설명함.

UITableView overrides the layoutSubviews() method of UIView so that it calls reloadData() only when you create a new instance of UITableView or when you assign a new data source. 
- UITableView 에서 새 데이터 소스를 할당하거나 UITableView의 새 인스턴스를 만들려고할때  UIView의 layoutSubviews() 재정의는 리로드 데이터()를 호출한다. 

Reloading the table view clears current state, including the current selection. 
- 리로드 데이터()를 호출하면 현 선택된 상태를 포함한 현상태는 초기화됨.

However, if you explicitly call reloadData(), it clears this state and any subsequent direct or indirect call to layoutSubviews() does not trigger a reload.
- 그러나 리로드 데이터()를 명시적으로 호출하면 후속적으로 직 간접적으로 호출된  layoutSubviews()는 두번 불리지 않는다.



State Preservation 상태 보존


If you assign a value to a table view’s restorationIdentifier property, it attempts to preserve the currently selected rows and the first visible row. 
- restorationIdentifier 속성에 값을 할당하면 상태를 보존하려고 함.
( 여기서의 상태는 현재 선택된 행과 보여지는 첫번째 행을 의미)

The table’s data source may adopt the UIDataSourceModelAssociation protocol, which provides a way to identify a row’s contents independent of that row’s position in the table.
- UIDataSourceModelAssociation 프로토콜은 테이블의 데이터 소스가 채택 할수 있는 놈이고, 임마가 테이블에서의 row 위치에 독립적으로 row의 내용을 식별 할수 있는 방법을 제공함.

 If the table’s data source adopts the UIDataSourceModelAssociation protocol, the data source will be consulted when saving state to convert the index paths for the top visible row and any selected cells to identifiers.
- 만약 위 프로토콜이 채택되면 상태를 데이터 소스를 참조하여 식별자로 변환함

 During restoration, the data source will be consulted to convert those identifiers back to index paths and reestablish the top visible row, and reselect the cells.
- 상태를 복구할때 이 식별자를 통해서 다시 원상태로 복꾸가 가능함.

 If the table’s data source does not implement the UIDataSourceModelAssociation protocol, the scroll position will be saved and restored directly, as will the index paths for selected cells.
- 만약 위 프로토콜을 구현하지 않은 테이블 데이터 소스의 경우에는 스크롤 위치를 직접 저장함(선택된 셀들에 대한 index path와 마찬가지인 뜻임)

