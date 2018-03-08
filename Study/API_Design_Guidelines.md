# API Design Guidelines

## 기본 개념

- 사용 시점에서의 명료성
	- 메소드, 프로퍼티와 같은 Entities는 한번만 선언되고, 반복 사용된다. 이걸 항상 생각하고 명명해야한다,(사용 될때에 문맥상 명확하게 이해되는지를 기준으로 정할것,)

- 명료성 > 간결성
	- 코드가 간결하면 좋겠지만, 그렇다고 못알아볼정도로 하면 안되여..
	- Swift가 간결하다고 평가 받는 이유 -> 강력한 type 시스템, boillerPlate(상용구)코드를 줄여주는 기능들이 강력하다.

<pre>
BoillerPlate : 타 언어의 get, set 등의 함수나  ifdef, define 등의... 실제 메소드나 프로퍼티 들을 제외한 그렇것들...
</pre>

- 모든 선언문에 주석을 작성할것!
	- 주석을 달고 시작한다면 API를 설계함에 있어 영향을 줄만큼 매우 바람직하다.

### 주석 작성 tip

- 요약할것 : 주석에 주절주절.. 그런것은 학습할때나 하자
- 하나의 문장, 불완전한 마무리 : 가능하면 하나의 문장을 통해 작성, 완전한 문장은 사용할 필요 없어.. 그냥 마침표만 찍어줘
- 함수, 메소드가 어떤일을 하는지, 어떤것을 반환하는지 설명하라.(nil, 즉 Viod는 빼도 된당. 하지만 optional은 명시해줘)

```swift
/// `self` 시작부분에 `newHead`를 삽입.
mutating func prepend(newHead: Int)

/// `self`의 요소를 동반하는 `head` 가 포함된 `List` 를 반환.
func prepending(head: Element) -> List

/// 비어있지 않다면 `self`의 첫 번째 요소를 제거 및 반환하고; 비어있다면 `nil`을 반환.
mutating func popFirst() -> Element?
```

- subscript의 경우 뭐에대해 접근하는지 설명해

```swift
/// `index` 번째 요소에 접근.
subscript(index: Int) -> Element { get set }
```

- 이니셜 라이져가 `뭘` 생성하는지 설명할것.

```swift
/// `x`를 `n`번 반복하는 인스턴스를 생성.
init(count n: Int, repeatedElement x: Element)
```

- 선언된 개체가 무엇인지 설명해줘

```swift
/// 어떤 위치에서든 똑같이 효율적으로 삽입/제거할 수 있는 컬렉션.
struct List {

  /// `self`의 첫 번째 요소, 또는 self가 비어있다면 `nil`
  var first: Element?
  ...
```

## 이름 지정

- 명확한 사용 활성화
	- 모호성을 줄거같은 단어는 피해 사용.

```swift
// 컬렉션 타입의 입력값에 대해 제거하려는 요소를 제거하는 메서드

extension List{
	public mutating func remove(at position: Index) -> Element
}

let employees: List = List()
employees.remove(at: x)
//remove의 argument가 _ 라면 사용자들은 아마 x를 없애라 라고 이해할 수 도있다..!!
```

- 불필요 단어 생략
	- 이미 사용자가 알것 같은 정보는 굳이 안줘도..

```swift
public mutating func removeElement(member: Element) -> Element?

someStruc.removeElement(member: ~~)//< 이렇게 다 작성하면 이미 독자는 removeElement와 parameter 작성, 두군데에서 얘는 엘리먼트를 지우는건가 보다 라는걸 알것 이란거지.

// 좋은 표현

public mutating func remove(member: Elemnet) -> Element?
```
- 역활에 따라 이름을 정해야 한다. (이름 변수, 매개 변수, 연관 타입은 굳이 알려줄 필요까진 없어)

