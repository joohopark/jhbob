# Programmers 03

## 문제 1

### 시저 암호

- 알파벳 을 배열에 넣고 입력 인덱스 만큼 뒤로 밀어 출력 해주는 함수
	- 입력된 값에 대한 대소문자 구분이 필요
	- keynum만큼 밀때 끝에 도달 할 경우 인덱스 0부터 비교 진행
<pre>
    func ceasar(data: [String], keynum: Int) -> [String]{
        
        let listInput: [String] = data
        var indexListInput: Int = 1
        
        let listUpper: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
                                   "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        let listLowwer: [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
                                    "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        var listResult: [String] = []
               
        while indexListInput <= listInput.count{     
            for a in 0 ... 25{
                if listUpper[a] == listInput[indexListInput-1]{
                    if a+keynum <= 25{
                        listResult.append(listUpper[a+keynum])
                    }else{// 현재 비교 index와 keynum의 합이 배열의 범위를 벗어날 경우
                        listResult.append(listUpper[(a+keynum)%26])//입력 배열 index+keynum이 배열의 범위를 넘지 않도록 ..
                    }
                }else if listLowwer[a] == listInput[indexListInput-1]{
                    if a+keynum <= 25{
                        listResult.append(listLowwer[a+keynum])
                    }else{
                        listResult.append(listLowwer[(a+keynum)%26])
                    }
                }
            }
            indexListInput += 1// 출력 배열에 값을 넣었으면 다음 비교를 위해 입력 배열 인덱스 + 1
            
            
        }
       return listResult
    }
    
</pre>
    
## 문제 2

- nlcm 함수를 통해 n개의 숫자가 입력되었을 때, 최소공배수를 반환해 주세요. 
	- 예를들어 [2,6,8,14] 가 입력된다면 168을 반환해 주면 됩니다.
   		- 최소 공배수 : 구하려는 수들의 곱 / 최대 공약수
		- 최대 공약수 : 구하려는 두수중 큰수를 작은수로 나누고 난 나머지가 0이 될때 나눈 수가 최대 공약수가 된다.
		- 0이 아닐경우 나눠 나온 나머지와 작은수를 나누고 안나오면 또 나머지와 작은수를 나누면 최대 공약수가 나옴.

<pre>
    func nlcm(nums:[Int]) -> Int {
        var resVal: Int = 1
        
        for n in 0 ..< nums.count{
            resVal = (nums[n]*resVal)/gcd(num1: nums[n], num2: resVal)
        }
        return resVal
    }

    func gcd(num1: Int, num2: Int) -> Int {
        // base case, 최대 공약수를 찾은 경우
        if num1 == 0{
            return num2
        }
        
        //recursive case
            return gcd(num1: num2%num1, num2: num1)

    }
</pre>

## 문제 3

- N이 주어질 때, N의 다음 큰 숫자를 찾는 nextBigNumber 함수를 완성하세요.
    - 2진수로 주어진 값을 바꿔줌. 1의 숫자를 카운트

 <pre>
    func nextBigNumber(num: Int) -> Int {
        let firTmp: Recursive = Recursive()
        let secTmp: Recursive = Recursive()
        var firCnt = 0
        var secCnt = 0
        var index = num        
        firTmp.getBinary(num: num)
        for n in firTmp.resList{
            if n == 1{
                firCnt += 1
            }
        }// 입력값의 1의 갯수 구함
        while firCnt != secCnt{
            index += 1
            secCnt = 0
            secTmp.resList = []
            secTmp.getBinary(num: index)
            for n in secTmp.resList{
                if n == 1{
                    secCnt += 1
                }
            }// index의 1의 갯수 구함
        }
        print("입력값의 2진수 : \(firTmp.resList) 비교 값(\(index))의 2진수 : \(secTmp.resList)")
        return index
        
    }
 </pre>
