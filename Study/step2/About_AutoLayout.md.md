# About AutoLayout(Using StroyBoard)
---
---

>Frame계와 다르게 제약 조건(Constraints)을 주어 표현하는 Layout 표현 방식

---

## Autolayout OverView
Auto Layout dynamically calculates the size and position of all the views in your view hierarchy, based on constraints placed on those views

> Autolayout은 View들에 위치 한 제약 조건을 기반으로 View 계층 구조안의 모든 뷰의 크기와 위치를 동적으로 계산해주는 말로는 짱짱인....


## Autolayout Using StroyBoard
- Variable Attribute
	- IBOutlet : UI Outlet 연결
- Function Attrubute
	- IBAction : 버튼등의 액션을 연결


---
##- Auto Layout VS Frame-Based Layout

### framebase
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/Frame.jpg)<br>

> 좌표계는 origin, width, heghit를 기준으로 도형을 그려나간다.

### autolayout
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/Autolayout.jpg)<br>

> autolayout은 RootView를 기준으로 하위 view들이 Autolayout Attribute를 설정하여 dynamic한 View 정렬..!!
> 한 UI라도 al을 적용하면 모든 UI에 적용해야 한다,....는거...
> 

---
## - Constraint

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/constraints.jpg)<br>

- Multiplier : 비율을 통한 레이아웃 설정을 위한 속성
- Constants : 일정한 간격을 유지하기 위한 속성
- 

## Attribute

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/autolayoutAttribute.jpg)<br>

- Size attributes
	- width, height

- Location attributes
	- Leading
	- Trailing
	- Top
	- Bottom
	- Vertical
	- Horizontal

- 스토리보드에서 오토레이아웃
	- Safe Area == view.bounds

## Layout margin- 간혹 디자이너들이 마진을 통해 UI 배치를 깔끔하게 하길 원한다고 함.
- 아직 필요하진 않을것 같다. 있다는것만 알아두고, 어떻게 제외할 수 있는지 알아두는것이 중요(자동으로 스토리보드에서 정하는경우가 있다고함.)### Constraint 설정( 스토리보드)

- control + drag....
	
> AutoLayout 적용 Tip!(뇌피셜..)

<pre>
1. Safe Area, SuperView, UIView들에 대하여 배치 진행
( 어느정도 AL을 고려해서...)
2. **기준이될 View를 정한후 배치**..<-- 이게 제일 0순위로 해야함..
2.1. 기준이 될 View를 정하는 방법
2.1.1. Fix될 UI를 먼저 정한다(such as.. Button, Label, ImageView..)
2.1.2. Flexiable한 UI를 정한다. 화면이 늘어남에 따라 늘어날 것들..(such as TextField, TextView...)
2.1.3. Fix할 UI들의 사이즈를 먼저 FrameBase로 결정.(이 친구들이 이제 기준..)
2.1.4. Fix UI 친구들부터 AutoLayout을 진행한다. 
3. 뷰 컨트롤러 위에 올라간 모든애들에 대해서 가로설정을 진행 
3.1. 각각의 가로 공백(호라이즌 스페이스)설정(View간 공백 포함)
3.2. 기준 View와 width를 기준으로 각 View들의 가로 설정을 끝냄.
4. 모든 애들에 대해 세로 설정을 진행

3~4 번은 때에 따라 다르다.
먼저 기준점 UI를 정한 상태라면 그친구를 기준으로 Top, Bottom을 같게 해준다던지 해서 하나 하나씩 맞춰 나가도 상관은 크게 없다.

핵꿀팁
- 각 뷰에 대한 이름을 정해서 뷰 컨트롤러 씬에서 제약조건을 
  한눈에 알아 볼수 있도록 한다음 시작한다.
- 세부설정에서 =, >=, <= 에 대해서 생각할것.

필수..
- IPhone UIScreen에 대한 숙지가 필요.

- 캔버스(RootView)와 UI간의 간격을 제약하여 UI Layout을 자동으로 변경.
- 제약이 모자르거나 과할경우 IB에러와 함께 autolayout이 구현되지 않는다.
	- 과하다는것은 가변할수 있는 값은 가변되는 값으로 설정해야된다라는 뜻임.
- 뷰가 많아지면 많이 질수록 제약 조건(constraint)가 많아진다.
- 캔버스간와 UI 간격, UI간 간격, UI의 width, heignt등을 설정해야될듯..
</pre>

## StackView

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/stackView.jpg)<br>

- Autolayout을 Automatic하게 정렬...?!?
- IOS 9 이후부터 지원...따라서 없이 하는 방법또한 숙지...

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/stackViewAttribute.jpg)<br>

- Axis : Vertical, Horizental StackView인지 결정
- Alignment: Fill, Leading, Center, Trailing

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/Fill.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/Leading.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/Center.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/Trailing.jpg)<br>

- distribution : Fill, Fill Equally, Fill Proportionally, Equal spacing, Equal Centering

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/distributionFill.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/distributionFillequally.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/distributionFillProportion.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/distributionEqualSpacing.jpg)<br>
![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/distributionEqualCenter.jpg)<br>



## Autolayout exception..ScrollView

>- storyBoard에서 ScrollView를 생성하면 Contents View를 고려 해야한다.
>- ContentsView는 UIView를 ScrollView안에 넣어주면 된다.
>- 하지만.. ContentsView의 사이즈는 화면을 벗어난 크기가 될수 있기때문에 AutoLayout을 하는 방법이 다르다.

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/scrollViewContentsView.jpg)<br>

> 위의 그림처럼 ContentsView의 inSet을 0,0,0,0을 주면 에러가 난다.
> 
> 이유는 ScrollView는 움직이는 놈이기 때문인듯하다..
> 

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/scrollViewContentsView1.jpg)<br>

> 해결책은 contentsView의 inset 설정 후, contentsView Width를 컨버스와 동일하게 맞추고(Vertical ScrollView 기준), ContentsView의 Height는 고정 비율(내부 UI에 맞게 늘어나니까~) 하면된다,...

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/scrollViewContentsView2.jpg)<br>

> 그런데 이렇게 하게 되면 StoryBoard에서 편집이 힘들다..
> 화면이 넘어간 뷰는 보이지 않기때문임.
> 이럴때는 뷰컨트롤 씬에서 뷰컨트롤러 사이즈를 프리덤하게 해서 보도록 한다,.


![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/scrollViewContentsView3.jpg)<br>

- 다시한번 스텝 바 스텝~

	1. 뷰컨 생성
	2. 스크롤뷰 생성
	3. 스크롤뷰 제약 결정 ( 루트랑 같게)
	4. 컨텐츠 뷰를 생성( UIView)
	5. 컨뷰 제약 은 스뷰 안의 여백
	6. 컨뷰의 사이즈를 결정 픽스는 루트뷰의 가로 세로를 이용한다.
	7. 컨뷰 위에 UI들을 바둑판 배열 시작









