# Property ,
# Property Observer
---
---

## Property

- Property : Class, Struct, enum 등 전체적으로 사용하는 내부 속성의 개념들을 프로퍼티 라고 함.
- 개념상으로 변수 < 프로퍼티, 의미상으로 변수를 포함하는 개념임.

### 종류
- **저장** : 가장 일반적인 프로퍼티, 값을 저장하는 용도.
	- Class, Struct에서만 인스턴스에 연관된 값을 저장.
	- 초기값을 설정 할 수 있다. ( 연산, 타입 프로퍼티의 경우 초기값이 없다? 타입은 모르겠네..)
-  **지연 저장 프로퍼티**
	- 키워드 : lazy
	- 원래는 init 할때 초기화하면서 생성되는게 맞는데 메모리 부하를 줄이기 위해 사용되기 직전에 초기화 되어 생성되도록 함.
	 
 ```swift
class ViewController: UIViewController{
lazy var cal:Calculator = Calculator()
override func viewDidLoad() {
	super.viewDidLoad()
}
	cal.average(student: Student())// 이시점에서 생성이 된다는 말씀.
}
 ```

- 연산 : 실제로 값을 저장하진 않아, 하지만 저장 프로퍼티에 접근해서 저장 프로퍼티에 값을 셋팅 하거나 읽어올때 사용.
	- 일종의 저장 프로퍼티와 외부를 이어주는 통로 개념. (ex: .get 이나 .set)
	- 사용안해도 상관은 없지만, 메소드중에 속성에 관련된 메소드를 연산 프로퍼티로 사용하도록 한다.
	- Class, Struct, enum의 내부에서 사용.
	- 키워드 : get{ return }, set(newValue){ newValue }
		- set의 입력값 newValue는 생략 가능하고 내부에서 newValue라고 명시만 해줘도 상관이 없다.
		- 굳이 newValue라고 명시해주지 않아도 되고 따른 키워드를 파라미터와, 내부와 통일 시켜 사용해줘도 상관없다.


<pre>
struct Point {
     var x = 0.0, y = 0.0
}
struct Size {
     var width = 0.0, height = 0.0
}
struct Rect {
var origin = Point() 
var size = Size() 
var center: Point {
         get {
             let centerX = origin.x + (size.width / 2)
             let centerY = origin.y + (size.height / 2)
             return Point(x: centerX, y: centerY)
          }
         set(newCenter) {
             origin.x = newCenter.x - (size.width / 2)
             origin.y = newCenter.y - (size.height / 2)
         }
}

}
</pre>

- 연산 특징
	1. 초기화를 하지 않는다.
	2. get 부분과 set 부분으로 이루어 지며, 때에 따라서는 get 부분만 사용 할 수 있다.
	3. get 부분은 return이 있어야 함.( **리턴 자료형은 연산 프로퍼티의 자료형이 된다**)
	4. set 부분은 저장 프로퍼티에 직접적으로 접근하여 값을 변경하는 역활.
	5. set 은 입력값을 생략하고 구현 부분에서 newValue라는 키워드를 사용하여 대신 할 수 있다.

<pre>
class ComputingProperty{

    var computingTest: String = ""// 저장 프로퍼티
    private var setterTest: String = "ㅇㅇㅇ"
    
    init(computingTest: String){
        self.computingTest = computingTest
    }

    var getterSetterTest: String{
        get{
            let c = setterTest
            return c//get 부분은 return이 있어야 함.
        }
//        set(newTest){
//            setterTest += newTest
//        }
        set{
            setterTest += newValue
        }
    }

}

//getterSetterTest
var compuProperTest: ComputingProperty = ComputingProperty(computingTest: "컴퓨팅테스트초기화")

compuProperTest.getterSetterTest = String("세터 테스트")// = String(newTest)
//set 하는 부분
// set 하게되면 연산 프로퍼티의 set 부분을 수행.
// 외부에서 연산 프로퍼티를 초기화 하면 이를 setter
// 외부에서 연산 프로퍼티에 값을 넣어주면 setter

print(compuProperTest.getterSetterTest)// 마치 연산 프로퍼티를 직접적으로 접근하는 것 처럼 보임
</pre>


<pre>
class PropertyTest{
    private var storedProperty: Int = 0
    private var storedList: [Int] = []
    
    var computingProperty: [Int]{
        get{
            let c = storedList
            return c
        }
        set{
            for n in newValue{
             storedList.append(n)
            }
        }
    }
    
}

var compu: PropertyTest = PropertyTest()

compu.computingProperty = [3]

print(compu.computingProperty)
// 배열을 연산프로퍼티의 set으로 사용하고자 할때, 위와 같이 해줘야한다.
// set의 입력값을 Int로 하는 방법은 없고 하나의 [Int]로 생각하여 사용해야함.
</pre>

<pre>
struct Rect {
        //var origin = Point()
        var size = Size()
        var center: Point {
			get {
				let centerX = center.x + (size.width / 2) let centerY = center.y + (size.height / 2) return Point(x: centerX, y: centerY)
            }
            set(newCenter) {
                center = newCenter// setter가 자신에게 setter를 넣으려고 할경우 에러.
			} 
		}
}
</pre>




### note
<pre>
'?' 사용
getter 사용시 값이 없을 경우가 존재함. 따라서 연산 프로퍼티 선언할때 자료형? 으로 표현 후 구현.

값을 저장할때 걸러서 저장해야 될경우.. 메소드를 만들지 말고~쓰야만 할때에~

setter를 왜 쓰나?
compuProperTest.setterTest // 'setterTest' is inaccessible due to 'private' protection level

