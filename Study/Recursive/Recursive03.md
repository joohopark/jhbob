# Designing Recursion

> 재귀형의 알고리즘 고려시 재귀 작성방법.

## 재귀가 무한 루프 되지 않는 조건.

1. 적어도 하나의 basecase, 순환되지 않고 종료되는 시점이 되는 case가 있어야함.
	- 함수가 반복적으로 이 함수를 호출하지 않도록 하는..
	- Recursion Case 또한 여러가지의 Case가 존재 할 수 있다.
2.  모든 case는 base case로 수렴되야함.
	- 재귀 case는 여러개 일 수 있음.

 
## 일반 함수 VS Recursion 함수

> 파라미터 사용은 implicit -> explicit 으로 사용하는것이 좋다.

```
//순차 탐색 sequential search

func search(list: [Int],total: Int, target: Int) -> Int{

	for index in 0..<total{
		if(list[index] == target){
			return index
		}
	}

	return -1
}

//Worst Case가 O(n)인 탐색 함수.
```

- implicit 파라미터 : 위의 예제 코드를 기준으로 설명할때, 배열의 시작점 즉 "index = 0"을 따로 명시하지 않아도 **암시적으로** 우리는 시작점을 알 수 잇다. 이럴때 배열의 index 0를 암시적(implicit) 파라미터라고 부를 수 있다.

- explicit 파라미터 : 배열 element의 총 갯수, 위의 예제에서는 total 변수와 같이 명시적으로 문제를 풀어 나감에 있어 전달해 주는 변수를 명시적(explicit) 파라미터라고 부른다.

> 파라미터가 많다는것이 좋은것 만은 아니기떄문에 일반 함수에서는 암시적인 파라미터 사용도 괜찮다.


> Recusion 중에 반환 값을 명시적으로 사용해야 **아래 예**와 같이 바로 반환 해줄 수 있기 떄문에 명시적인 파라미터 사용을 권장.(Recursion 함수) 

```
// 순차 탐색, 명시적 파라미터를 사용
func search(list: [Int], start: Int, end: Int, target: Int) -> {

	if (start>end){
		return -1
	}else if (target == list[start){
		return start
	}else{
		return search(data, start+1, end, target)// <-- 명시적으로 암시해줘야 되여.. 다음 호출 할때.
	}

}
```

- Recusion 구현 **기본 원칙** : Recusion을 구현할때 암시적 파라미터를 사용 할 것.

	- 가장 첫 시점에서 search를 호출 할 경우.
		- search(list: list,start: 0,end: n-1,target: target) 과 같이 호출 하게 되면, 위의 일반 search함수와 동일한 일을 첫번째 호출에서 시행한다.
		- 하지만, 두번째 Recusion 부터는 start: 1 로 호출이 되게 되는데, 일반 함수의 경우 암시적으로 시작 지점을 사용하기 떄문에 이렇게 진행 하기가 힘들다.
	- 무조건은 아님, Recursion이 반복 됨에 있어 변경 되지 않는 파라미터(예시에는 end.)는 생략해도 상관은 없다.

