# Classes & Structures,
# init(),
# ValueType VS ReferenceType,
# OOP
---
---

#### - 개념 <br>

OOP(Object-Oriented Programming)는 프로그래밍을 조금더 실제 세상에 가깝게, 구현하기 위한 고민에서 출발한다. 

![screen](/study/image/OOP.jpg)

- 내가 알고있는 OOP의 개념을 적당한 뇌피셜과 지금까지의 이론 정리로써 다시 해석합니다.

#### 1. 추상화(Abstraction) <br>

 사람을 코드로 구성한다 치면, 얼굴- 몸통- 사지 등으로 나누는 사람들도 있을 것이고, 이름, 나이, 성별 등으로 구성 하는 사람들이 있을 것이다.
 구현 하는 사람마다 차이는 있겠지만 생각의 출발은 하나다. 사물의 특징을 추출하고 이를 통해 코드로써 해당 사물을 구현 하는 것이다. 이것을 모델링한다고 하고 이런 모델링을 해 나가는 과정 자체를 추상화라고 한다.

#### 2. 캡슐화(Encapsulation) & 3. 은닉화(information hiding) <br> 

 프로퍼티와 메서드들을 클래스라는 하나의 코드 블록으로 묶는것(Swift에서는 Structure또한 메서드를 갖기 떄문에 Structure도 포함된다라고 볼수 있을것 같다),
 접근 제한자(Aceess Controll)을 통해 정보 은닉을 포함한다. 캡슐화의 목적은 class 라는 **type** 속에 있는 것들(변수, 함수) 들의 외부에서 접근해서 값을 변경하는것을 보호하기 위해서이다.

#### 4. 상속성(Inheritance) <br>

 Class는 Super Class와 Sub Class, 혹은 부모 Class, 자식 Class등으로 나눠 상속이라는 개념을 수용해서 객체 지향적인 프로그래밍을 지향 한다.
 말은 복잡하지만 결론적으로는 부모의 프로퍼티, 메서드 등을 상속받은 자식은 부모의 프로퍼티, 메서드등을 사용함과 동시에 자신의 프로퍼티, 메서드등을 사용 할 수 있게 된다.
 더 줄이자면 **코드의 재활용성을 높였다.** 이다.

#### 5. 다형성(Polymorphism) <br>

 영어단어가 참 어렵지만, 다형성은 두가지 특성으로 정리 할 수 있다.
 <pre>
OOP 다형성.
overriding  -  상속 받은 후에 그 함수를 재 정의 하는 것.
overloading - 같은 클래스내에서 함수등을 중복되게 만들고 다른용도로 쓰기위해 중복 정의 하는 것.
</pre>
 개발자의 편의성을 위해? 혹은 코드의 재활용성을 높이기 위한 특성으로 봐도 될것 같다.


## class와 Structure의 공통점.

Structure는 타 언어에서는 특정 데이터의 값 덩어리 정도로 이해 가능하지만, Swift에서는 그 의미가 좀 더 크다.

- 문법은 동일.

함수, 상수, 변수를 통해 프로퍼티와 메소드를 구현할 수 있다.

- 코드 블록의 기본 구조.

- init 함수를 사용.

초기화 방식은 동일하고, 프로퍼티 접근도 동일한 방식으로 한다.

<pre>
var pro1: String
var pro2: Int
init(pro1: String, pro2: Int){
	self.pro1 = pro1
	self.pro2 = pro2
}
</pre>

- 두 구조 모두 메모리에 적재되는 시점에 instance가 된다.

- Extensions 문법을 사용하여 기존 블럭에 추가 할 수 있다,.

- 프로토콜 체택이 가능.

## 차이점.

- Class는 Structure의 instance를 갖고 있을 수 있다. 하지만 Structure는 Class의 instance를 갖을 수 없다.( 프로퍼티)

- Class는 참조 타입, Structure는 값 타입

- 상속은 Class 만 가능.

- Class는 타입 캐스팅(다운 캐스팅) 이 가능, Struct는 불가.

- Structure의 프로퍼티는 var가 아니면 수정이 불가. ( Class는 let으로 해도 변경이 가능, 이유는 Class는 참조하고 있는 주소 값을 가르키고 있기 때문임.)
	- Stack에는 Structure의 값이 들어가고, Heap에는 Class의 인스턴스가 들어간다.
	- 실질적으로는 structure또한 참조타입으로 보는것이 맞지만, 값복사가 된다는 점. 그리고 값 타입과 동일하게 접근해도 이해가 되는점으로 Swift에서는 Structure를 값 타입으로 보는것이 맞다.

- Class는 Reference Counting을 통해 인스턴스의 해제를 계산한다.
	- Heap의 인스턴스가 몇개의 Reference를 갖고있는지를 카운트 해야 하고, 이를 통해 Heap에서 인스턴스를 지운다... Structure는 논외.

- Class는 deInitializer를 사용할 수 있다.
	- 메모리 해제, 소멸자.
	- 따로 호출을 하지 않아도, 메모리 해제되는 시점에 자동으로 실행됨.

- Structure의 프로퍼티는 Structure 내부 함수를 통해 변경 할 수 없다.
	- 변경하고자 할 경우에는 func에 mutating 키워드를 사용해야한다.
	



# 값 VS 참조 

## 논리적 메모리 구조

![screen](/study/image/Logical_memory.jpg)

- Stack : 지역변수, 매개 변수 영역, 인스턴스 주소
- Heap : 동적 할당 위한 영역, 인스턴스
- Data : 전역(static, class 키워드), 정적 변수 저장
- Code : 코드 저장 영역.

