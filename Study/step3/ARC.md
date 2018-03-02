# ARC,
# 코드의 확장(
# subscript,
# extension)
# generic
---
---

## 메모리 관리 방식

- 명시적 해제 : 모든것을 개발자가 관리함(deinit)
	- C : malloc, dealloc.. memory leak의 문제
- garbageCollector : 수시로 가비지 컬렉터가 객체를 확인해서 안쓰는 객체를 해제시킴.( 시스템적으로 과부하)
	- java : 안쓰는 인스턴스를 heap에서 찾아 해제, 참 편하지만, 무거워..
- Reference Counting : 오너쉽 정책에 의해 객체의 해제 정의
	- objc : 참조 발생시마다 카운트가되고 참조 안한다 해줄때마다 카운트를 내림.

#### - 참조??

```swift
a = 인스턴스
b = 인스턴스

// 인스턴스를 참조하는 애는 a,b 이고. 둘이 사라질때.. 참조가 해제
```

#### - 오너쉽 정책

- 소유권 : 실제로 소유하고 있는것.
- 사용권 : 가져다 쓸 수 만 있는것.


## ARC, AutoReferenceCounting

<pre>
NSString *str1 = [[NSString alloc] init]; // NSString 인스턴스 생성
NSString *str2 = [str1 retain];// retain은 소유권을 주는것
NSString *str3 = str2;// 사용권을 전달.
// 그래서 str3를 제외하고 해제를 해준다. str3은 자동으로 nil
[str1 release];
[str2 release];
</pre>

- objc에서는 alloc 과 retain 을 사용해서, 해당 변수를 메모리로 올리고,release를 통해 메모리에서 해제.
- objc에서 인스턴스를 넣었을때, 명시적으로 표현해줄때 Referene Count가 증가.

<pre>
// objc
NSString *str1 = [[NSString alloc] init];
NSString *str2 = [[NSString alloc] init];
NSString *str3 = [[NSString alloc] init];
// 인스턴스를 셋 만들어줬어
str2 = [[NSString alloc] init];
// 중복해서 하나 더만들었어, 이시점에서는 참조가 변경됨.(참조 메모리 값이 변경)
[str1 release];
[str2 release];
[str3 release];
// 중복해서 만든애는 zombie가 됨. 메모리 leak이 발생.
</pre>

<pre>
// swift4
var p2 = Person()
p2 = Person()
p2 = Person()
p2 = Person() // <- 여기서 생성한 인스턴스만 살아 남고 위에 만든건 ARC에 의해 자동으로 힙에서 사라짐.
</pre>


- ARC는 Automatic Reference Counting의 약자로 기존에 수동 (MRC라고 함)으로 개발자가 직접 retain/release를 통해 reference counting을 관리해야 하는 부분을 자동으로 해준다.(Swift4..ㅎㅎ)

## ARC 도입 이유 

- 앱의 비정상 종료 원인 중 많은 부분이 메모리 문제. 메모리 관리는 애플의 앱 승인 거부(Rejection)의 대다수 원인 중 하나.
- 많은 개발자들이 수동적인(retain/release) 메모리 관리로 힘들어함
- retain/release 로 코드 복잡도가 증가 

- 2011년도 WWDCD에서.. 발표된 기술

- 명시적 해제는 어려워,, 가비지 컬렉터는 느려.. 근데 ARC는!?
- 컴파일러 수준에서 Swift는 자동으로!!

---

## ARC 규칙

- retain, release, retainCount, autorelease, dealloc을 직접 호출할수 없음..
- 구조체내의 객체 포인트를 사용할 수 없다. 
- id나 void * type을 직접 형변환 시킬 수 없다. 
- NSAutoreleasePool 객체를 사용할수 없다. 


## Swift에서의 ARC 키워드

- strong : 인스턴스의 소유권이 가게됨. 소유권은 즉 참조권도 같이 포함됨.
	- strong은 default임.
	- 모든 변수들은 강한 참조..
	- 힙을 직접적으로 참조할때 강한 변수임.
	- 해제 : 다른 값을 참조하거나. 코드 블록을 통한 변수의 생명주기에 의해 자동으로..!!

