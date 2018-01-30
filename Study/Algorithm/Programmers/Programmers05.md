# Programmers 05

## 문제 1

### Hanoi의 탑

**풀이..**

- N개의 원판이 있고, 3개의 기둥이 존재함.
	- 기둥이 1, 2, 3 세개가 있고 n개의 원판은 1의 기둥에 있음.
	- 가장 마지막의 원판을 제외한 나머지를 2번 기둥에 옮긴다( n-1개의 이동)
	- 1번 기둥에 남은 원판 하나를 3번 기둥으로 옮긴다.
	- 2번 기둥에 있는 놈을 3번 기둥으로 옮긴다.  
- 2^N-1 번의 과정을 통해 1번 기둥에 순차적으로 쌓여있는 원판을 3번 기둥으로 순차적으로 옮길것.
- 단, 한 번에 원판을 하나씩 이동시킬 수 있고, 큰 원판을 작은 원판 위에 쌓을 수 없습니다.

- 재귀로 풀면 간단하게 풀린다는 힌트만 갖고 시작한 풀이..
- 처음에는 기둥에 집중하는 바람에( 어떻게 코드로 기둥을 표현하고 원판의 크기를 표현하는가..?) 정확하게 본질 파악 못함;
	- 원판의 갯수에 집중하고 n-1번 이동해야 됨을 재귀로 표현(basecase는 n이 1이 되었을때)
	- 2번기둥은 임시 기둥으로 1에서 3으로 옮기기 위해 필요한 기둥이라고 생각.
	- 각 기둥마다 hanoi 함수에 n-1~1 까지 재귀하면 이동시키기가 가능.


<pre>
    var hanoiList: [[Int]] = []
    func hanoi(target: Int, from: Int, to: Int, tmp: Int) -> [[Int]]{
        
        if target <= 1 {
            print("\(from) -> \(to)")// 1번 기둥의 원판이 마지막 원판만 남았을 경우
            hanoiList.append([from,to])
            return hanoiList
        }else{
            hanoi(target: target-1, from: from, to: tmp, tmp: to)//원판을 첨에 1-> 2 기둥으로 옮기는 과정 n-1개 옮기기..
            print("\(from) -> \(to)")
            hanoiList.append([from,to])
            hanoi(target: target-1, from: tmp, to: to, tmp: from)//원판을 2-> 3으로 옮기는 과정 n-1개 옮기기.
            
            return []
        }
        
    }
    
pro5.hanoi(target: 3, from: 1, to: 3, tmp: 2)
print(pro5.hanoiList)
</pre>


####결과

<pre>
1 -> 3
1 -> 2
3 -> 2
1 -> 3
2 -> 1
2 -> 3
1 -> 3
[[1, 3], [1, 2], [3, 2], [1, 3], [2, 1], [2, 3], [1, 3]]
</pre>
