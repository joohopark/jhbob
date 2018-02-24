# NotificaionCenter, 
# AutoLayout(Using StoryBoard)
--

##18.02.24
--

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
- Join Button 에서는 적절 조건을 예외처리한다.
	- 비밀번호 규칙 만족? -> ok
		- 특수문자, 대/소문자 포함하는 8글자 이상의 비밀번호야?
	- 이름에 특수문자 들어가..? ->
