# Factory Method Pattern
---

```swift
//: Playground - noun: a place where people can play

import UIKit

/// Factory Method Pattern은 외부 사용자(개발자)가 인스턴스의 생성 굳이 알 필요 없지만, 내부에서 로직적으로 마무리 해서 원하는 인스턴스만 리턴해주는 용도의 개발 패턴인것으로 보임.. 

protocol Person{
    func run()
}

class jhPar: Person{
    func run() {
        print("주호 달린다.")
    }
}

class youngMe: Person{
    func run() {
        print("영미 딱는다")
    }
}

enum personName{
    case jhPar, youngMe
}

class Excercise{
    func makeRun(personType: personName) -> Person {
        switch personType {
        case .jhPar:
            return jhPar()
        case .youngMe:
            return youngMe()
        }
    }
}

let gym: Excercise = Excercise()
let gymMember = gym.makeRun(personType: .jhPar)
gymMember.run()
```