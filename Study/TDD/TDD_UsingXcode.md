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
		- setup(), tearDown(), testExample(), testPerformanceExample()을 자동으로 정의 해준다.( 실 구현 X)
- 테스트 방법.
	- [command+U] : 현재 테스트들을 모두 실행
	- testClass안의 메소드 옆의 다이아 몬드 클릭 : 해당 테스트 메소드만 실행.
	- testNavigator의 재생버튼 : 해당 테스트 메소드 실행.
		- 테스트등이 성공하면 녹색 체크와 회색 다이아몬드가 뜨며 가까이가면 테스트 성능이 표시됨.

### Using XCTAssert to Test Models(with examProject: BullsEye)





		

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





### note
- 오역, 잘못된 설명등에 대해서 언제나 피드백을 환영합니다.

	- feedBack
		- gmail : [bobplease88@gmail.com](bobplease88@gmail.com)

