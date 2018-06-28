# TDD, (Test Driven Development).. 작성ing..

### Reference
- Realm
	- [https://academy.realm.io/kr/posts/ios-tdd-test-driven-development/](https://academy.realm.io/kr/posts/ios-tdd-test-driven-development/)

- AppleDocs
	- XCTest
		- [https://developer.apple.com/documentation/xctest](https://developer.apple.com/documentation/xctest)
	- Test Cases and Test Methods
		- [https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods](https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods)

- RayWenderich
	- [https://www.raywenderlich.com/150073/ios-unit-testing-and-ui-testing-tutorial](https://www.raywenderlich.com/150073/ios-unit-testing-and-ui-testing-tutorial)

- X-team?
	- [https://x-team.com/blog/how-to-get-started-with-ios-unit-tests-in-swift/](https://x-team.com/blog/how-to-get-started-with-ios-unit-tests-in-swift/)

- @available(iOS 6.0, *)
	- [http://seorenn.blogspot.kr/2014/08/xcode-6-unit-test.html](http://seorenn.blogspot.kr/2014/08/xcode-6-unit-test.html)
	- [http://seorenn.blogspot.kr/2016/11/xcode-asynchronous-unittest.html](http://seorenn.blogspot.kr/2016/11/xcode-asynchronous-unittest.html)

## 테스트란 무엇인가? (What to Test?)
- 일반적으로, 테스트는 다음을 포함해야 한다.
	- 핵심기능 : 모델 클래스와 메소드, 컨트롤러와의 상호작용
	- 가장 일반적인 UI 흐름도(workflows)
	- 경계 조건(boundary conditions)
	- 버그 수정
- 'FIRST' 는 적절한 테스트에 대한 criteria(기준)이 됨.
	- Fast(빠르게) : 테스트는 빨리 실행되야 한다. 그래서 사람들이 신경쓰지 않는다.
	- Independent/Isolated(독립적/분리된) : 테스트는 따로 설정이나 분리를 해서는 안된다.
	- Repeatable(반복가능한) : 테스트 수행할때마다 동일한 결과를 얻어야 한다. 외부의 데이터 공급자나 concurrency(동시성?) 문제로 인해 일시적으로 오류가 발생 할수 있다.
	- Self-validating(자체 검증) : 테스트는 완전히 자동화 되어야 한다. 로그 파일에 대한 프로그래머의 해석보다는 패스(pass)또는 실패(fail)를 출력해야 한다.
	- Timely(적시에) : 이상적인 테스트는 테스트할 생산 코드를 작성하기 전에 작성해야 한다.




### Xcode의 TestNavigator
- 앱에서 테스트 타겟을 생성하고 테스트를 실행할 수 있도록 도와줌.
	- [command+6] - [New Unit Test...]
		- 자동으로 XCTestCase Class의 subClass를 생성
		- import XCTest 자동 추가.
		- setup(), tearDown(), testExample(), 


### Using XCTAssert to Test Models(with examProject: BullsEye)

```swift
//- XCAsserrt를 통한 유닛 테스트

import XCTest
@testable import BullsEye// 아래의 유닛 테스트가 BullsEye에 접근하여 진행 되도록 import

class BullsEyeTests: XCTestCase {
    
    var gameUnderTest: BullsEyeGame!
    
    override func setUp() {
        super.setUp()
        
        gameUnderTest = BullsEyeGame()
        gameUnderTest.startNewGame()// SUT(System Under Test) 를 해당 클래스 자체에서 만들게 된다.
        // setup에서 이렇게 하면 이 클래스의 어느 메서드건 SUT에 접근이 가능하다.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        super.tearDown()
        // tearDown 에서 테스트하려고 하는객체를 해제해주고 시작한다...??
        gameUnderTest = nil
//        gameUnderTest.deinit()// setUp에서는 SUT를 생성하고 tearDown에서는 이를 realese 해줘야 하는데 여기선 deinit을 접근 할 수 가 없네... arc를 통해 자동으로 될듯..
    }
    
    func testScoreIsSucessfullyCompute() {//메소드의 명명 규칙 : test로 시작하며, 그 뒤에 무엇을 테스트하는지 설명을 해준다.
        // 테스트 메소드는 3가지 섹션으로 구분 하여 구현한다.
        
        // 1. given section : 해당 메소드에서 사용할 모든 값들을 설정.
        let guess = gameUnderTest.targetValue + 5// guess는 targetValue와 비교 대상 값
        // 2. when : 테스트 중인 코드를 실행
        _ = gameUnderTest.check(guess: guess)
        
//        func check(guess: Int) -> Int {
//            let difference = guess - targetValue
//            scoreRound = 100 - difference
//            scoreTotal = scoreTotal + scoreRound
//
//            return difference
//        }
        
        print("테스트 실행됨?")
        // 3. then :  예상한 결과를 확인, 실패할 경우 출력할 메시지
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
        //Given-When-Then테스트의 구조는 클라이언트 친화적인 행동 주도적인 개발(BDD: Behavior Driven Development)에서 시작
    }
    
    func testScoreIsComputedWhenGuessLTTarget() {
        // 1. given
        let guess = gameUnderTest.targetValue - 5
        // 2. when
        _ = gameUnderTest.check(guess: guess)
        // 3. then
        XCTAssertEqual(gameUnderTest.scoreRound, 95, "Score computed from guess is wrong")
        //Test 실패, 출력 결과 -> XCTAssertEqual failed: ("105") is not equal to ("95") - Score computed from guess is wrong
        
    }
        
        
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

```		
		
		
- 테스트 방법.( 총 세가지 방법)
	1. [command+U] : 현재 테스트들을 모두 실행
	2. testClass안의 메소드 옆의 다이아 몬드 클릭 : 해당 테스트 메소드만 실행.
	3. testNavigator의 재생버튼 : 해당 테스트 메소드 실행.
		- 테스트등이 성공하면 녹색 체크와 회색 다이아몬드가 뜨며 가까이가면 테스트 성능이 표시됨.

### SUT( System Under Unit)

- 올바르게 작동하는지 테스트를 통해 확인하는 시스템.. 테스트하고 있는 객체라고 보면 될듯..










		

## XCTest(AppleDocs..)

### XCTest

- Xcode에서 지원해주는 **TDD framework.**
	- unit tests
	- performance tests
	- ui tests
- XCTest frameword은 Xcode의 테스팅 workFlow에 완벽하게 통합이 가능.
	- 테스트를 통해 해당 코드가 실행되는 동안 테스트가 실패 하거나 conditions이 만족스럽지 않다면, 해당 테스트를 기록해주기 때문에 App의 Condition이 Satisfied한지에 대해 확신을 준다.
	- 테스트를 통해 성능에 대해서 코드 블록의 성능을 평가하고, 사용자의 상호작용 flows와 App's UI의 상호작용에 대해 검증해준다.

	
### Test Cases and Test Methods	

- Test Cases
	- 관련된 테스트 메소드들의 그룹.(= class XCTestCase의 하위 클래스, 즉 XCTestCase를 상속받아 테스트 메소드의 그룹을 생성.)
- Test Methods
	- 코드의 특정 부분에 대해 테스트하는 작고 독립적인 메소드.

### TDD

- Unit Test와 TDD는 엄연히 다르다. TDD는 UnitTest를 할수 있게 하는 하나의 방법론이다.

- 실행 절차 : Red - Green - Refactor 의 형태로 진행이 된다.
- Red는 테스트가 실패하는 상태를 의미, Green은 Red에서 실패 하는 케이스에 대하여 코드의 퀄리티 상관없이 통과 가능한 코드를 만들어 내는것, Refactor는 Green의 코드의 퀄리티를 높이는 형식으로 진행이된다.

- 테스트 작성 : 로직의 중간부분을 생각하지 말고, 시작과 끝지점에 대한 고려를 통해 그것만을 테스트 한다. 
	- 우선순위는 복잡한 클래스부터, 리펙토링을 할때 가장 중요한것은 코드의 응집도와 결합도라고 했었다..
	- 버그가 있다면 그또한 테스트 케이스에 넣는다.
	- 주요 포인트가 있다면 주석 대신 테스트 코드가 더 도움이 된다.( 유지보수)

#### Unit Test 종류

- 가장 쉽게 생각할수 있는 `수학적 테스트`
- 클래스간의 값 전달을 테스트 하는 `딜리게이트 테스트`
- 컴플리션 핸들러를 갖는 메소드의 `아웃풋 테스트`

- 허지만 가장 중요한것은 의도한 값만 넣지 않고 실패하는 상황에서의 테스트들의 경우의 수를 생각해봐야 한다는 것임.

### 의존성 주입 (디펜던시 인젝션)

- 그냥 한 클래스에 외부적인 의존성을 제공한다는 의미의 그럴싸한 표현
- 테스트 할려는 클래스에서 다른 클래스를 호출하려 한다면 그 인스턴스를 생성 시부터 들고있어야 한다.(constructor injection)
- 모든 의존성은 프로토콜 객체로써 선언된다(?) 그 클래스가 필요한 오브젝트를 메소드에 담아서 우리가 원하는 클래스/ 구조체의 객체를 초기화 할떄 쉽게 전달 가능하도록 할 수 있다.
	- 이렇게 하게되면 굳이 테스트가 아니더라도 코드를 분리 시킬 수 있다는 점에서 매우 바람직한 코드구조가 되게 된다.
	- 무슨말이냐면 인스턴스 생성시에 필요한 인자들의 자료형을 프로토콜로 만드는 거임. 근데 사실상 이게 왜 의존성을 없애는건가???...???





### note
- 오역, 잘못된 설명등에 대해서 언제나 피드백을 환영합니다.

	- feedBack
		- gmail : [bobplease88@gmail.com](bobplease88@gmail.com)

