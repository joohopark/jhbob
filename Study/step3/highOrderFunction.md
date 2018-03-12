# FRPP(Functional Reactive Programming Paradigm) ,
# Closure ,
# 고차 함수 ,
# Map , 
# Filter ,
# Reduce

---

## Functional Reactive Programming Paradigm

>- Programming?
>
>Input 으로 Output을 만들어 내는것을 프로그램이라 하고, 이것을 만드는 것을 프로그래밍이라고 한다.

>- Paradigm?
>
>어떤 한 시대를 살아가는 사람들의 견해나 사고들을 근본적으로 규정하는 테두리로서의 인식체계, 사물에 대해 이론적인 틀이나 체계를 의미하는 개념.
>
>시대를 반영한다. 즉 시대가 바뀌면 페러다임도 바뀐다.
>
>Low Memory 일때의 페러다임 : 적은 메모리로 인해 최적화된 프로그래밍을 하는것에 우선적이었다.(단점: 데이터가 바뀌면 프로그램도 바뀌어야 했음)
>
>Mass Production일때의 패러다임 : 프로그래밍이 대량 생산 되던 시대로 데이터를 처리할때 좀더 재사용이 편하게끔 하고, 데이터를 Class화 하면서 데이터가 바뀌더라도 프로그램이 변경 되지 않도록 추상화 하도록 하는 패러다임으로 대표적으로 OOP 가 있다.
>
>Councurrency일때의 패러다임 : 동시에 여러가지의 프로그램이 돌아갈때 문제가 생기지 않도록 해야되는 문제점들이 생김. 데이터를 여러 프로그램이 공유하여 사용할때.

```swift

// 모듈 A 와 B의 공유 데이터
var data: Int = 0

// 모듈 A
func addAndGet(add: Int) -> Int{
	data += add
	return data
}

// 모듈 B
func addAndGet2(add: Int) -> Int{
	data += add
	return data
}

// 예전에는 세마포어나 동기화 기법등을 통하여 공유자원 관리를 했었음.

// 하지만 요즘에는 아싸리 data를 let으로 제공한다. 즉 공유하는 자원들이 문제라면? 공유하는 자원들을 읽기만 가능하도록 만든다.(Immutable)

let data: Int = 0

func addAndGet(add: Int) -> Int{
	return data + add
}

```

>- 같은 자원을 공유할 떄 생기는 문제 Side-Effect

```swift
var data: Int = 10

func addAndGet(add: Int) -> Int {
	return data + add
}

addAndGet(add: 1)// 11
data = 20
addAndGet(add: 1)// 21

// 혼자 돌떄는 상관이 없다.
// 하지만 두개의 모듈이 동시에 11이라는 값을 얻고자 저 함수를 호출 한다면?
// 그래서 아예 저런 문제점을 줄만한 것을 만들지 말자!

func addAndGet(base: Int, add: Int) -> Int{
	return base + add
}

addAndGet(base: 10, add: 1)//11
addAndGet(base: 20, add: 1)//21

// Race Condition을 피하고 싶어?
// 함수내에서 필요한 값들은 인자로 다 받아라
// 그리고 반환할때도 아예 걍 새로운 값을 만들어 리턴해라
// 새로운 값의 메모리가 커? 상관 ㄴㄴ 이미 high - 메모리시대임..
// 이런식의 함수 구현을 Pure Function이라고 하자.
```
- 함수의 종류( 하는 일에 따라 나뉘는 종류)
	- 인풋 없고 아웃풋만 있어 : Generator
	- 인풋 있고 아웃풋도 있어 : Function
	- 인풋 있고 아웃풋 없어 : Consumer

```swift
func getTen() -> Int{
	return 10
}

func addTwo(n1: Int, n2: Int) -> Int {
	return n1 + n2
}

func output(value: Int) {
	print("\(value)")
}

let adder = {(v1, v2) -> Int in v1 + v2}
let multi = {(v1, v2) -> Int in v1 * v2}

func calc(n1: Int, n2: Int, method (Int, Int) -> Int) -> Int{
	return method(n1, n2)
}// 이런식으로 인자로 함수를 받고 함수안에서 함수를 호출한다? 고차 함수가 된다~ high-Order function

//변수에 담거나, 리턴값으로 사용하거나, 컬렉션에 담을수 있다? 일급 객체다~ 스위프트는 함수가 그렇다~ 함수가 그렇게 사용되는 언어다? 함수형 언어다~
// 스위프트는 함수형 언어, 객체지향 언어(이유는 저 사용 용도에 인스턴스를 넣어도 말이된다.), 프로토콜도 그렇게 된다네? 그래서 멀티 페러다임 언어다..

output(value: addTwo(n1: getTen(), n2: getTen())
// 이런식으로 함수를 아예 합성해서 쓴다? function composition

output(value: clac(n1: getTen(), n2: getTen(), method: adder)
```

