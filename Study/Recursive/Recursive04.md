# 동적 계획법

## 재귀는 중복 계산 결과가 발생한다...

<pre>
func fibo(input: Int) -> Int{
    if input == 1 || input == 2{
        return 1
    }
    
    return fibo(input: input-2) + fibo(input: input-1)
    
}
</pre>

- 피보나치 수열을 위와 같이 구현하여 값을 구해 낼 경우... 
	- fibo(input: 7) 이면 많은 중복된 계산을 진행 해야함..
		- fibo(input: 7) = fibo(input: 6) + fibo(input: 5)
		- fibo(input: 6) = fibo(input: 5) + fibo(input: 4)
		- ....


## Memoization

- 중복 계산 결과를 caching 해서 중복 계산을 피한다.

<pre>
func fibo(input: Int) -> Int{
    if input == 1 || input == 2{
        return 1
    }else if (list[input] > -1){
    	return list[input]
/*list가 -1로 초기화 되어있다 가정 할때 -1이 아니면 계산된 값이 들어 있다는 뜻임.*/
// 미리 계산 되어 있음 바로 사용.
    }else{
    /*아래와 같이 중간 계산 결과를 caching해둠.*/
    	list[input] = fibo(input - 2) + fibo(input-1)
    	return list[input]
    }
}
</pre>

## bottom-up

<pre>
func fibo(num: Int) -> [Int]{

	if num == 1 || num == 2{
		list[num] = 1
	}
	for num in 3 ..< list.count{
		list[num] = list[num-1] - list[num-2]
	}
	
	return list

}
</pre>

- 순차적으로 값을 구해 가는 방식
- 예로 8번째 피보나치 항을 구하려고 한다면 이미 6,7항은 구해져있는 상태임.

## Memoization vs DynamicProgramming

- 공통점
	- 순환식의 값을 계산하는 기법
	- 동적 계획법의 일종

- 차이점
	- Memoization : top - down 방식, 실제 풀어야 될 문제를 sub 형식으로 만들어 풀어도 문제가 풀린다.
	- DynamicProgramming : bottom - up 방식, 재귀에 수반되는 함수 스택, 함수 콜 등에 대한 oeverhead가 없다.