<pre>
// 강한 참조 선언
//objc
@property(strong) Person *p1;
@property(strong) Person *p2;

// swift
var p1:Person
var p2:Person

// 인스턴스 할당
//objc
p1 = [[Person alloc] init];

//swift
p1 = Person()
// 힙의 ref count + 1

// 만약 
p2 = p1
// ref Count + 1 되서 총 2가 됨.

</pre>


- weak : 인스턴스의 참조권
	- 힙을 직접적으로 참조하는것이 아니라 인스턴스가 들어간 변수를 받아서 사용할때.. 참조권을 갖게 되는거임.. ( 약한 참조로 선언 한 변수의 경우)

<pre>
// 약한 참조 선언
// objc
@property(strong) Person *p1;
@property(weak) Person *p2;

//swift
var p1:Person
weak var p2:Person

// 인스턴스 할당
//objc
p1 = [[Person alloc] init];

//swift
p1 = Person()

// ref count + 1

// 만약
p2 = p1
// ref count + 0 , 약한 참조에 인스턴스를 넣어주면 카운트 증가 ㄴㄴ
// 즉 소유권은 없지만 참조권은 가져가는 형태

// 만약
p2 = Person()
// 약한 참조에 인스턴스를 넣어 주면?? 
// p2는 옵셔널이 된다. 저 시점에서만 인스턴스를 갖고 바로 힙에서의 인스턴스는 사라짐..
</pre>

## 왜 스토리 보드에서 아웃렛을 연결하면 weak인가??

- 소유권이 누구에게? 있는 걸까??
	- 스토리 보드는 원천적으로 메모리적 시점에서 swift에서 어느것도 소유하지 않는다.( UI를 그리는 Class와 같다)
	- 원천적으로 뷰가 갖고 있게 된다.

>결론은 윜으로 프로퍼티를 선언하고 뷰디드로드 에서 강한 참조를 약한 참조에 넣어 사용하는것이 현명.
>그래야 강한 참조는 코드블록이 사라지면 없어지지만 약한 참조를 통해 카운트가 증가 되어 있기 떄문에, 힙에는 남아있게 되고 이 참조가 사라지면 자동으로 사라지기 때문에 이런식으로 사용하는것이 현명하다.
>
>addsubview는 
뷰는 카운트 1을 갖고 있음
에드 섭뷰는 참조를 하는 행위이기때문에 카운트가 1증가 됨.
여기에 올라가는 유아이가 다른곳에 사용될 경우 예기치 못하게 문제가 될 수 있음. 그래서 윜임.
>
>멀티 쓰레드
오래 걸리는 작업이 잇을 경우 멀티 쓰레드를 통해 작업을 분업화 하는것이 좋겠쪄..?
>
>사용자의 인터렉션은 하나의 메인큐에서 관리.
예를 들어 로그인을 했어.. 근데 통신에 의해서 늦어 반응이.. 근데 이게 메인큐야 사용자가 취소했어 그럼 통신이 끝나야 취소가 먹혀..
그래서 멀티 쓰레드를 해
>
>메인큐의 서브큐에서 네트워크를 통한 프로세스를 처리하게 해
여러 큐에서 참조권을 공유해야해 그런경우 참조권만 나눠주는 경우에는 특정경우에 nil이 될 수 있음.

#### - 참조권만 갖을 수 있는 weak를 쓰는 이유는...?

- 순환 참조 : 참조권을 돌려가며 사용할 때, 서로가 서로를 참조할때. 메모리 해제가 안되는 경우.,
	- weak를 사용하여 맞물리는 참조 인스턴스의 해제를 할 수 있도록 해야함.

- 델리게이트 역시 순환 참조기 때문에 델리게이트 프로토콜의 프로퍼티는 weak를 해줘야 메모리 해제가 된다.

- 클로져, 멀티 쓰레드, unowned(얘는 nil이 되면 충돌) 의 경우에 weak을 신경써줘야함.

## Unowned vs Weak

