# if, switch, guard, 조건문.

## Swift if statement

<pre>
let condition: Int = 1
if condition == 1{
	
	// 조건이 참일경우 실행
}else if condition > 1{

	// 조건이 참일경우 실행
}else{

	// 위의 조건들이 모두 거짓일경우 실행
	
}
</pre>

- 사실상 다른언어의 if 문법과 다를것이 없다. 

## Swift Switch statement

<pre>
let someValue = "2"
Switch someValue{

	case "1":
		//someValue가 "1"일 경우.
	case "2",
	case "3":
		//someValue가 "2" 또는 "3"일 경우
	default:
		// case의 경우가 모두 아닐 경우.
}
</pre>

- 패턴 비교문으로 해당 값의 일정 패턴일 경우 해야 하는 로직을 수행하도록 구현한다.
- 패턴이 갖을 수 있는 모든 경우를 표현 할 수 없다면 default는 필수!

## Interval Matching

- Swift의 Switch는 단순 패턴 비교가아닌, 패턴에 구간을 설정하여 case 구성이 가능

<pre>
let someValue = 4

Switch someValue{

	case 0:
		// 0일떼
	case 1..<5:
		// 1 <= 5 일때
	case 5..<10:
		// 5 <= 10 일때
	default:
		// case 이외 범위일때.

}
</pre>

## Switch Statement using Tuple

- Swift의 Tuple을 case 조건으로 활용하여 여러 값을 동시에 체크 할 수 있음.
	- 와일드 카드(_) 를 통해서 특정 조건만 만족할 경우 로직 수행을 하도록 구현 가능.

<pre>
let hugak = ("허각", "혼자 한잔")
Switch hugak{

	case ("허각", "죽고싶단 말 밖에"):
	
	case("허각", "혼자 한잔"):
	
	case("허각", _ ):
	
	case ( _ , "Hello"):
	
	default:

}

</pre>

## Value Binding in Switch Statement

- Switch 문 내부에서 사용된 값을 임시로 사용할 수 있음.

<pre>
let someTuple = (1, 3)

Switch someTuple{
	
	case (1, let a):
		print(a)
	case (let b, 3)"
		print(b)
	case (0..<3, 2..<4):
	default:

}

</pre>

- 위의 Switch처럼 복잡시레 짤 수 도 있다. 라인 수를 많이 줄일 수 있는 방법일듯..

## add where condition in Switch Statement

- where 절을 넣어 특정 조건을 만족 시킬 경우, 진행 되도록 할 수 있다..

<pre>
let someTuple = (a, b)

Switch someTuple{

	case (a ,b) where a > b:
	case (a, b) where a < b:
	default:

}

</pre>

