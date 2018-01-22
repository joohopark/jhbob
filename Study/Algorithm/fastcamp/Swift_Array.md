
# 배열
## Level 1

시작과 끝수를 받아서 두 수 사이의 모든 수를 가지고 있는 배열 만들기
<pre>
func makeList(start: Int, end: Int) -> [Int]{
    var resListVal: [Int] = []    
    for num in start...end{
        resListVal.append(num)
    }
    return resListVal
}

print(makeList(start: 1, end: 10))
</pre>


정수 타입의 배열을 입력받아 모든 배열의 수의 합을 리턴하는 함수
<pre>
func getListSum(list: [Int]) -> Int{
    var resVal:Int = 0
    for num in list{     
      resVal += num
    }
    return resVal
}

print(getListSum(
    list: makeList(start: 1, end: 10)))
</pre>


딕셔너리에 있는 모든 데이터 출력하는 함수 >> 데이터: ["name":"joo", "age":20, "job":"Developer"]
</pre>
var data: [String : Any] = ["name":"joo", "age":20, "job":"Developer"]
func getDicDat( dic: [String: Any] ){  
    //딕셔너리들은 튜플들의 집합이라고 봐도 무방.
    for (ket, val) in dic{
        print (ket, val)
    }
}
getDicDat(dic: data)
</pre>

## Level 2
정수 타입의 배열을 받아서 배열안의 중복된 수를 모두 제거된 배열을 반환하는 함수
<pre>
func removeDuple(list: [Int]) -> [Int]{
    var resList: [Int] = []
    for num in list{   
        if !(resList.contains(num)){
            resList.append(num)
        }        
    }
    return resList
}

print(removeDuple(list: [1,2,3,4,4,4,4,4]))
</pre>

정수 배열을 입력받아, 배열의 요소 중 두 개를 선택하는 조합을 모두 포함하는 배열을 작성하세요.
>> [1, 2, 3] -> [[1, 2], [1, 3], [2, 3]]

## Level 3
정수 타입의 배열을 입력받아서 오름차순으로 정렬된 배열을 만들어 리턴하시오.(정렬 함수 사용x)   (정렬의 효율은 보지 않습니다.)
<pre>
func customSorted( list: [Int]) -> [Int]{
    var resList = list
    for index in 0..<list.count{// level
        var minIndex = 0
        for searchIndex in index+1..<list.count{
            if resList[minIndex] > resList[searchIndex]{
                resList.swapAt(minIndex, searchIndex)
                minIndex = searchIndex
            }
        }
    }
    return resList
}

print(customSorted(list: [5,3,4,10,8,9]))
</pre>

//>>에라토스테체 알고리즘을 이용하여  입력된 숫자까지의 모든 소수의 배열을 반환하는 함수
<pre>
func erastos( num: Int) -> [Int]{
    var resList = []    
    return resList
}
</pre>