- Unowned : 소유권이 없는 참조임을 나타내는 지시어

- Optional 차이 <br>
	1. Unowned : 절대 nil이 아니다. 앞의 참조보다 먼저 해제 되야 할때..<br>
	2. Weak : nil 일수도 있다

> 무조건 optional 을 피해가는게 좋은것은 아니다. 어느부분에서 무조건 crush를 내주어야 그 이후에 app이 문제 없이 동작할수 있겠다 하는 부분을 옵셔널 바인딩해서 피해가는게 능사는 아닙니다... 어영 부영 optional을 통해 할바엔 crush를 내는것이 좋다,
> 
> 스토리 보드에서 IBOutlet을 하게되면 디폴트 값으로 weak를 가져오는데 그 이유는 `addsubView`에 있다, 사실 스토리보드도 하나의 XIB로 된 인스턴스 인데, 스토리보드의 ViewController에서 View를 올리면 자동으로 해당 ViewController 의 rootView에 View가 addSubView 되게 된다. 그래서 사실, 스토리 보드로 인스턴스를 생성해서 사용할때와, 코드로 사용할때 메모리 사용이 각각 다르다는것을 명확하게 인지하고 app 을 설계해야 할것 같다! 그렇지 않게 되면 나중에 메모리 관련 문제가 생겼을때 조금 찾기 어려울수 있을것 같다는 생각이 든다.
> 
> 
> 또 한가자로.. 아싸리 햇갈릴거 같으면 weak을 배제하고 strong을 통해 개발을 진행하는것도 나쁘지 않다.
> 
> weak을 잘못 사용할 경우.. 메모리에서 이미 해제가 되버려서 문제가 야기 될 수 있다....

#### - closure 의 weak 사용 

```swift
{ [Unowned self] in 
	self.view.backgroungColor = .red
	
}
```

> closure의 경우, 캡쳐라는것을 통해서, closure 가 사용될때마다, 그 안에 있는 값이 app이 죽을때가지 계속 살아 있다. 그래서 closure를 사용할떄 `weak` 를 사용하면, 조금더 좋은(?) 메모리 관리를 할수 있습니다. 엄밀하게 얘기하면 무엇이 정답이다라는것은 없는데, 상황에 맞게 사용하시는게 좋습니다!

---


## Subscript

- 클래스, 구조체, 열거형의 collection, list, sequence의 멤버에 접근 가능한 단축문법인 Subscript를 정의 할수 있다.
- array나 dictionary의 리터럴 문법을 직접 구현하여 제공할 수 있다.
	- Array[index] / Dictionary[“Key”] 등의 표현이 Subscript이다.
- Subscript는 별도의 setter/getter없이 index를 통해서 데이터를 설정하거나 값을 가져올 수 있음.( 연산 프로퍼티 처럼 구현 하면 사용이 가능)
	- getter만 있어도 됨. 둘다 있을 필요 없음.

### subscript exam

