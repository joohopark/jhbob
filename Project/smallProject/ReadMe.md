# Small Project [ Black Jack ]

## 18. 02. 13 v 0.8


- UserDefault
	- 사용자 정보 저장.
	- 로그인 처리

- AVFoundation , AVKit 
	- 배경음

- 기타 UI 실습

- Util Class 생성
	- 비밀번호 생성 규칙 체크 로직 메소드 추가.
		- 비밀번호 생성규칙 만들어 확인
		- ~!@#$%^&*() 특수문자 가능
		- 길이는 8개 이상
		- 연속 3번 이상 허용 X

### Black Jack Rule
	
- Double Down, 돈은 두배로 벌수 있다. 하지만 다음 카드 한번밖에 받을 수 없다. 받은 카드는 적용할지 말지 선택이 가능하다.

- BlackJack, 처음 받은 카드가 10, 11일때 돈을 1.5배로 받는다.

- 초기 카드는 2장, Max카드는 5장(총 턴수는 3)
	- 플레이어는 2장이후 Hit을 통해 카드를 뽑을 수 있음.
	- Hit을 통해 총 합이 21이 넘어가면 Burst로 베팅금을 모두 잃는다.

- J, Q, K는 10으로 계산, Ace는 1 or 11로 계산
	- Ace 카드의 경우 선택지에 대한 구현 필요

- 구현 기능 : Stay, Double Down, BalckJack, Hit
	- Hit, Btn 
	- Double Down, Btn 
	- Stay, Btn 
	- Betting, Btn 
	

	
	