-> private 접근 제한자로 선언된 저장 프로퍼티를 외부에서 직접 접근할 경우 컴파일 에러 발생

getter를 왜쓰나?
-> private 접근 제한자로 선언된 저장 프로퍼티를 외부에서 사용하고자 할때 간접적으로 사용하게 해줌.

결론 
- 전역 변수를 그대로 노출하기 힘든 상황에서 메소드처럼 행동하는 접근 변수인 연산 프로퍼티만을 노출하기 위할때.
- private를 사용해야 되는데 외부에서 값을 설정 받아야 될떄.
- objC에서는 @property NSString *name? 으로 생성이 되면 자동으로 set, get이 만들어 진다고...
	- objC는 프로퍼티와 변수의 개념이 다르다.

</pre>


- **타입프로퍼티** : 타 언어의 전역변수 선언의 개념.
- 저장 프로퍼티는 인스턴스 프로퍼티 라고 불리기도 함.
- 타입 프로퍼티는 클래스 상태에서 값을 주어질 수 있도록 할때 타입 프로퍼티를 사용.( 정적 변수)
- 논리적 메모리 영역에서 Data 영역에 들어간다. 
	- 키워드 : class, static ( 변수앞에 사용)
		- static : 타입 프로퍼티 설정. ( 저장 프로퍼티 로써의..)
		- class : 연산 프로퍼티의 오버라이드를 해야 될때 쓴다..(사실상 쓸일 있나 싶긴...)
- Int의 최대 표현 가능 값을 표현 하는 프로퍼티와 같이 인스턴스 생성 후에도 바뀌지 않을 값들을 지정한다.

### 예시.

<pre>
struct AudioChannel {
static let level = 10
static var maxLevel = 0
var currentLevel: Int = 0 {
	didSet {
			if currentLevel > AudioChannel.level
			{
				currentLevel = AudioChannel.level
			}
			if currentLevel > AudioChannel.maxLevel
			{
				AudioChannel.maxLevel = currentLevel
			}
	}
}
</pre>

- **타입 메서드**
	- 키워드 : static, class
	- 해당 타입의 instance 에서 호출하는게 아니라, class(type) 에서 호출 하는것이 가능.
	- 앵간치 하면 class의 메서드를 전역으로 사용하고 싶을때, static을 붙여 사용.
	- 타입 메서드에서의 self는 인스턴스가 아닌 타입 자체를 지칭.

```swift 
class test {
 static var version: String = "1.2.3."
}
print(test.veresion) -> class 이름으로, property 를 불러올수 있습니다..

```



# Property Observer

- 어떠한 이벤트가 발생 했을 경우, 저장 프로퍼티의 값을 변경하고자 할때 사용.( Stored Property에 추가적으로 구현하여 설정)
- 저장 프로퍼티에 추가적인 구현 패턴이라고 이해 할것.
- Swift에 있는 디자인 패턴중 하나.(objc의 KVO, key value observer라는 방식에서는 많이 사용)
- 추가적으로 공부를 하기위해서는 observer 패턴을 공부해야함...
	- 키워드 : willset, didset
		- 현재 관측하고 있는 값에 대해서 변경된 값이 있을때 사용.
		- 그 값과 연관된 값들을 변경하고자 할때, 혹은 변경 전의 값을 써야 할때나 변경 후의 값을 써야 할때

- 예제
	- 계산기에서 사용자 입력이 들어왔을때 UI를 업데이트 하도록 할 경우.
	- TableView에 Data를 추가하고자 할 때, 입력 배열 -> TableView로 데이터가 이동하게 한다면 입력 배열에 값이 들어갈때 TableView 업데이트가 자동으로 되도록 구현 가능.
	
	
<pre>

// 프로퍼티 감시자 Property Observer
class ProperObserv{
    var listPrevOb: [String] = []// 이전값이 들어갈 배열
    var listAfterOb: [String] = []//이후값이 들어갈 배열 ( 앞으로 바뀔 값에 대한.. 선처리 개념)
    var obserVal: String = "일"{// init에서 초기화를 해준다면 딱히 해줄 필요 없음.
        willSet(newRate){// 값을 따로 지정하지 않았을때는 newValue, oldValue로 명시해주면됨.
            listAfterOb.append(newRate)// 바뀌기 전 이전 저장 프로퍼티가 newValue
        }
        didSet(oldRate){
            listPrevOb.append(oldRate)// 바낀 이후에 저장 프로퍼티가 oldValue
        }
        
        
    }
    
}

var a:ProperObserv = ProperObserv()

print("현재 관측 변수가 갖고 있는 값은 : \(a.obserVal)")// 일 출력
a.obserVal = "이"
print("이전에 들어있던 값은 : \(a.listPrevOb)로 관측 중인 변수에 값이 바뀐 이후에 해당 값으로 뭔가 해야할때")
print("이후에 들어갈 값은 : \(a.listAfterOb)로 관측 중인 변수에 값이 바뀌기전에 뭔가 해야하는 시점.")
print(a.obserVal)
</pre>

### 결과
<pre>
현재 관측 변수가 갖고 있는 값은 : 일
이전에 들어있던 값은 : ["일"]로 관측 중인 변수에 값이 바뀐 이후에 해당 값으로 뭔가 해야할때
이후에 들어갈 값은 : ["이"]로 관측 중인 변수에 값이 바뀌기전에 뭔가 해야하는 시점.
이
</pre>


- willset과 didset의 차이는 값이 바뀌기 전 액션을 할것이냐, 바뀐 이후 액션을 할 것이냐 의 차이.
- RxSwift에서는 observer + closure가 주로 사용됨.



