# HOT & Cold Observable,
# Subjects

---

## Hot & Cold Observable

- 핫 옵져버블은 subscribe를 하지 않더라도 이벤트를 방출
- 콜드 옵져버블은 subscribe를 해야 옵져버를 생성해서 이벤트를 방출하게 됨.

- Subject는 Hot 옵져버블이라고 봐도 되는건가??

## Subject

- 옵져버블은 이벤트를 발행하고 구독을 통해 옵져버에게 이벤트를 전달하는 것임. 다 끝나면 구독을 중지 하기 위해 disposed하고..
- 하지만 실시간으로 옵져버블에 새로운 값을 수동으로 추가 하고 옵져버에게 이벤트를 전달 할 수 있어야함..
	- 그냥 명시적으로 옵져버블에 구독을 호출하는건.. 명령형 프로그래밍과 동일 하자나..
- 그래서 나온것이 옵져버블이자 옵져버의 역활을 둘다 하는 Subjects임..

- Subject = Observable + Observer 
	- 위와 같이 행동한다는 뜻임. 이벤트 발행자인 동시에 이벤트를 구독하는거임..
	- .next 이벤트를 받으면서 동시에 옵져버에게 이 이벤트를 뿌려줌..

- RxSwift에 존재하는 4가지 Subject
	- PublishSubject : 옵져버블은 이벤트를 들고 생성되지 않는다. 새로운 값을 observer에 방출.
	- BehaviorSubject : 하나의 초기값을 가진 상태로 시작, 옵져버에게는 이 초기값이나 아니면 최근에 들어온 .next이벤트를 방출.
	- ReplaySubject : 버퍼를 갖고 생성된다. 지정된 버퍼 사이즈만큼을 유지하면서 옵져버에게 이벤트를 방출한다.
	- Variable : BehaviorSubject를 래핑한다함. 현재의 state를 prevent하고, 가장 최신이나 초기값을 새로운 옵져버에게 뿌려준다. 




### PublichSubject

```swift
        example(of: "Publichsubject") {
            // 1
            let subject = PublishSubject<String>()// 옵져버블인 동시에 옵져버의 역활을 하는 인스턴스
            
            // 2
            subject.onNext("Is anyone listening?")// 그냥 추가만??
            
            // 3
            let subscriptionOne = subject
                .subscribe(onNext: { (string) in
                    print(string)
                })// 구독 이후에도 역시나..출력 안됨..
            
            // 4
            subject.on(.next("1"))        //Print: 1
            
            // 5
            subject.onNext("2")        //Print: 2
            
            //2번은 안되고 왜 4,5 번은 되지?? 옵져버를 만든 이후에만 이벤트 방출이 가능
            // 이걸 사용하지 않는 상황이 오도록 해야한다고 한다.. 되도록이면.. 
        }
```

- 주석
	- 1. PublichSubject<String>을 생성
	- 2. 확인을 위해 onNext로 이벤트 추가( 매일 햇갈린다)
	- 3. 옵져버 생성.
	- 4. 1 출력
	- 5. 2 출력.
		- 이것으로 PublishSubject는 현재 시점, 즉 element를 옵져버블에 넘겨주기전에 subcriber를 생성 하지 않았다면 이벤트를 방출하지 않는다..