- 명령형 프로그래밍 : 데이터를 정의하고 그것의 변화과정을 프로그래밍 하는것
- 선언형 프로그래밍 : 행위를 정의하고 데이터를 집어 넣는 프로그래밍을 하는것 ( functional이 여기에 속한다)

- How to Functional Programming?
	- 데이터는 immutable 하게 취급하자
	- 데이터의 변경이 필요하다면 함수안에서 새로 만들어 반환하자
	- side- effect를 없애기 위해 pure function을 사용하자
	- function들의 composition, high-order function들로 프로그래밍을 만들자
	- data가 아니라 프로세스(행위)에 집중하여 프로그램을 만들자

```swift
//서버에서 일련의 문자열을 받아와야 해
func getText1(from url: URL) -> String{
	return try! String(contentOf: url)
}

func getText2(from url: URL) -> String{
	URLSession().dataTask(with: url) (date, response, error) in 
	let text = String(data: data!, encoding: .utf8)
	//return text???< 리턴 시점을 언제 정하지?
	}.resume()
	return ""//?? 리턴을 언제해??
}// 다중 프로그램이 돌아간다는 가정하에 이 문자열을 받아와 리턴하는 행위가 다른 프로그램을 인터럽트하는게 옳은것인가?

func getText3(from url: URL, result: @escaping (String) void){
	URLSession().dataTask(with: URL) (data, response, error) in 
	let text = String(data: data!, encoding: .urf8)
	result(text!)
	}.resume() 
}// call back

var delegate: {(String) -> void? = nil }

func getText4(from url: URL){
	URLSession().dataTask(with: URL) {(data, response, error) in
	let text = String(data: data!, encoding: .urf8)
	delegate!(text!)
	}.resume()
}//delegate
```

- 반응형 프로그래밍
	- 비동기적 상황에서 어떻게 비동기적으로 처리 할 것인가 
	- 기본 컨셉 : stream이라는것을 만들고 이를 통해 data를. 흘려보낸다.
	- RxSwift라는 라이브러리를 통해 Reactive 프로그래밍을 할 수 있다.

