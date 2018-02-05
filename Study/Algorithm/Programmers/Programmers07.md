#  N-Queens Problem

## 조건

- 가로 세로 n개의 체스판 - chess[n][n]
- n개의 여왕말을 놓을 수 있는가?
	- 여왕말은 북,북동,동,동남,남,남서,서,북서 총 8방향이 동 가능하며, 각 여왕말들이 이 방위에 겹쳐서는 안된다.

## 문제

- 2차원 [n][n] 배열의 체스 판에서 n개의 여왕말을 서로 죽이지 않고 놓으려 할때 발생 가능한 경우의 수를 구하라.

## 풀이

- 상태 공간 트리를 통해 모든 경우의 수를 노드를 통해 표현 할 수 있음.
- 상위 노드에서 이미 놓을 수 없는 경우라고 판단된 뒤에도 하위 노드들을 계속 탐색하는 것은 비효율.
	- 오답인 경우를 마주 하였을때 직전 탐색 부모 노드로 돌아가 탐색을 진행 하는것을 BackTracking 기법이라고 하며, nqueens 문제에서는 이 방법을 통해 푸는것이 효율 적임.
    - BackTracking을 판단하기 위해서는 다음 말이 놓일 경우 이 수로 인하여 하위 노드 탐색 하는것에 있어 유망한지를 판단 해야 함.
    - nqueens 문제에서는 하위 노드가 되기 위해서는 아래의 조건을 만족 해야 한다.
    
    1. 부모 level에 놓인 여왕과 같은 level에 위치하지 말것,
      - 여왕이 놓인 위치를 하나의 배열을 통해 표현 하게 된다면 1번 문제는 해결된다.
      - 어차피 문제를 푸는것에 있어 해당 level에 어느 열에 위치 할지를 알고, 부모 노드가 어떤 열에 위치 하게 되는지를 파악하는것이 가능하다면 상관이 없기 때문에 1차원 배열을 통해 문제를 해결한다.
      - list[i] = j 라면, i행 j열에 위치 한다. 라고 인식해도 상관이 없음.
    2. 부모 level에 놓인 여왕과 같은 Colum에 위치하지 말것.
      - 현재 놓일 level이 i 이고, 1번의 표기 방법을 사용한다면 현재 놓일 하위 노드의 말의 열 위치가 0~i-1 번 인덱스의 값들과 동일하게 되는지를 검색하여 같은 열인지 확인이 가능하다.
    3. 부모 level에 놓인 여왕과 대각선으로 마주 하지 말것.
    	- 대각선은 가로, 세로의 길이가 동일 한 경우이다. 부모 행 - 자식 행 == |list[부모]- list[자식]|을 통해 판단이 가능하다.
    
<pre>
//level 행에 도착해서 유망한 노드를 탐색하는 함수.

queens(level){// 파라미터: 현재 탐색 중인 노드의 위치
    
    if 현재 해당 노드에 위치하는것이 유망하지 않다?{
        return false
    }else if 현재 도착 노드가 답인 경우{
        return true
    }else{// 답이 아니면서 유망한 경우.
        자식 노드 탐색 // 이곳에서 재귀 진행.
    }
    
    }
</pre>
    

- cols와 level을 통해 노드의 탐색 위치를 표현
- level은 행으로 0~ N-1까지 표현
- 입력 값으로 level이 들어온다면 0...level-1 행까지 모든 말이 위치를 얻었음을 의미.
- cols[i] = j 라면, i행 j열에 위치



## 까다로웠던..
- 유망성 테스트를 진행 할때 재귀를 돌면서 호출된다고 생각하면서 입력값(level)을 내부에서 잘못 생각해 인덱스가 아닌 값자체로 생각하고 비교해서 하루 고민...
- 재귀를 돌기전 자식노드 탐색을 진행 함을 알면서도 level 인덱스의 값을 넣어주고 유망성 테스트에서 있지도 않는 자식 노드 값 탐색.... 이것때문에 한 2일 날린듯...






####note
<pre>
State Space Tree
트리의 hierarchy가 밑으로 내려갈수록 상위 노드에서부터 하위 노드까지의 모든 경우의 수를 표현 하는 트리.
실질적으로 구현하는것은 아니고 하나의 개념정도로 알고 넘어갈것.
구현은 2차원 배열로진행 해도 크게 상관이 없다.
0,0~n-1 의 좌표가 상단 노드
n-1,0~n-1 의 좌표가 최 하단 노드라고 생각하고 진행하면 된다.

BackTracking 
트리(상태 공간 트리)를 구성하는 각 노드들의 유망성(해를 찾을 수 있는지에 대한)을 판단 한 후 그렇지 않으면(non-promising) 그 노드의 자식노드는 탐색에서 제외.
- Recursion VS Stack 



DFS, Depth First Search
트리를 탐색함에 있어 더이상 나아갈 노드가 존재 하지 않을때까지 탐색 진행. 이후에는 이전 위치로 돌아와 다시 탐색 진행.
방향은 트리의 좌측 부터 진행한다.

</pre>

<pre>
    var cols: [Int] = [0,0,0,0,0]// N = 4, [ 2, 4, 1, 3]
    var N: Int = 4
    var colsCnt = 0

    
    func nqueen(level: Int) -> Bool {
        
        if !promissing(level: level){// 현재 탐색 노드와 부모 노드가 조건에 맞는지 확인.
            return false
        }else if level == N{// 현 탐색 노드가 조건에 맞는 노드인지 확인, 실제적으로 level은 N-1 까지만 아래 if를 타도록.
            print(cols)
            return true
        }else{//현재 탐색 노드의 부모 노드가 조건에 맞으니 현재 level의 노드에 대한 탐색.
            for n in 1...N{
                // 현재 탐색중 level의 자식에서의 열 값을 정한다 == cols 배열에 알맞는 값을 넣는다.
                cols[level+1] = n
                if nqueen(level: level+1){// 윗줄에서 인덱스에 넣은 값이 조건에 맞지 않을경우 회귀후 또 값을 변경하여 넣는다.
                    return true// 자식에 넣을 수 있고 지속 진행.
                }
            }
        }
        return false
    }
    
    
    func promissing(level: Int) -> Bool{
        
        if level != 0{
            for index in 0 ..< level{
                if cols[index]/*상위 노드*/ == cols[level]/*현재 탐색 예정 노드*/{// 상위 노드들과 열이 겹치는지 확인.
                    print("\(level) promissing Test 중 \(index)와 값이 같음.")
                    return false
                }else if level - index/*세로*/ == abs(cols[level] - cols[index]/*가로*/){//각 행의 말과 대각선에 위치하는지 확인.
                    print("\(level) promissing Test 중 \(index)행의 값과 대각을 이룸.")
                    return false
                }
            }
        }
        return true
    }
</pre>


###Reference

- [DFS](http://blog.eairship.kr/268)

