# Array,
# Set,
# Dictionary
# collection Type
---

## collection Type

하나의 값이 여러개가 모여 있는 타입을, Collection Type 라고 정의합니다 ex) Array, Set, Dictinary

---

## Array
 
#### - 정의

배열은 같은 종류의 데이터들이 순차적으로 저장되어 있습니다. 배열에 INDEX 번호를 부여해서, 값에 접근할수 있습니다.


#### - 문법

```swift
var someInts:[Int] = [Int]()
var someInts:Array<Int> = Array<Int>()

ex)
var someInts:[Int] = [1,2,3,4]// literal
someInts = [1,2]
-> someInts 배열 값 변경됨.
```

---

## set

#### - 정의 	

여러개의 데이터들이 순서 없이 들어간 형태.

- 문법<br>
 
```swift
var some:Set<Int> = Set<Int>()
a.intersection(b) : 교집합
a.symmetricDifference(b) : 교집합을 제외한 합집합
a.union(b) : 합집합
a.subtraction(b) b의 교집합을 제외한 a
```

---

## Dictionary 

- 정의 <br>
	- key : value 값을 통해서 데이터 묶음을 만듬 key, value 값을 가지고 각각의 값들에 접근할수 있다.
- 문법 <br>

```swift
var someInts:[String:Int] = Dictionary<Any>()
var someInts:[String:Int] = ["이름": "박주호", "나이", "31"]// literal

// 접근
let name = somInts["이름"]
// tip!
// key 값을 이용하여 호출 할때 String으로 ket를 호출 하기때문에 
// let NAME_KEY = "이름"
// name = somInts[NAME_KEY]
// 와같이 호출하게 되면 String으로 호출할때 오타를 통해 발생하는 에러를 줄여 줄 수 있다.
```

---