- .on(.next("1")와 .onNext("2")는 subscribe 메소드와 비슷하게 동작. 새로운 `.next 이벤트`를 subject에 삽입 (결국은 옵져버블에 이벤트를 발행 ), 이벤트 내의 값들을 인자로 전달 한다 (뒤의 메소드에).

- 컨셉
	- PublichSubject는 subscribe된 순간, 즉 옵저버가 생성된 순간 (부터?) 이벤트 수신을 알리고 싶을 때 사용하면 좋다.
	- subscribe 뒤에 disposed 를 통해 구독을 멈추거나, .completed, .error 이벤트의 발생을 통해 subject를 완전히 종료 시키기전까진 계속됨.

![screen](publichSubject.jpg)

- 위 그림의 첫줄은 publichsubject고, 둘째, 셋째 줄은 옵져버들임 (subscriber)
- 아래로 향하는건 이벤트의 방출, 위로 오는건 구독을 선언 하는 시점을 의미.
- 따라서 둘째줄은 2부터 받을 수 있고, 셋째줄은 3만 받을 수 있다.

```swift
        example(of: "Two Subscriber") {
            //1. Subject 생성.
            let mainSubject = PublishSubject<String>.init()
            
            //2. 이벤트 1 추가
            mainSubject.on(.next("1"))
            
            //3. 1번 옵져버 생성
            let firstObserver = mainSubject.subscribe({ (event) in
//                let printEvent = event.element ?? event
                print("이거슨 첫번째 옵저벼의 이벤트 방출입미다 : ", event.element ?? event)
            })
            
            //4.  이벤트 2 추가
            mainSubject.on(.next("2"))
            
            let secondObserver = mainSubject.subscribe({ (event) in
                print("이거슨 두번째 옵저버의 이벤트 방출인겨 : ", event.element ?? event)
            })
            
            //5. 이벤트 3 추가.
            mainSubject.on(.next("3"))
            
            //6. 1번 옵져버 dispose
            firstObserver.dispose()
            
            //7. 이벤트 4 추가
            mainSubject.on(.next("4"))
            
            // 8. completed 이벤트 추가
            mainSubject.onCompleted()
            
            // 9. 이벤트 5 추가
            mainSubject.onNext("5")
            
            // 10. 두번쨰 옵져버 dispose
            secondObserver.dispose()
            
            let disposeBag = DisposeBag()
            
            // 11. 다시 서브젝트 생성 및 구독 시작
            mainSubject
                .subscribe {
                    print("3)", $0.element ?? $0)
                }
                .disposed(by: disposeBag)
            
            // 12. 이벤트 ? 추가
            mainSubject.onNext("?")
            
        }
```

- 주목해야될 부분.
	- 8번 이후로 subscriber 어느것도 dispose 하지 않았더라도 이벤트를 받지 못하고있음
	- 11번에 보면 새로 만들어진 subject의 subscribe가 되는것이지 기존에 있던게 이벤트를 방출하는것은 아님
	- 12번에 보면 다 dispose 된 이후에는 이벤트를 방출해도 아무도 받지 않죠~

- 시간에 민감한 데이터 모델링에 주로 쓰인단다..

## BehaviorSubjects로 작업하기

![screen](behaviorsubject.jpg)

- 컨셉
	- 마지막 .next 이벤트를 새로운 구독자에게 반복한다는것빼면 publish랑 거의 동.
	- 그림에서는 첨이 subject, 둘, 셋이 subscriber임.
	- 1이 이벤트가 발행된 이후에 두번째가 subscribe를 시작하지만 publish때와 다르게 이벤트 1이 방출됨.

### Example Code

```swift
     enum ExampleError: Error {
            case errorEvent
        }
        
        //*****************************Subjects******************//
        example(of: "BehaviorSubject") {
            let behaviorSubject = BehaviorSubject<String>.init(value: "1")
            let disposedBag = DisposeBag()
            
            let firstSubscriber = behaviorSubject.subscribe({ (event) in
                print("첫번쨰 구독자의 이벤트 : ", event.element ?? event)
            })
            
            
            behaviorSubject.on(.next("2"))
            
            let secondSubscriber = behaviorSubject.subscribe({ (event) in
                print("두번쨰 구독자의 이벤트 : ", event.element ?? event)
            })
            
            behaviorSubject.on(.next("3"))

            // disposeBag은 .completed 이벤트가 날라간 뒤부터 더이상 구독을 안한다.
            firstSubscriber.disposed(by: disposedBag)
            behaviorSubject.on(.next("4"))
            secondSubscriber.disposed(by: disposedBag)
            
//            behaviorSubject.on(.error(ExampleError.errorEvent))
//
//             behaviorSubject.on(.next("에러 뒤에 출력됨??"))
        }

```
- behaviorSubject의 그림을 토대로 구현한 내용임..
- eroror 이벤트 방출 이후에 더이상 이벤트를 subscribe 하지 않는다.


- view를 가장 최신의 데이터로 미리 채워놓기에 용이하다고 함.

## ReplaySubjects로 작업하기

- 컨셉
	- ReplaySubject는 생성시 선택한 특정 크기까지, 방출하는 최신 Element를 일시적으로 버퍼 한 다음, 해당 버퍼를 새 구독자에게 방출.

![screen](replaySubject.jpg)

### Example Code

```swift
        example(of: "ReplaySubject") {
            let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
            let disposeBag = DisposeBag()
            
            
            let firstSubscriber = replaySubject.subscribe({ (event) in
                print("첫번쨰 구독자의 이벤트 : ", event.element ?? event)
            })
            
            replaySubject.on(.next("1"))
            replaySubject.on(.next("2"))
            replaySubject.on(.next("3"))
            let secondSubscriber = replaySubject.subscribe({ (event) in
                print("두번쨰 구독자의 이벤트 : ", event.element ?? event)
            })
        }
```

- replaysubject를 생성할때 정해진 buffer 크기 만큼 발행된 이벤트를 잘 보관 하고있다가..subscriber가 생기면 버퍼에 있는 이벤트부터 방출을 시작한다.


- 최근 방출 이벤트 뿐만 아니라 최근에있었던 값들에 대해 보여줘야될 일이 있을 경우. 
	- 최근 검색어..

## Variables로 작업

- Observable의 현재값이 궁금 할 수있음.
- BehaviorSubject를 래핑(?)하고 이것의 현재값을 State로 보유. 
	- value 프로퍼티를 통해 현재값을 알 수있다.
- Variables의 요소로 Value가 오기 위해서는 onNext와 같이 이벤트 발행 방식은 쓸수 없음.
- error이벤트가 발생되지 않음을 보장하기 때문에 error 발행 못함.
- .complete도 필요 없다.
	- 할당 해제 되면 자동적으로 complete됨.

- Variable<Element> 임.

### Example Code

```swift
        example(of: "Variables") {
            let variables = Variable("init")
            let disposedBag = DisposeBag()
            
            variables.asObservable().subscribe({ (event) in
                print(event.element)
            })
            
            variables.value = "new String Event"
            
        }
```

- 헐.. deprecated 된 녀석인거 같다.

```swift
ℹ️ [DEPRECATED] `Variable` is planned for future deprecation. Please consider `BehaviorRelay` as a replacement. Read more at: https://git.io/vNqvx
Optional("init")
Optional("new String Event")
nil
```	

- BehaviorRelay쓰라고 하네여..
	- 얘는 RxSwift에 있는건 아니고 RxCocoa에 있습니다 ㅎㅎ

## Trait

- 그만나와... 이제 그만해..ㅠㅠㅠ 

- 이거는 Observable보다 좁은 범위의 Observable처럼 사용 가능하단다.
	- Observable이 이것저것 신경쓸게 많아서 그런가.. 가독성을 높이기 위해 사용.

### 종류

- Single, Maybe, Complete

### Single

- .success(value) 또는 .error 이벤트를 방출한다.
- .success(value) = .next + .completed
- 용도? 성공, 실패의 경우만 필요한 경우(1회성) 딱 한번만 결과값이 필요한경우. 데이터 다운로드 같은거

```swift
        example(of: "Single") {
            
            // 1
            // 모아서 버릴 쓰레기 통 선언
            let disposeBage = DisposeBag()
            
            // 2
            // 에러 정의
            // 파일 못찾았어, 못읽는거야, 인코딩 실패했어
            enum FileReadError: Error {
                case fileNotFound, unreadable, encodingFailed
            }
            
            // 3
            //이 함수는 파일을 읽어와서 Single을 반환합니당.
            // .success(value) 와 .error 를 방출하는 녀석을 반환.
            func loadText(from name: String) -> Single<String> {
                // 4
                //뭔가 Rx를 할때 Observable을 사용하고, 반환하는 함수를 만든다면!
                // 이런식으로 return을 먼저 던저주는 방식에 익숙해져야 될것 같다.
                // 함수 선언시 뭘 받고 무슨 Observable을 반환할지 결정하면
                // 그에 맞는 Observable을 리턴하는 return을 바로 선언한다? 라는 느낌으로 접근하자.
                // 그리고 반환할 옵져버블을 만들어 준다라는 생각으로 해야되.. 까먹지마..
                // 옵져버블을 만들어주는거야 중간에 리턴이 들어가는건 그냥 그 옵져버블은 얘를 리턴해야되기때문이야..
                return Single.create{ single in
                    // 4 - 1
                    //create method의 subscribe 클로저는 반드시 disposable을 리턴해야하므로, 리턴할 값을 생성
                    let disposable = Disposables.create()
                    
                    // 4 - 2
                    //파일명에 대한 경로를 받아오고, 만약에 해당 파일이 없으면 single에 해당 에러를 추가하고 disposable을 리턴한다.
                    guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                        single(.error(FileReadError.fileNotFound))
                        return disposable
                    }
                    
                    // 4 - 3
                   //해당 파일로부터 데이터를 받아오고, 파일을 읽을 수 없다면 역시 같은 방식으로 처리
                    guard let data = FileManager.default.contents(atPath: path) else {
                        single(.error(FileReadError.unreadable))
                        return disposable
                    }
                    
                    // 4 - 4
                    //파일 내 콘텐츠를 String으로 인코딩했을 때 에러가 없는지 검사
                    guard let contents = String(data: data, encoding: .utf8) else {
                        single(.error(FileReadError.encodingFailed))
                        return disposable
                    }
                    
                    // 4 - 5
                    // 성공했음 ~ 성공했다 이벤트 담아주고 리턴해주면 됩니다.
                    single(.success(contents))
                    return disposable
                }
            }
            
            loadText(from: "Copyright")
                .subscribe{
                    switch $0 {
                    case .success(let string):
                        print(string)
                    case .error(let error):
                        print(error)
                    }
                }
                .disposed(by: disposedBag)
```



### completable

- .completed 또는 .error만을 방출하며, 이외 어떠한 것도 방출 ㄴㄴ
- 용도? 연산이 제대로 완료! 되엇는지 확인하고 싶을때.

### Maybe

- Single과 Completable을 섞어 놓은것.
- success(value), .completed, .error를 모두 방출 가능.
	- 이럴거면 도대체 왜.....

- 용도? 성공, 실패, 출력된 값도 필요 한경우,. 



