# for in, while, 반복분

## Swift for in Statement

- 내가 알던 언어 들과 다르게 Swift의 for는 일련의 값의 집합의 원소를 하나씩 꺼내어 반복이 가능.

<pre>
let intList: [Int] = [0,1,2,3,4,5]
var result = 0
for element in intList{

	result += element

}
</pre>

- 기존의 언어 처럼 어떠한 Interval을 통해 반복문을 제어해도 상관이 없다.

<pre>
//let intList: [Int] = [0,1,2,3,4,5]
var result = 0
for index in 0..<10{

	result += index

}
</pre>

- 위의 for in 문에서 index는 반복이 진행될때마다 let으로 선언되어 사용됨.

## Swift while Statement

<pre>
let someValue = true
while someValue{

	// someValue가 true일 때만 무한으로 반복

}
</pre>

- 딱히 C, C++ 의 while가 크게 다른 부분이 없다..

>>note
<pre>
이중 for in문에서 내부의 반복구문에서 외부의 시퀀스를 증가시킬때 왜 외부 루프가 증가되기 전의 시퀀스만큼만 반복되는걸까?
-> for in 구문은 반복을 진행 하기전 반복구문안에 있는 실행문들을 시퀀스에 맞게 늘어뜨려 놓고 시작 하기때문에 중간에 시퀀스가 증/감 하더라도 반복 횟수는 처음에 정해진 만큼만 진행.
</pre>
