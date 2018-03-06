//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by 주호박 on 2018. 2. 21..
//  Copyright © 2018년 Ray Wenderlich. All rights reserved.
//

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
