# 옵셔널

## nil이란?
- 아무것도 없는놈. null과 동일.
- 0도 " " 아님.

<pre>
class Person{
    var name:String
    init(name:String) {
        self.name = name
    }
}

let per1: Person
print(per1.name)// -> error, nil.name은 접근할 수 없는 프로퍼티..
</pre>

- 서버에서 넘겨주는 json 형태의 데이터를 받아서 출력주는 어플을 만들었는데 잠시의 네트웍 에러로 인해 값을 못받았다면??

- 개발자의 실수를 방지시키기 위한 안전 고리.

## Type Safety와 Optional Type
- nil의 속성(프로퍼티)참조, 함수(메소드)실행시 발생 가능한 상황에 대한 불안정성을 해결한다.
- 불안정성을 컴파일러 수준에서 체크하여 걸러내겠다.
- 따라서 nil을 다루는 변수를 선언하려면 (코딩 당시에서 결정 할 수 없는 값들..) optional처리를 해줘야함.
	- **optional의 Type**
		- nil일 가능성이 있음(? 사용)
		- 값이 있음(! 사용)

<pre>
public enum Optional<Wrapped> : ExpressibleByNilLiteral {
      case none
      case some(Wrapped)
      public init(_ some: Wrapped)
  }
  
// 여기서의 Wrapped는 Int가 될수도, String이 될 수 도 있다. 제너릭함.
// enum인 이유는 값이 있을경우와 값이 없을 경우에대한 enum case를 통한 판별이 가능.
// 여기서 case는 정의 된 상태를 판별하여 수행한다.
</pre>

- 위와 같이 Optional은 enum이기 때문에 optional 변수들은 초기화를 해주지 않아도 된다.

## Unwrapping
- nil이 아님에도 불구하고 아직 값을 확정할 순 없지만 이값은 확실히 값이 있을것이라는 확신이 있을때! Optional Unwrapping을 통해 일반 변수로 변경하여 사용한다.

<pre>
var d:Int = 0
var p: Int?
var b: Int!

p = 1
b = 2

print(d,p,b)
</pre>

<pre>
// 결과
0 Optional(1) 2
</pre>

- 위의 결과는 Optional변수를 출력 할때 어찌 나오는지에 대한 예제. ?는 Optional로 감싸져 있다.

<pre>
print(d,p!,b)// !를 통해 옵셔널이 아님을 보증.

//결과 
0 1 2
</pre>

- 인스턴스(UI..)의 속성을 사용하고자 할때 인스턴스 자체가 옵셔널이면 속성또한 존재하지 않을 수 있다가 되기때문에 optinal 인스턴스의 속성을 사용할때는 optional 인스턴스, 속성 둘다 optional을 해제하는 작업(Unwrapping)을 진행해야됨.


## Forced Unwrapping
- 강제 해제

<pre>
func testFuc(optionalStr:String?)
{
    if optionalStr != nil
    {
       let unwrapStr:String = optionalStr!// 괄호 안에서는 nil이 아님이 확실.
       print(unwrapStr)
	} 
}
</pre>

- optinal 변수를 사용하고자 할때 !를 통해 강제로 unwrapping

## Optional Binding
- 선택적인 optional 해제.

<pre>
func testFuc(optionalStr:String?)
{
    if let unwrapStr:String = optionalStr// 변수가 nil일 경우에는 if를 건너뜀.
    {
       print(unwrapStr)
    }
}
</pre>

- 강제 해제보다는 안전. if안의 괄호 안에서 let 상수를 통해 작업을 진행. 
- 매우 귀찬.

- Optional Binding을 해야하는 변수가 여럿일 경우
<pre>
func isNumber(inputNum1:String?, inputNum2:String?) -> Bool
{
 
    if let unwrap1 = inputNum1, let unwarp2 = inputNum2{// && ||의 개념이 아니라 , 앞의 optional 을 해제 하는 작업을 진행 후 성공시 그다음 작업 진행.
        print("\(unwrap1), \(unwarp2) 은 nil이 아님")
        return true
    }
    
    return false
}
isNumber(inputNum1: "as", inputNum2: "df")

// 결과
as, df 은 nil이 아님
</pre>

- , 와 let 키워드를 반복하여 다수개의 optional 변수를 binding 해제 할 수 있다.


## Early Exit - guard문
- if 의 else 부분이라 이해되면 편함.

<pre>
    func testFuc(optionalStr:String?)
    {
       guard let unwrapStr:String = optionalStr  else// 해제가 실패하면 아래 구문이 실행되고 함수가 종료.
       {
			return
		}
		// 해제가 성공하면 해제된 변수를 가드문 밖에서 사용이 가능하다.
       print(unwrapStr)
	 }
</pre>

- Optional binding보다 좀더 강력함.(바로 종료떄림)




### note
<pre>
옵셔널 해제 할때 let은 이름이 동일해도 상관이 없다.
만약 Class에서 속성들에 옵셔널 변수가 있을 경우.. 
사용되는 메소드에서 unwrapping을 해줘도 되고 아니면 아싸리 
init에서 비어있는 값으로 초기화 해주는것도 좋다.
-> 근데 init에 초기화를 해줘야 되는 값이 애매한 속성의 경우에는
그냥 속성 선언시 초기화 하는것이 좋다.

?를 남발할 경우 에러가 어디서 발생 되는지 모를 수 있다. 
따라서 걍 !를 적절하게 사용하여 에러 발생을 먼저 보는것도 좋다.

특정 조건을 통해 결과 인스턴스(Class 객체)를 정할 경우에는 
조건을 만족시키지 못할 경우도 있기때문에 optional로 선언하는 것이 현명하다?(->해야 한다.)
-> 만약 애매하면 리턴의 자료형또한 optional로 해주면 된다.

옵셔널 변수 ?? 대체할 값
-> 옵셔널 변수가 nil일때는 대체할 값으로 해당 값이 변경 된다.
-> 삼항연산자와 비슷한 .. : 조건 ? A : B
</pre>

