# git flow

## A Sucessful Git Branch Model

![screen](successfulGitModel.jpg)

- Vincent Driessen's branching model...

### 기본 Branch

-  `feature` > `develop` > `release` > `hotfix` > `master`
	- Merge 순서는 `feature` ~ `master`


## 구조와 흐름

- 가장 중심이 되는 브랜치는 `master`, `branch`이며, 이 두개의 브랜치는 무조건 존재 해야 한다.
	- 이름변경이 가능하지만 되도록 변경하지 않는것을 권장.

- Merge가 된 `feature`, `release`, `hotfix`는 삭제하는것이 좋다.

### Feature 브랜치

- 브랜치가 나오는 곳 : `develop`
- 브랜치가 들어가는 곳 : `develop`
- 명명 규칙 : 기본 브랜치를 제외하고 하는것이 좋은데.. 내생각엔 `feater-*`로 정하는것이 좋을 것 같다.

>- 새로운 기능(feature)에 대해 구현하는 코드가 발생 할경우 만들어야 되는 브랜치
>
>- feature는 origin에는 반영하지 않고 개발자의 repo에만 존재하도록 한다.
>
>- `develop`은 그렇다면 개발자의 로컬 repo인 걸까..?
>
>- 개발을 쭉해.. 근데 뭔가 다음 릴리즈, 또는 향후에 추가되어야 될 기능들을 브랜치를 따서 하나의 브랜치 == 하나의 feature가 되도록 관리하는게 좋아



### Release 브랜치

- 브랜치 나오는 곳 : `develop`
- 브랜치 들어가는 곳 : `develop`, `master`
- 명명 규칙 : `release-*`

>- 새로운 제품 릴리즈를 위한 브랜치
>
>- 지금까지 한 기능(feature)를 묶어 `develop`로 머지가 된상태에서 `Release` 브랜치를 따내고, `develop`브랜치에서 다음번 릴리즈에서 사용할 기능이 추가 되게 된다.
>
>- `release` 브랜치 자체 커밋은 오로지 버그 픽스 할때만 하고, 릴리즈 가능하다 싶으면 `master` 브랜치로 넘긴다.
>
>- `master`로 머지할때 tag 명령을 통해 릴리즈 버전 명시를 해줄것.
>
>- -s, -u<key> 옵션을 통해 머지한 사람의 정보를 남기도록..
>
>- 다 했으면 다시 `develop` 브랜치로 머지해서 `release`에서 수정된 내용이 `develop`브랜치에 반영되록 한다.

## Hotfix 브랜치

- 브랜치 나오는 곳 : `master`
- 브랜치 들어가는 곳 : `develop`, `master`
- 명명 규칙 : `hotfix-*`

>- 제품에서 발생한 버그들은 전부 이 브랜치로..
>
>- 수정이 다되면 `develop`, `master`브랜치에 반영하고 `master`에는 tag를 달도록한다.
>
>- 만약 release 브랜치가 존재하면 release 브랜치에 hotfix 브랜치를 머지하여 릴리즈때 반영되도록 한다.
>

- 브랜치가 많고, 안쓰는 브랜치가 존재 할 수도 있음..
- 릴리즈와 굳이 마스터를 나눠 생각할 필요가...있나??


## Git Flow에서 브랜치관리

### 내피셜

![screen](gitFlow.jpg)

### Mac에서 GitFlow Install

```sh
  $ brew install git-flow
```

```sh
  $ git flow init 
    git 저장소를 초기화하고 master, develop 브랜치를 생성한다.

  $ git flow feature start iss51
    develop 브랜치로부터 feature/iss51 란 이름의 브랜치를 따오고 체크아웃한다.

  $ git flow feature finish iss51
    feature/iss51 브랜치를 develop 브랜치에 머지하고, 브랜치를 삭제한다.

  $ git flow feature track iss70
    이미 origin 에 존재하는 feature/iss70 브랜치를 가져오고 체크아웃한다.
```




### - Reference

- [gitFlow](https://github.com/nvie/gitflow)
- [A Successful Git Branch Model](http://nvie.com/posts/a-successful-git-branching-model/)

