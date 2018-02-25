# NotificaionCenter, 
# AutoLayout(Using StoryBoard)
--

##18.02.24
--

- [Code 보기](https://github.com/joohopark/jhbob/tree/master/Project/smallProject)

---


![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/noti_practioce.jpg)

- **화면 구성**
	- Main Navigation Controller
		- Total Member View
			- TableView를 통해 추가되는 Memeber를 표시
		- Signing View
			- Signing 하는 Member들의 정보를 모두 입력하고, Join을 누르면 TotalMemberView의 Table에 Cell이 추가!
		- Detail Infomation View
			- Total Member View의 Member를 누르면 해당 Member의 상세 정보를 출력.

--
### 요구사항

- UI 배치는 Autolayout을 StoryBoard를 통해 진행(without StackView)
- 각 View간의 정보 전달 및 이벤트 처리는 Notification Center를 이용한다.
- scrollview를 통해 키보드가 선택되면 자동으로 컨텐츠뷰의 원점을 변경하여 키보드크기만큼 스크롤뷰를 내려서 사용자가 치기 편하게?! 한다. 

### 수정 사항.

- 테이블 뷰에 뿌려지는 userdefault의 값이 중복되서 나오는 문제..  좀만 더 보면 해결 될듯...

