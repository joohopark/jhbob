
# Programmers 02

## 문제 1

### 하샤드수
- 입력 값의 각 자리수를 더해서 나눴을때 떨어지면 하샤드 수임.
<pre>
func harshad(input : Int) -> (Int,Bool)	{
        var index = 1
        while (input/10 * index) > 1 {
            index += 1
        }
        if input % index == 0{
            return (input, true)
        }
        return (input, false)
}
</pre>
 

### 콜라츠 추측    
- 입력값이 짝수면 나누기 2
- 입력값이 홀수면 곱하기 3 더하기 1
- 위의 행위를 반복하면 언젠가 1이 됨.
- 입력값이 몇번 콜라츠 추측으로 반복해야 1이되는지 구현
<pre>    
    func collatz(input: Int) -> (Int,Int){
        var resInput = input
        var returnCount = 0   
        while resInput != 1 {
            if resInput % 2 == 0{
                resInput /= 2
                returnCount += 1
            }else{
                resInput = (resInput * 3) + 1
                returnCount += 1
            }
            if returnCount == 500{
                return (input, -1)
            }
        }
        return (input, returnCount)
        
    }
</pre>

### 최소값 구하기    
- 동일 길이 정수 배열 2개를 받아
- 두 배열의 각각의 값들의 곱을 누적한 값이 가장 작도록 계산해 주는 함수 구현
- 작은 값이 나오려면 가장 작은 수들로만 덧셈을 진행하면 된다.
- 하나는 오름 차순, 하나는 내림 차순으로 정렬 한다음 순서대로 곱해서 더하면 됨.
<pre>
    /// - Parameters:
    ///   - aList: 입력 배열 A
    ///   - bList: 입력 배열 B
    /// - Returns: A, B 배열의 각 원소의 곱 중 가장 작은 값
</pre>
<pre>
    func getMinSum(aList:[ Int], bList: [Int]) -> Int {
        var aList = aList
        var bList = bList
        var resVal = 0
        for i in 0..<aList.count{// A 배열 오름 차순으로 정렬.
            for n in i+1..<aList.count{
                if aList[i] > aList[n]{
                   aList.swapAt(i, n)
                }
            }
        }
        for i in 0..<bList.count{// B 배열 내림 차순으로 정렬.
            for n in i+1..<bList.count{
                if bList[i] < bList[n]{
                    bList.swapAt(i, n)
                }
            }
        }
        for i in 0..<aList.count{
           resVal += aList[i] * bList[i]
        }
        return resVal
    }
</pre>

### 자릿수 리버스

- 예를들어 n이 12345이면 [5,4,3,2,1]을 리턴하면 됩니다.
    
    - 10씩 나눠서 해당 값이 1 이상이 아닐 경우 까지 아래를 진행,
    - 마지막 자리를 빼서 배열에 넣어줌.
    - 입력값은 방금 넣어준 값을 빼고 10을 나눠 0을 없엔다.
    - 반복
<pre>
    func digitReverse(input: Int) -> [Int] {
        var resList: [Int] = []
        var input = input
        
        while input > 0{
            resList.append(input%10)
            input = (input - (input%10))/10 
        }
        

        return resList
    }
</pre>