```swift
let string = "dd" // -> let some = "dd"

class ProductionLine {
  func restock(from widgetFactory: WidgetFactory)// -> func restock(from supplier: WidgetFactory)
}

// NSObject, Any, AnyObject나 Int, String 과 같이 뭔가 기본형인 타입은 매개 변수로 사용할때 선언시에는 상관이 없지만 사용시에 약간 내가 이걸 왜 넣지 라는 생각을 할 수 도 있음.


func add(observer: NSObject, for keyPath: String)

func addObserver(_ observer: NSObject, forKeyPath path: String)// clear

grid.add(self, for: graphics) 
grid.addObserver(self, forKeyPath: graphics) // clear

``` 	
## 메소드, 함수명을 영어 문구형태로

```swift
x.insert(y, at: z) // x에서 z인덱스에 y를 넣는다
x.subViews(havingColor: y)// x는 y라는 색을 갖는 뷰를 갖는다
```

## 사이드 이펙트가 있다면 그에 따라 함수와 메소드 이름을 지정한다.

- Mutating / nonmutating 메소드 쌍의 경우 일관되게 이름을 지정한다. 
 

```swift
//Mutating
x.sort()// self가 배열된다
x.append()// self에 추가된다.

//Nonmutating
z = x.sorted()// 정렬된! x를 z에 ..
z = x.appending(y)//y가 추가된 x를 z에..
```
- Boolean 메소드와 속성 사용은 nonmutating 일때 수신자에 관한 주장으로 해석.

```swift
x.isEmpty // x가 비었어?
line1.intersects(line2)// 1번선과 2번선이 교차되?
```
- 능력을 설명하는 프로토콜은 able, ible, ing를 통해 유추 가능하도록..

```swift
Equatable
ProgressReporting
```
## 전문 용어는 조심히 사용

- 일반적인 단어가 의미를 좀더 잘 전달할거 같다면 애매한 용어는 피한다.("skin" > "epidermis")
	- 좀더 처음 접하는 사람들도 이해하기 쉽도록..
	- 약어를 피해야해..

# 규칙

- 일반적인 규칙
	- 복잡도 O(1)이 아닌 연산 프로퍼티의 복잡도는 문서로 만든다
		- 연산 프로퍼티의 계산 복잡도를 무시하지 말것?
	- free functions은 특별한 경우에만..사용
		- 구현했는데 뭔가 명백한 self가 없을때
		- 함수가 제너릭일때
		- 기존 도메인 표기의 일부일떄(??)
	- CamelCase를 잘따를것.
	- 메소드는 기본의미를 공유할때. 구분된 도메인에서 수행될때 이름을 공유해도 됨.

```swift
extension Shape {
  /// `other`가 `self` 지역 내에 있는 경우 `true`를 반환.
  func contains(other: Point) -> Bool { ... }

  /// `other`가 `self` 지역 내에 완전히 있는 경우 `true`를 반환.
  func contains(other: Shape) -> Bool { ... }

  /// `other`가 `self` 지역 내에 있는 경우 `true`를 반환.
  func contains(other: LineSegment) -> Bool { ... }
}

//위와 같이 사용할때 반환 타입에 대해서는 오버로딩 하지 말것. (타입 추론의 모호성이 발생)
```
## 매개 변수

- 매개변수 자체로 코드 가독성에 도움을 주는 이름을 선택하자.

```swift
func move(from start: Point, to end: Point)


/// `predicate`를 만족하는 `self`의 요소를 포함하는 `Array`를 반환.
func filter(_ predicate: (Element) -> Bool) -> [Generator.Element]

/// 주어진 요소의 `subRange`를 `newElements`로 치환.
mutating func replaceRange(_ subRange: Range, with newElements: [E])

/// 좋은 매개변수는 자연스럽게 읽힐수 있도록 도와준다.
```
## 인자 레이블

- 인자가 유용하지 않을거 같으면 걍 와일드 카드를 통해 생략
- 인자는 보통 전치사로 시작



### - Reference
- [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
