# time complexity

- 실행 시간에 대해서 측정하기 보다는 연산 횟수를 기준으로 생각해야함. 
	- 실행 시간은 하드웨어, 언어, 컴파일러 등의 영향을 받기 때문..

**Asymptotic(점진적)** 분석

- 입력되는 Data에 비례하여 시간 복잡도를 표현.
- 알고있는 Big O Notation이 이 대표적 표현 방법.
- 코드 상으로 worst / best 판단을 할 수 있는 간단한 알고리즘 복잡도 표현 방법.

------------------------

O(1) : **상수 시간 복잡도**, 입력 Data 관계 없는 시간 복잡도

```
func indexSumN(n: Int, prev: [Int], post: [Int]) -> Int{

	
	return prev[n] + post[n] // 입력 데이터의 수와 상관없이 단 한번의 연산만 실행 

}

```

O(n) : **선형 시간 복잡도**, 입력 Data가 n개일때 갖는 시간 복잡도

```


func listSum(data: [Int]) -> Int{

	var result: Int = 0
	for a in data{
	
		result += a// 이 함수에서 이 라인은 n번 실행된다.
	}

	return result
}
```

> 만약 위 함수에 다른 상수 시간 복잡 요소가 들어 있다고 하더라도 n의 시간 복잡도를 갖는 요소가 존재한다면, 시간 복잡도는 O(n)이 된다.

```
func search(data: [Int]) -> Bool{

	let target: Int = 3
	for a in data{
		
		if a == 3{
			return true
		}
	}

	return false
}
```

> 위 함수의 경우는 Best case와 Worst Case가 존재, 만약 마지막 인덱스에 Target이 있을 경우 시간 복잡도는 Worst Case로 O(n)을 갖게 된다. 


O(n^2) : **Quadratic 복잡도를 갖는 경우** 

```
func conflict(data: [Int]) -> Bool{

	var extern: Int = 0
	for extern in 0..<data.count{
		for a in data{
			if a == data[extern]{
				return true// 최악의 경우 data.count * data.count의 복잡도
			}
		}
	}
	
	return false
}

```
> 위 함수는 만약 가장 마지막에 중복된 값을 찾게 될경우, O(n^2)를 갖게 된다.


- Summery

```
시간 복잡도는 가장 많이 실행되는 라인을 기준으로 계산 되게 된다.
```
