# Counting cells in a blob

## 목적
- 입력 받은 좌표의 셀이 blob인지 아닌지를 판단하고 인근 blob 셀들의 갯수를 넘겨서 결과를 알려주도록 할 수 있어야 함.

>> blob : 근접(위, 아래, 왼, 오른, 대각)한 곳에 동일한 이미지 픽셀(여기서는 셀)이 있는경우.

- 얼핏 보면 간단해 보이지만 blob이 되는 조건을 판단하기 위해서는 연결된 blob의 좌표들을 탐색하고, 이를 카운팅 해내야 되기때문에 반복 탐색작업이 복잡함..

## 조건

- image cell
- background cell

- 입력
	- 2차원 배열, 확인 할 좌표.

- 결과
	- blob이 아닐 경우 0, blob일 경우 인근 셀들의 숫자.

	
## Recursive Thinking

- Base Case
	- 입력 받은 좌표가 image cell이 아닌경우. -> 0을 반환
- Recursive Case
	- 입력 받은 좌표가 image cell인 경우 -> cell을 1로 변환. counter + 1
	- 인접한 cell이 갖고있는 blob의 갯수를 counter에 추가. 
	- 추가되는 cell은 image cell이 어야 되고, background cell과 이미 카운트된 cell들은 추가되지 않는다.

- 2차원 배열을 넘어가는 좌표를 탐색하려고 할경우.
- 이미 카운트 되었거나, image cell이 아닌 경우.

- image cell일 경우에는 카운트 후에 cell의 값을 변경.
- 인근의 셀들이 blob이 될 수 있는지를 확인 하고 카운트에 추가.


<pre>
//: Playground - noun: a place where people can play

import UIKit


let background = 0
let image = 1
let counted = 2

let n = 8
var searchList: [[Int]] =
    [[0,0,0,0,0,0,0,1],
   [0,1,0,0,1,1,0,1],
   [0,1,0,1,0,0,0,1],
   [0,1,0,0,1,1,0,0],
   [0,1,0,1,1,0,1,1],
   [0,1,0,0,1,1,0,1],
   [0,0,0,1,0,0,0,1],
   [0,1,1,1,0,1,0,0]]




func countCells(x: Int, y: Int) -> Int{

    if (x<0 || x>=n || y<0 || y>=n){// 탐색 영역을 벗어 날 경우
        return 0
    }else if (searchList[x][y] != image){//탐색 셀의 값이 image가 아닐경우.
        return 0
    }else{// 탐색 셀이 image일 경우.
        searchList[x][y] = counted
        return 1 +//현재 입력 좌표가 image 일경우
        countCells(x: x-1, y: y+1) +// 북서
        countCells(x: x, y: y+1) +// 북
        countCells(x: x+1, y: y+1) +//북동
        countCells(x: x+1, y: y) +//동
        countCells(x: x+1, y: y-1) +//동남
        countCells(x: x, y: y-1) +//남
        countCells(x: x-1, y: y-1) +//남서
        countCells(x: x-1, y: y) //서
    }// 재귀를 통해 인접한 image 셀들의 갯수를 알아내서 반환
    
}

print(searchList)
print(countCells(x: 1, y: 1))
print(searchList)
</pre>

- 결과
<pre>
[[0, 0, 0, 0, 0, 0, 0, 1], 
[0, 1, 0, 0, 1, 1, 0, 1], 
[0, 1, 0, 1, 0, 0, 0, 1], 
[0, 1, 0, 0, 1, 1, 0, 0], 
[0, 1, 0, 1, 1, 0, 1, 1], 
[0, 1, 0, 0, 1, 1, 0, 1], 
[0, 0, 0, 1, 0, 0, 0, 1], 
[0, 1, 1, 1, 0, 1, 0, 0]]

5
[[0, 0, 0, 0, 0, 0, 0, 1], 
[0, 2, 0, 0, 1, 1, 0, 1], 
[0, 2, 0, 1, 0, 0, 0, 1], 
[0, 2, 0, 0, 1, 1, 0, 0], 
[0, 2, 0, 1, 1, 0, 1, 1], 
[0, 2, 0, 0, 1, 1, 0, 1], 
[0, 0, 0, 1, 0, 0, 0, 1], 
[0, 1, 1, 1, 0, 1, 0, 0]]
</pre>

