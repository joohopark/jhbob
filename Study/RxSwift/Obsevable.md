# RxSwift
# - Observable -

---


## Observable이 뭔데?

>- "Observables are the heart of Rx"


- Rx의 심장.. 하 거창;
- Observable은 무엇인고?
- Observable은 어찌 만드는고?
- Observable은 어찌 사용해야되는고?

- Observable == Observable Sequence == Sequence
	- 결국 다 같은 용어입니당.
- 다른 반응형 환경의 프로그래밍에서 부르는 스트림의 개념 또한 RxSwift 에서는시퀀스로 보면 됩니다.

- Observable은 특별한 힘을 가진(?) 단순한 시퀀스임.
- 중요한것은 이 옵져버블이 비동기적이래여..
- 옵져버블은 일정 기간동안 이벤트를 생성하고, 이러한 것을 보통 Emmitting 이라고 한다.
- 생성되는 이벤트로는 primitive Type의 값이나(숫자, 문자열), 탭 등의 제스처일 수 도 있다.
- 마블 다이어그램을 통해 이러한 것들을 이해하기 편함
- [마블 다이어그램, RxMarbles](http://rxmarbles.com)

## LifeCycle Of Observable

- Observable에서 생성된 이벤트가 모두 `next`를 통해 방출 되었을때 -> `completed` 이후 종료.
- 방출 중 `error`이벤트 발생으로 인해 종료.

>따라서,

- 옵져버블은 `.next`를 통해 이벤트를 방출 할 수 있다.
- `error`이벤트를 통해 비정상적으로 종료할 수 있다.
- `completed`이벤트가 발생했다는것은 옵져버블이 모든 이벤트를 `.next`를 통해 방출 했다는것임.

```swift
 /// Represents a sequence event.
 ///
 /// Sequence grammar:
 /// **next\* (error | completed)**
 public enum Event<Element> {
 	/// Next elemet is produced.
 	case next(Element)
 	
 	/// Sequence terminated with an error.
 	case error(Swift.Error)
 	
 	/// Sequence completed successfully.
 	case completed
 }
```

- 위의 코드를 통해 알 수 있는거슨.. 각 Event들은 Enum을 통해 제공된다는것이져..
	- .next 이벤트는 어떠한 Element 인스턴스를 가지고 있는 것을 확인할 수 있다.
	- .error 이벤트는 Swift.Error 인스턴스를 연관 값으로 가진다.
	- completed 이벤트는 아무런 연관 값을 가지지 않고 단순히 이벤트를 종료시킨다.

## Observable의 생성..

```swift
//
//  ViewController.swift
//  Rx01CreateObservable
//
//  Created by 주호박 on 2018. 3. 23..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        example(of: "just, of, from") {
            // step 1
            let one = 1
            let two = 2
            let three = 3
            
            //step 2 : just 오퍼레이터를 활용한 옵져버블 생성.
            let observable:Observable<Int> = Observable<Int>.just(one)// Observable<Int> 인스턴스  생성
            // just는 옵져버블 클래스의 타입 메소드로, 하나의 요소를 포함하는 옵져버블을 생성한다.
            
            //step 2 : of 오퍼레이터를 활용한 옵져버블 생성.
            let observableByOf: Observable<Int> = Observable<Int>.of(one, two, three)// Observable<Int> 인스턴스  생성
            // of는 받은 인자들의 타입을 통해 타입 추론을 하여 옵져버블을 만든다.



            let testList: [Int] = [1,2,3,4]
            // 따라서 타입 추론을 통해 array를 통해 만드는것도 가능
            let observableByOfUsingArray1 = Observable.of(testList)// Observable<Int> 인스턴스  생성
            let observableByOfUsingArray2 = Observable.of([one,two,three])// Observable<Int> 인스턴스  생성
            
            //step 2 : from 오퍼레이터를 활용한 옵져버블 생성.
            let observableByFrom = Observable.from(testList)
            //from은 오직 Array만 받아서 옵져버블 인스턴스들을 생성한다.
            // 생성된 옵져버블은 배열의 요소 하나하나를 방출한다.
        }

        
        
    }
    
    
    public func example(of description: String, action: () -> Void) {
        print("\n--- Example of:", description, "---")
        action()
    }
    
    

    
}
```

## Observable의 구독

- 기존 Swift의 NotificationCenter 를 봐보자구요.

```swift
let observer = NotificationCenter.default.addObserver(
 	forName: .UIKeyboardDidChangeFrame,
 	object: nil,
 	queue: nil
 ) { notification in
 	// Handle receiving notification
 }


```

- 이거슨 .UIKeyboardDidChangeFrame에 대한 노티피케이션 옵져버 입미다.

- RxSwift에서는 Observable을 구독하는 것은 상기 방식과 유사?! 하다고 함.
	- 옵져버블을 구독하려면 subscribe를 호출한다.
	- 따라서 addObserver() 대신에 subscribe를 사용하는거임.. 싱글턴 자리에는 옵져버블이 들어가고..
	- `옵져버블은 실제로 시퀀스 정의 같은 거임.. 따라서 구독자가 발생하기 전까지(subscribe 메소드가 호출되기 전까지) 이벤트를 보내지 않는다. `

- Observable 구현은 Swift 기본 라이브러리의 반복문에서 .next()를 구현하는 것과 매우 유사하다...? 이건 첨알았음..

```swift
        let sequence = 0..<3// CountableRange<Int> 인스턴스를 생성.
        var iterator = sequence.makeIterator()//컬렉션 요소에 대해 이터레이터를 리턴..
        while let n = iterator.next() {// 이터레이터에 대해 리턴가능한 요소가 있다면 그를 리턴 없으면 nil 
            print(n)
        }
 
```

- Observable 구독은 이보다 더 간단하다.
- Observable이 방출하는 각각의 이벤트 타입에 대해서 `handler`를 추가할 수 있다.(방출하는 이벤트 타입들을 처리 할 수있게끔 해줄수 있다는 말로 이해하자)
- Observable은 .next, .error, .completed 이벤트들을 다시 방출할 것이다.
	- .next는 handler를 통해 방출된 요소를 패스할 것이고,
	- .error는 error 인스턴스를 가질 것
	- .next를 통해 옵져버블의 모든 요소를 방출했다면 .completed 이벤트가 마지막으로 방출된다.

### subscribe()

```swift
    private func exampleCreateSubscribe(){
        example(of: "subscribe") {
            let one = 1
            let two = 2
            let three = 3
            
            let observabe = Observable.just(one)
            observabe.subscribe({ (event) in
                print(event)
            })       
        }
    }
    
//==================결과
--- Example of: subscribe ---
next(1)
completed    
    
```

```swift
// subscribe -=-=-=-=-=-=-=-=-=-=-=-=-
func subscribe(_ on: @escaping (Event<Int>) -> Void) -> Disposable

Description : Subscribes an event handler to an observable sequence.
//옵져버블에 에 이벤트 핸들러를 등록

Parameters : on Action to invoke for each event in the observable sequence.
//옵져버블의 각각의 이벤트에 대해 각 이벤트를 호출하는 on 액션.

Returns : Subscription object used to unsubscribe from the observable sequence.
//옵져버블의 구독을 취소하는데 사용되는 옵져버블 객체..


보고
관찰 가능한 시퀀스의 구독을 취소하는 데 사용되는 구독 개체입니다.
```


- subscribe는 escaping 클로져로 Int 타입 Event로 인자를 갖는다.
- 결과를 보면 next(1) 이런식으로 `next` 이벤트가 방출됨.
- 이벤트가 끝나면 자동으로 `completed`가 방출됨.

## subscribe(onNext:)

