- 아이디어 : 데이터 생산하는 함수(generator, observable(Rx)) <-스트림, operator를 통해 데이터를 변경, 제조 가능(map, filter, reduce-> 데이터를 소모하는 함수(consumer, Subscriber(Rx))
	- 서버에 데이터 요청 -> 서버로부터 스트림을 받아 subscriber로 스트림을 리턴해준다. -> 데이터는 스트림을 통해 전달

- How to Rx programming?
	- 비동기 처리를 functional하게 처리하자
	- 리턴값은 스트림인 observable을 반환하자
	- 스트림에 흐르는 데이터/ 이벤트를 operator로 처리하자(스트림의 데이터 변형)
	- 스트립과 스트림을 연결하자
	- 데이타가 아닌 프로세스에 집중해서 프로그래밍 하자

- Rx와 functional
	- functional : side- effect가 없도록 하는 프로그래밍
	- reactive : 비동기 작업을 함수적으로 처리하는 아이디어

- high order function
	- 하나 이상의 함수를 인자로 취하는 함수
	- 함수를 결과로 반환하는 함수

>- High-order Function 이 되기 위해서는 함수가 First-class Citizen 이어야 한다.

## Closure

Closures are self-contained blocks of functionality that can be passed around and used in your code.

- 클로저 는 코드에서 전달되고 사용할 수있는 독립적 인 기능 블록입니다.Closures can capture and store references to any constants and variables from the context in which they are defined.
- 클로저는 정의 된 컨텍스트에서 모든 상수 및 변수에 대한 참조를 캡처하고 저장할 수 있습니다.Global and nested functions, as introduced in Functions , are actually special cases of closures. 
- 글로벌 및 중첩 함수는 함수라고 설명했었으나 , 실제로는 클로져의 특별한 종류이다.


### Closure의 종류, 유형?- Global function는 이름이 있고 값을 캡처하지 않는 클로저입니다.
	- free Function- nested function는 이름을 가진 클로저로 내부 함수에서 값을 캡처 할 수 있습니다.- Closure expressions은 주변 컨텍스트에서 값을 캡처 할 수있는 간단한 구문으로 작성된 이름없는 클로저입니다.

### Closure Expressions

```swift
{(인자) -> 반환값 in 	구현 구문 }
// 함수의 선언과 구현 부는 in을 통해 구분된다...!
```
### Inline Closure

```swift
override func viewDidLoad() {
 super.viewDidLoad()
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"] //아래 예제 backward(_:_:)는 이전 버전의 함수를 클로저식으로 나타낸 것입니다.
let sorted = names.sorted(by:
{( s1: String, s2: String) -> Bool in
       return s1 > s2
    }
)
 print(sorted) //[“Ewa”, "Daniella", "Chris", "Barry", "Alex"]
}
//* s1과 s2는 배열(names)에서 가져온 인자인기 때문에 타입을 유추할수 있다. 또 리턴 결과값으로 인해 
//리턴의 타입도 유추 가능하다. 즉 클로저를 함수 또는 메소드에 인라인 클로저 표현식으로 전달할 때 항상 
//매개 변수 유형 및 리턴 유형을 유추 할 수 있습니다.
```

### Clsure 간소화

```swift
func performClosure(param: (String) -> Int) {
    print(param("Swift"))
}
// 문자열을 받아 Int를 반환 하는 함수를 인자로 받아야됨.


performClosure { (str) -> Int in
    return str.count
}

performClosure { str in
    return str.count
}

performClosure { $0.count }

performClosure { (str: String) -> Int in
    return str.count
}// 파라미터 그대로 써줘, 반환형도 써줘, in으로 구분해줘, 리턴 해줘

performClosure { str -> Int in
    return str.count
}//파라미터 어차피 하나야, 반환형써주고 in으로 구분하고, 리턴해줘

performClosure(param: {
    return $0.count
})//어차피 입력 함수는 파라미터 하나만 받아 그럼 $0을 통해 표현 할수 있어. 그러니 구현부에 $0을 통해 값을 만들어 반환 해주면됨.

performClosure(param: ){ $0.count }//어차피 클로져 하나만 들어가 그러면 뒤에다 클로져 써줘도 되, 그리고 리턴만 할거면 한줄만 써줘도 되
performClosure(){ $0.count } // 어차피 입력값이 하나면 파라미터 명시 안하고 호출뒤에 바로 클로져 써줘도 되.
performClosure { $0.count }// 어차피 입력값이 하나면 굳이 입력값 받는다고 괄호 안만들어 줘도 됨.

func performTwoClosure(param:(String) -> Int ,param2:(String) -> Int){
    print("test")
}

performTwoClosure(param: { (str) -> Int in
    return str.count
}) { $0.count }//마지막에 인자로 오는 함수만 후행 클로져로 간추릴 수가 있어용~

// 축약하는 과정이 많지만 되도록이면 마지막과 첫번째 형태만 기억해서 씁시다.
// 익숙해지면 결국엔 마지막 축약을 사용하게 될거고
// 복잡한 타입을 인자로 받는 클로져의 경우에는 풀로 다 써줘야 컴파일러가 인식하는 경우가 있기 때문입니당.
```
- Shorthand Argument Names
	-  Swift는 인라인 클로저에 자동으로 Shorthand Argument Names을 제공하며, 클로저 인수의 값을 이름 $0, $1등으로 참조 할 수 있도록 도와준다.

```swift
override func viewDidLoad() {
 super.viewDidLoad()
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"] //아래 예제 backward(_:_:)는 이전 버전의 함수를 클로저식으로 나타낸 것입니다.
let sorted = names.sorted(by:{ $0 > $1 })
print(sorted) //[“Ewa”, "Daniella", "Chris", "Barry", "Alex"]
}
``` 

- Trailling Closure( 후행 클로져)
	- 함수에 클로저 표현식을 함수의 최종 인수로 전달해야하고 클로저 표현식이 길면 후행 클로저 로 작성하는 것이 유용 할 수 있다 . 
	- Trailing Closures을 사용하면 함수 호출의 일부로 클로저의 인수 레이블을 쓰지 않는다.
	- 클로저 표현식이 함수 또는 메소드의 유일한 인수로 제공되고 그 표현식을 후행 클로저로 제공하면 함수를 호출 할 때 함수 또는 메소드의 이름 뒤에 한 쌍의 괄호를 쓸 필요가 없다.

- Operator Methods

```swift
override func viewDidLoad() {
 super.viewDidLoad()
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"] //아래 예제 backward(_:_:)는 이전 버전의 함수를 클로저식으로 나타낸 것입니다.
let sorted = names.sorted(by:{ > })// sorted의 인수는 sorted(by: <#T##(Int, Int) throws -> Bool#>)이다. 부등호가 이것을 만족시키기 떄문에 부등호를 통해 표현도 가능하다..
print(sorted) //[“Ewa”, "Daniella", "Chris", "Barry", "Alex"]
}
```

### - Clusure Exam

```swift
self.present(nextVC,
 animated:true, 
 completion:( () -> void )? ) 
 
let alert = UIAlertAction(title: "알럿", 
							style: .default,  
                       handler: ((UIAlertAction) -> Void)? )
                       
UIView.animate(withDuration: 0.3,
		   animations: () -> Void,  
          completion: ((Bool) -> Void)?)
```

>- 클로져는 인자로써 사용할때 다양한 처리를 구현하여 전달 함으로써 데이터에 집중하지 않고 처리를 전달할 수 있다. 


### Nested Function

- 함수 내부에서 함수를 정의해서 사용 되는 함수
	- 외부에는 숨겨져 있으며 선언된 함수 내부에서만 호출 가능하다.
	- 함수 중간에서 선언되어 사용되기때문에 생명 주기는 선언된 함수내에서만 가능하다.

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
```


### 1급 객체 (First-class citizen)
- 1급 객체란? : 일반적으로 다른 객체들에 적용 가능한 연산을 모두 지원하는 객체를 가리킨다. ( 스위프트에서 함수는 1급 객체이다)

- 1급 객체가 되려면?
	- 변수나 데이터에 할당할 수 있어야 한다.
	- 객체의 인자로 넘길 수 있어야 한다.
	- 객체의 리턴값으로 리턴할 수 있어야 한다.	- 할당에사용된이름과관계없이고유한구별이가능하다.	- 동적으로프로퍼티할당이가능하다.
	
```swift
let testVoid: () -> () = {
    print("1급 객체 맨~")
}

func firstCitizen() {
    print("function call")
}

func function(_ parameter: @escaping ()->()) -> (()->()) {
    return parameter
}

let returnValue = function(firstCitizen)//이와 같이 파라미터로 함수를 넣을수 있는 특성
returnValue()
```
### MemoryCapture
>- 클로져 안의 모든 상수와 변수에 대한 참조를 캡쳐 해서 관리하며, Swift에는 캡쳐를 위한 모든 메모리를 관리한다.
>- 클로져 안의 값들은 모두 캡쳐가 되며, immutable한 값으로 클로져 내부에서만 사용하도록 만들고 싶은경우에는 [ ] 를 통해 캡쳐 리스트를 만들어 사용한다.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  func incrementer() -> Int {
    runningTotal += amount
    return runningTotal
  }
  return incrementer
}// nested function

func makeIncrementer(forIncrement amount: Int) -> () -> Int {
  var runningTotal = 0
  return {
    runningTotal += amount
    return runningTotal
  }
}// closure

let incrementer = makeIncrementer(forIncrement: 7)// 해당 변수의 스코프가 끝나면 메모리에서 사라진다.
print(incrementer())  // 7
print(incrementer())  // 14
```


```swift
// Value 타입들에 대한 캡쳐 예시
var a = 1
var b = 2
var c = 10
var result = 0
print("초기화 값 :", a, b, c, result)//1 , 2, 10 , 0
print("a, b 만 캡쳐")
let valueCapture = { [a, b] in// a,b를 immutable 값으로 캡쳐한거임.. 
    result = a + b + c
    print("클로저 내부 값 :", a, b, c, result)
}

a = 10
b = 10
c = 5
result = a + b + c
print("변경 값 :", a, b, c, result)

valueCapture()// 캡쳐한 a,b는 캡쳐를 하기때문에 캡쳐된 이전값을 a,b가 갖고 있다. 그래서 1 2 5 8이 나오는거..(현재 이시점에 a와 b는 10임)
print("실행 이후 값 :", a, b, c, result)

// Ref 타입들에 대한 캡쳐 예시
final fileprivate class RefType {
    var number = 0
}
fileprivate var x = RefType()
fileprivate var y = RefType()
print("초기화 값 :", x.number, y.number)

let refCapture = { [x] in// x 인스턴스의 주소값이 캡쳐되는거임. x 내부의 프로퍼티들까지 캡쳐된것은 아님.
    print("클로저 내부 값 :", x.number, y.number)
}
x.number = 5
y.number = 7
print("변경 값 :", x.number, y.number)

refCapture()//그래서 값(스택)은 의미가 없이 똑같이 x.number = 5를 갖는다.
print("실행 이후 값 :", x.number, y.number)
```

## Binding an arbitrary expression

- 클로져에서 참조형 타입의 값을 캡쳐 할 경우 내부의 프로퍼티들까지 캡쳐되지 않는다.
- 따라서 캡쳐시에 임의의 바인딩을 통해 값을 사용한다.

- 주의 사항(윅이랑 언원드를 안쓰면 ARC로 인해 순환참조가 일어 날수 있다.)
	- weak : 참조하는 데이터가 사라질 경우. nil이 되도록 ..
	- unowned : 참조하는 데이터가 사라지더라도 nil이 되지 않는다. 이렇게 캡쳐하게 되면 댕글리 포인터가 된다. (주소 값이 남아있는다 == 참조권이 남아있다)

```swift
let captureBinding = { [z = x] in
    print(z.number)
}

let captureWeakBinding = { [weak z = x] in
    print(z?.number ?? 0)
}
let captureUnownedBinding = { [unowned z = y] in
    print(z.number)
}

captureBinding()
captureWeakBinding()
captureUnownedBinding()

```
## escaping, Noescaping

- @escaping : 클로져 밖의 값에 접근하여 뭔가 변경하려 할경우 인자의 타입앞에 @escaping을 해줘야 한다.
- @Noescaping : 스위프트의 클로져는 4이후부터 해당 속성으로 인자의 타입을 받는것을 디폴트로 한다. escaping을 붙이는 이유와 반대의 의미를 갖는다.

- noescaping하는 클로져의 내부에서 escaping을 해야하는 경우가 생긴다면 외부의 클로져는 escaping이 되어야 한다.


 
```swift
final internal class Callee {
    func doSomething(closure: () -> Void) {
        closure()
    }
    init() {
        print("Callee was initialized")
    }
    deinit {
        print("Callee was deinitialized")
    }
}

final class Caller {
    let callee = Callee()
    var name = "James"

    func doSomething() {
        callee.doSomething {
            name = "Tom"
        }
    }
    var closure: (() -> ()) = {}
    func noEscapingClosure(_ arg: @escaping ()->()) {
        self.closure = arg    // required @escaping 뭔가를 바꾸기 위해 밖의 프로퍼티에 접근한다 이럴경우 escaping을 써줘야한다.
        someFunc(arg)
    }

    func someFunc(_ arg: () -> ()) {
        arg()// 뭔가를 바꾸는게 아니라 함수안에서 종 료된다.
        //    self.closure = arg    // required @escaping 클로져안에서 호출된 함수안에서 escaping을 하고자 하면 호출 한 함수에서도 escaping이 되어야 한다.
    }

    init() {
        print("Caller was initialized")
    }
    deinit {
        print("Caller was deinitialized")
    }
}

print("[ Init ]")
var caller: Caller? = Caller()

print("\n[ Deinit ]")
caller?.doSomething()
caller = nil

print("\n[ End ]")
```
>- weak, unowned를 사용하여 참조에대한 명시를 명확하게 해주지 않는다면 메모리 leak이 발생한다. (순환 참조에 의하여)
>- 따라서 애매 할때는 클로져에서 escaping을 해야 할때 weak을 붙여 캡쳐한다.

```swift
final class Callee {
//    func doSomething(closure: () -> Void) {    // @noescaping
//        closure()
//    }
      func doSomething(closure: @escaping () -> Void) {  // @escaping
        closure()
      }
    
    init() {
        print("Callee was initialized")
    }
    deinit {
        print("Callee was deinitialized")
    }
}

final class Caller {
    let callee = Callee()
    var name = "James"
    
    func doSomething() {
//            callee.doSomething {
//              name = "Tom"     // self keyword (X)
//            }
            callee.doSomething {
              self.name = "Tom"   // self keyword  (O) @escaping// escaping은 외부의 프로퍼티에 영향을 주기 때문에 명확하게 어느 프로퍼티를 이야기하는지 명시해줘야한다.
            }
        
        callee.doSomething {
//                  DispatchQueue.main.async {
//                    self.name = "Tom"    // Leak // 콜러 -> 콜리 -> 디스패치큐 -> 셀프 네임(콜러)를 호출 혹은 참조한다. 그래서 콜러만 지워준다고해도 콜리가 계속 남아있어서 콜러가 지워지지 디이닛 되지 않는거임.
//                  }
            
                  DispatchQueue.main.async { [weak self] in// 그래서 이런식으로 콜러 자체를 윅으로 바인딩을 해주면 참조만 하니까 디이닛이 된다..
                    self?.name = "Tom"   // Release
                  }
        }
    }
    
    init() {
        print("Caller was initialized")
    }
    deinit {
        print("Caller was deinitialized")
    }
}

print("[ Init ]")
var caller: Caller? = Caller()

print("\n[ Deinit ]")
caller?.doSomething()// 이시점에서 self.name = 접근을 통해 참조가 한번 더생기게 됨.
caller = nil// 디이닛

print("\n[ End ]")

// 정 햇갈리면 self를 컴파일러가 쓰라고 하면,  [weak self]를 기계처럼 처도 상관은 없다..
```
- 이해를 도울 참조 그림

![screen](weakRef.jpg)




```swift
struct Pet {
    enum PetType {
        case dog, cat, snake, pig, bird
    }
    var type: PetType
    var age: Int
}

let myPet = [
    Pet(type: .dog, age: 13),
    Pet(type: .dog, age: 2),
    Pet(type: .dog, age: 7),
    Pet(type: .cat, age: 9),
    Pet(type: .snake, age: 4),
    Pet(type: .pig, age: 5),
]

//1. 강아지들의 나이를 합산한 결과를 반환하는 sum 함수 구현
func sumDogAge(petList: [Pet]) -> Int{
    var resAge = 0
    for pet in petList{
        if pet.type == .dog{
            resAge += pet.age
        }
    }
    return resAge
}



//2. 모든 펫의 나이를 1씩 더한 배열을 반환하는 newAge 함수 구현
func newAge(petList: [Pet]) -> [Pet]{
    var newAgePet: [Pet] = petList
    for index in 0..<newAgePet.count{
        newAgePet[index].age += 1
    }
    return newAgePet
}


print(sumDogAge(petList: myPet))
print(newAge(petList: myPet))
```

## map 
- 컬렉션의 각 요소(Element)에 동일 연산을 적용하여, 변형된 새 컬렉션 반환(immutable)
- 컬렉션의 각 항목의 데이터를 (동일한 처리를 통해서) 다른 데이터로 변경해주는 역할

```swift
// pet의 나이를 한살씩 더먹이고 싶어..
func newAge() -> [Pet]{
    return myPet.map({
        Pet(type: $0.type, age: $0.age+1)
    })
}
```

## filter
- 컬렉션의 각 요소를 평가하여 조건을 만족하는 요소만을 새로운 컬렉션으로 반환


## reduce
- 컬렉션의 각 요소들을 결합하여 단 하나의 타입으로 반환.   
	- ex) Int, String 
- 입력되는 요소와 반환되는 요소가 서로 다른 타입일 수 있음.

```swift
// pet의 나이를 모두 더하는 함수를 만드려면?
func sum() -> Int {
    return myPet
        .filter {
            $0.type == .dog
        }//조건을 만족하는 요소만을 새로운 컬렉션으로 반환
        .reduce(0) {// $0은 Result, $1은 Pet
            $0 + $1.age
        }//컬렉션의 각 요소들을 결합하여 단 하나의 타입으로 반환
}

```

## Exam - map, filter, reduce

```swift
let immutableArray = Array(1…40)

1. 배열의 각 요소 * index 값을 반환하는 함수
2. 배열 요소 중 홀수는 제외하고 짝수만 반환하는 함수
3. 배열의 모든 값을 더하여 반환하는 구현 
4. immutableArray 에 대해서 1~3 번 함수를 차례대로 적용한 최종 값을 반환


```


## flatmap

```swift
```

### - Reference
- [FRPP?](https://www.youtube.com/watch?v=cXi_CmZuBgg&feature=youtu.be)