- Class의 결과인 인스턴스는 Stack에 인스턴스가 저장된 Heap부분의 주소가 저장
- Structure의 결과인 값은 Stack에 저장
	- 하지만 결론적으로는 Structure 또한 Int(3)과 같이 인스턴스가 되기때문에 구조체 또한 참조 타입으로 보는것이 맞지만, Swift내부에서는 값타입과 동일하게 값 복사가 되기때문에 값 타입으로 보는것이 맞아...
	- 예로 Structure는 var, let을 통해 값이 변하나 안변하나가 결정.
	- Class는 let으로 해도 주소값이 저장되기 떄문에 값이 변경 가능.

# 초기화

초기화는 클래스, 구조체, 열거형의 인스턴스를 만들기 위한 준비 과정으로 사용됨.

- 인스턴스에 설정된 속성의 초기값을 설정과 초기화하는데 목적이 있다.

- 구조체는 따로 명시하지 않는다면, 자동으로 Memberwise Initializers가 만들어 진다.

<pre>
struct Subject{
	var name: String
	var age: Int
	//init(age: Int){
	//	self.age = age
	//}
	
}

var math: Subject = Subject(name: "멤버와이즈이니셜라이저")

// 따로 init을 구현 하지 않아도 알아서 생성시에 위와 같이 처리된다.
</pre>
Memberwise Initializers : 개발자가 초기화 메서드를 정의하지 않으면 구조체는 자동으로 모든 프로퍼티를 대응하는 초기화 메서드를 제공한다.
이를 따르지 않기 위해서는 init 함수를 custom하게 만들어 주어야 한다.


- 클래스 및 구조체는 인스턴스로 만들어 질때 모든 프로퍼티는 적절한 초기값으로 모두 초기화 해줘야함.
init 함수가 끝날때, 프로퍼티의 초기값이 모두 정해져 있어야만한다.

<pre>
class Person{
	var exam: Int

}// 에러

class Person{
	var exam: Int
	init(){
		exam = 0
	}
}// 에러 아님.
</pre>


- 접근제한자 private가 붙은 프로퍼티의 경우, 생성시에 한번 값이 정해지면 이 이후에 프로퍼티에 접근하여 값을 변경 할 수 없다.

- init은 여러개를 생성 및 구현 해 놓을 수 있다. 이 경우에는 초기화 할때 어떠한 파라미터를 넘겨줄것인지를 선택하여 초기화 할 수 있다. 

- 필수적으로 모든 프로퍼티는 초기화를 시켜 줄 수 있도록 해주어야 한다.

## 초기화와 상속

- 상속을 받을 경우 부모의 프로퍼티 또한 초기화를 진행 해야함.


# 상속

- subclassing

- 단일 상속만 가능하다. 부모는 하나만 가능.

- class에서만 가능한 방법

- class의 확장 방법의 일종.

- 자식의 기능 > 부모의 기능.

- class 정의 할때, class이름 옆에 부모 class의 이름을 붙임.

- 프로토콜과 문법이 비슷 하다.
	- 프로토콜은 상속이 아니라 채택을 하여 사용하는것이고, 미리 구현될 룰을 채택 한 구조체와 클레스는 그 룰을 따라 구현해야 한다. 
	- 상속과 프로토콜을 사용할시에는 상속할 부모 클레스를 먼저 명시하고 이후에 프로토콜을 명시해야한다.(걍 룰...)

<pre>

class 자식: 부모, 프로토콜...{

// 프로퍼티
// 메소드

	init(){
	
		super.init()// <- 부모의 designated initializer
	
	}

}

</pre>	

- convenience init
	- 모든 프로퍼티를 초기화 할 필요는 없다. 하지만 하나 이상의 designated initializer를 호출해야함.
	- 상속시에는 designated initializer를 호출 해야한다.


- 지정 이니셜라이저(designated)와 편의 이니셜라이저(convenience)의 관계를 간단하게 하기 위해 Swift는 다음 세가지 규칙을 적용하였다.

	- 규칙 1. 지정 이니셜라이저는 직접 관련있는 슈퍼클래스로부터 지정 이니셜라이저를 호출해야 한다.
	- 규칙 2. 편의 이니셜라이저는 같은 클래스에서 다른 이니셜라이저 호출해야 한다.
	- 규칙 3. 편의 이니셜라이저는 지정 이니셜라이저로 끝맺어야 한다.


<pre>

	init(){
	
	}
	
	convenience init(){
		self.init()// <- 이런식으로 지정 이니셜라이져를 무조건 한번 호출 해줘야함.		// 기타 처리가 필요한 프로퍼티의 초기화에 사용하기에 편리 하당.
	}

</pre>

- required init
	- 상속시에 무조건적으로 구현해야함.
	- override 불가.( 재정의)




- init optional ( = init?())
	- 인스턴스 생성에 실패할 가능성이 있을경우 init? 을 사용한다.

	



### 구조체를 그럼 언제 써야 되나..
클래스와 구조적으로 거의 비슷하고 의미도 거의 비슷한데 언제 써영? 이라는 의구심을 해결하고자 애플의 가이드라인은 아래와 같다고 함.

- 연관된 간단한 값의 집합을 캡슐화하는 것만이 목적일 때
- 캡슐화된 값이 참조되는 것보다 복사되는 것이 합당할 때
- 구조체에 저장된 프로퍼티가 값타입이며 참조되는 것보다는 복 사되는 것이 합당할때
- 다른 타입으로부터 상속받거나 자신이 상속될 필요가 없을 때