```swift
subscript(index: Type) -> Type {
        get {
            // return an appropriate subscript value here
        }
        set(newValue) {
            // perform a suitable setting action here
		 } 
}


class Friends {
	private var friendNames:[String] = []
   subscript(index:Int) -> String{// 파라미터의 타입에 맞게 키값과 반환값을 매칭 하는 느낌.
		get {
              return friendNames[index]
       }set {
              friendNames[index] = newValue
       }
	} 

}

let fList = Friends()
fList[0] = "joo"


struct TimesTable {
      let multiplier: Int
      subscript(index: Int) -> Int {
          return multiplier * index
      }
}

let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// 굳이 인덱스를 원본자체로 끄집어 내는것이아니라 내부에서 연산 하는것도 가능함.


// 구조체 subScript를 통해 1차원배열로 만든 2차원 배열 표현
struct Matrix{
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)// 배열을 생성시 모든 값을 0.0
    }
    
    subscript(row: Int, column: Int) -> Double{
        get{
            return grid[(row * columns) + column]// row* columns는 몇번째 행에 접근 할거냐, + column은 몇번째 열에 접근할꺼야 를 의미..
        }set{
            grid[(row * columns) + column] = newValue
        }
    }
}// 1차원 배열을 2차원처럼 쓸 수있게..

var metrix = Matrix(rows: 2, columns: 2)
print(metrix)
metrix[0,0] = 1
print(metrix)
metrix[0,1] = 2.5
print(metrix)
metrix[1,0] = 1.4
print(metrix)
metrix[1,1] = 3.3
print(metrix)
print(metrix[1,1])
//metrix[2,1] = 3.3// out of range
//print(metrix)

//==========결과
Matrix(rows: 2, columns: 2, grid: [0.0, 0.0, 0.0, 0.0])
Matrix(rows: 2, columns: 2, grid: [1.0, 0.0, 0.0, 0.0])
Matrix(rows: 2, columns: 2, grid: [1.0, 2.5, 0.0, 0.0])
Matrix(rows: 2, columns: 2, grid: [1.0, 2.5, 1.3999999999999999, 0.0])
Matrix(rows: 2, columns: 2, grid: [1.0, 2.5, 1.3999999999999999, 3.2999999999999998])
3.3
//==========
// 구조체를 쌩으로 프린트찍으면 가끔 더블 값이 깨지는것 같음..
    
```
## Extensions

- class 의 확장.
- 기존에 만들어진 class들을 extension하여 사용가능
- 연산, 메서드들만 추가 가능.. 저장 프로퍼티는 원형 class에 영향을 줄 수 있기 때문에 넣을 수 없다.
- 코드 관리의 편의성.
- 델리게이트를 해야할때 계속해서 추가해서 사용해서 약간 코드를 분리하여 관리가 가능.
- 단일 파일에 굳이 작성 할 필요는 없다.
	- 단일 파일이라면 접근제한자의 영향이...
	- 단일 파일이라면 class의 private를 extension에서 접근 가능.(다른 파일에서는 추가 ㄴㄴ)
- 상속은 안되지만 프로토콜 채택은 가능하다. 왜냐면 프로토콜은 여러개 상속은 1개뿐이 안되기때문이져~

- 네트워크를 통해 이미지를 다운받아 uiimageView에 넣을때 extension을 사용한다던지..
	- 기존의 class에 기능을 추가하여 사용 한다~

#### - tip!!!!
>- 기존 Class를 상속받는 모든 subClass들에게 영향을 미치고 싶을때
	- 부모 Class를 Extension 해서 사용~
	- 매우 유용~ 할것으로~ 보여요~


>- Delegate, DataSource에 관련된건, 아예 Extension으로 빼서 코드 정리에 유용..

## Extensions exam

```swift
 extension SomeType {
     // new functionality to add to SomeType goes here
}
 extension SomeType: SomeProtocol, AnotherProtocol {
     // implementation of protocol requirements goes here
}


  extension Double {
      var km: Double { return self * 1000.0 }
      var m: Double { return self }
      var cm: Double { return self / 100.0 }
      var mm: Double { return self / 1000.0 }
      var ft: Double { return self / 3.28084 }
}

  let oneInch = 25.4.mm
  print("One inch is \(oneInch) meters")// Prints "One inch is 0.0254 meters"
  let threeFeet = 3.ft
  print("Three feet is \(threeFeet) meters")// Prints "Three feet is 0.914399970739201 meters"
  
extension Int {// Int의 제곱에 대한 extention 
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()  
  

//12345[0] = 5
extension Int{
    subscript(digitIndex: Int) -> Int{
        get{
            var mul: Int = 1
            for _ in 0..<digitIndex{
                mul *= 10
            }
            return (self / mul) % 10
        }
    }
    
}

print(12345[0])

//===== 결과 
5
//=====

```

## Generic

- `어떤 타입`에도 `유연한 코드`를 구현하기 위해 사용되는 기능...!!
- 코드의 중복을 줄이고, 깔끔하고 `추상적인 표현이 가능`...!!

- 제넥릭에 사용된 “T”는 타입의 이름으로 사용되었다기 보다는 placeholder 역할로 사용된다고 보면 된다.
- 타입은 꺾쇠<> 로 감싸 표시한다.
- 타입의 이름은 보통 사용되는 속성에 맞게 네이밍 할수 있으나 아무런 연관이 없는 타입의 경우에는 T,U,V 같은 알파벳으로 사 용된다.
	- 어느 알파벳이든 <> 안에 있는 애가 곧 타입 문법자리를 대신하게 된다.

- 제네릭은 해당 타입 (Class, Struct) 등을 선언할때 그에 대한 제네릭을 <T>을 같이 선언 해준다.

```swift
//== Array 
public struct Array<Element> : RandomAccessCollection, MutableCollection {

...
...
    public subscript(index: Int) -> Element
    
...
...
    public mutating func append(_ newElement: Element)

}
//== 코드 블럭 안에서 Element는 하나의 타입으로 여겨지게 된다.

var list = Array<Int>() // 원래 이런식으로 했응게... 이거시 바로 제네릭인겨..<Int>
```

## Generic Exam

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) { 
	let temporaryA = a
	a=b
	b = temporaryA
}
// Int 에 대한 스왑 함수를 여러 타입에서 사용해야 된다면..?

func swapTwoValues<T>(_ a: inout T, _ b: inout T) { 
	let temporaryA = a
	a=b
	b = temporaryA
}

 var someInt = 3
 var anotherInt = 107
 swapTwoValues(&someInt, &anotherInt)
 // someInt is now 107, and anotherInt is now 3
 var someString = "hello"
 var anotherString = "world"
 swapTwoValues(&someString, &anotherString)
 // someString is now "world", and anotherString is now "hello"
```

```swift
//======= Generic을 사용한 Stack, Queue Struct 만들기.
struct Stack<T> {
    var stackList:Array<T>  = Array<T>()
    mutating func push(_ item:T){
        self.stackList.append(item)
    }
    mutating func pop() throws -> T  {
        if self.stackList.count != 0{
            return self.stackList.popLast()!
        }
        throw DataStructErr.stackIsEmpty
    }
    
}

enum DataStructErr: Error {
    case stackIsEmpty
    case queueIsEmpty
}


struct Queue<T> {
    var queueList: Array<T> = Array<T>()
    
    mutating func enqueue(_ item: T){
        self.queueList.append(item)
    }
    
    mutating func dequeue() throws -> T{
        if self.queueList.count != 0{
            let resVal = self.queueList[0]
            self.queueList.remove(at: 0)
            return resVal
        }
        throw DataStructErr.queueIsEmpty
    }
}

        var testStack: Stack = Stack<Int>.init()
        
        do{
            print(try testStack.pop())
        }catch DataStructErr.stackIsEmpty{
            print("Stack is Empty.. plz push Item..")
        }catch{
            print("default catch..")
        }
    
        var testQueue: Queue = Queue<Int>.init()
        
        do{
            print(try testQueue.dequeue())
        }catch DataStructErr.queueIsEmpty{
            print("Queue is Empty.. plz enqueue Item..")
        }catch{
            print("default catch..")
        }
        


```


####- note
<pre>
키워드 : 다운 샘플링.
</pre>

## Reference 


[Transitioning to ARC Release Notes](https://developer.apple.com/library/content/releasenotes/ObjectiveC/RN-TransitioningToARC/Introduction/Introduction.html#//apple_ref/doc/uid/TP40011226-CH1-SW14)<br>

[About Memory Management](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/MemoryMgmt.html#//apple_ref/doc/uid/10000011i)<br>

[Memory Management Programming Guide for Core Foundation](https://developer.apple.com/library/content/documentation/CoreFoundation/Conceptual/CFMemoryMgmt/CFMemoryMgmt.html#//apple_ref/doc/uid/10000127i)<br>

[ARC에 대한 설명이 잘 되어있는 blog](http://seorenn.blogspot.kr/2015/01/swift-memory-management-1.html)<br>

[err throw](https://medium.com/@abhimuralidharan/error-handling-in-swift-d0a618499910)

