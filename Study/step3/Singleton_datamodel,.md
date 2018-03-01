# Singleton Pattern,
# DataModelling
---
---

## Singleton..?

- 싱글톤 이란? 어플리케이션 전 영역의 걸쳐 하나의 클래스의 단 하나의 인스턴스만(객체)을 생성하는 것을 싱글톤 패턴이라고 함.

- 사용이유 : 어플리케이션 내부에서 유일하게 하나만 필요한 객 체에서 사용(셋팅, 데이터 등)

- 클래스 메소드로 객체를 만들며 static을 이용해서 단 1개의 인스턴스만 만들고, 이를 App내에서 공유하는 객체로써 사용이 가능하다.

```swift
class SingletonClass {
    // MARK: Shared Instance
    static var sharedInstance:SingletonClass = SingletonClass()
    //외부에서 싱글톤인스턴스를 사용하려면 sharedInstance에 접근해서 사용한다.
    
    // Can't init is singleton
    private init()
    {
		//초기화가 필요하면 private로 생성 
	 }
}
```

## 파일 위치 

![screen](AppFileSystem.jpg)

- 파일이 저장되는곳 Bundle & Documents 폴더
- Bundle은 프로젝트에 추가된 Resorce가 모인 곳
- 프로그램이 실행되며 저장하는 파일은 Documents폴더에 저장 된다. 
- **즉, Plist파일의 데이터를 쓰고 불러오는 역할은 Documents폴더에 저장된 파일로 사용한다, 에초에 Bundle에 Plist를 저장하면, app load 이후 다시 write할수 없다.**

## Singleton Pattern

- delegate와 같은 하나의 개발 디자인 패턴 방법론
- 사용하는 이유..?
	1. App의 전 영역에서 `하나의 클래스`의 `하나의 인스턴스`만을 존재하게 해야 할 경우
		- 모든 인스턴스에서 접근해야되는 프로퍼티, 메서드가 필요할때 싱글턴 패턴을 통해 싱글턴 인스턴스를 생성하고, 이를 통해 데이터 load, convert해서 사용하기 위해서.. 
		- 셋팅 파일 같이 한번 적용되면 App의 모든 영역에 적용되도록 해야 할때..

- 주의 사항
	- Singleton은 static `인스턴스` 이기떄문에, 한번 생성되면 App이 죽을떄까지 메모리에 살아있다. 많은 Singleton을 사용한다면 당연히 메모리 부하..

#### - sington Exam

```swift
struct test {
    var x: Int = 0
    // test의 shardSingleton 을 통해서 test에 정의한 모든 매서드, 변수들을 계속 사용할수 있다.
    static var shardSingleton: test = test()
    private init() {
    }
}

var y = test.shardSingleton
test.shardSingleton.x = 100// App의 모든 영역에 영향을 미칠수 있기 떄문에 이런식의 사용은 옳지 않다.. 확인용도..
var a = test.shardSingleton.x
var b = test.shardSingleton.x

print(a, b) // 100, 100 

// SingleTon Pattern을 사용하여 데이터를 공유하고자 할때에는,
// 원본 데이터에 대해서는 private를 하고 get을 통해 외부에서 사용하게끔 하도록 하는게 바람직..
```

## 알아두면 좋은.. framework singleton

```swift
//스크린 정보를 가지고 있는 객체
let screen = UIScreen.main 

//사용자 정보를 저장하는 객체
let data = UserDefaults.standard

//어플리케이션 객체
let app = UIApplication.shared

//파일 시스템 정보를 가지고 있는 객에
let fileManager = FileManager.default

//번들 파일에 접근하는 객체
let bundle = Bundle.main
```

## Data Modelling..

![screen](dataFlow.jpg)

- 서버나 데이터베이스에서 가져온 데이터를 바로 사용하지 않고 데이터 모델을 만들어서 사용
	- 이렇게 서버나,데이터 베이스 에서 넘어온 값은 Dictionanry OR Array 또는 다른 형태로 넘어오는데, 이 데이터를 수정, 재사용이 `편하게` 만들어주기 위한 목적으로 데이터 모델을 사용. 
- Struct로 데이터 모델을 만들어 사용한다.(데이터의 경우 참조형보다는 값 복사형 타입이 좋기때문)

## DataModel을 사용해야 하는 이유.

- 현업에서 사용할 json 형식의 데이터는 **복잡한 구조의 Collection Type을 주로 사용**하게 되며, 매번 사 용할때마다 데이터를 끄집어 내기위해 Array & Dictionary instance를 만들어야 한다. (사용 편의성)
- Dictionary의 데이터는 key값을 통해 데이터에 접근 한다. String type인 key값은 다양한 곳에서 사용하게 되면 오타의 위험성이 커진다. (안정성)
- 데이터중 Dictionary의 key값 변경시 코드내 사용된 모든곳을 찾아서 직접 바꿔줘야 한다. (수정 용의)

## How to Make Data Model

- Data 하나당 Property 하나로 매칭..
- 필수 데이터와 기타 데이터를 `접근제한자`로 구분.
- 데이터 구조 단순화 작업
- 가공이 필요한 데이터 만들기.

## exam ..

- 로그인 데이터 
	1. 사용자 ID
	2. 비밀번호
	3. 이메일
	4. 추가 정보 : 생년월일, 성별,

- dummy Data

```swift

["userID":"Park",“userPW":"1q2w3e4r%T","email":"bobplease88@gmail.com",
"birthday":"1988/03/31",
"gender":"1"]
```

- 프로퍼티 매칭

| | keytype | valuetype |
|:--------|:--------:|--------:|
| **userID** | String | String |
| **userPW** | String | String |
| **email** | String | String |
| birthday | String | String |
| gender | String | Int |




- Struct 만들기

```swift
struct UserModel{
	var userID: String
	var userPW: String
	var email: String
	var birthDay: String?
	var gender: gender
	
	init?(dataDic:[String: Any]){
		// 필수 항목은 guard let으로..
		guard let userID = dataDic["userID"] as? String else{ return }
		guard let pw = dataDic["userPW"] as? String else{ return }
		guard let email = dataDic["email"] as? String else{ return }
		self.userID = userID
		self.userPW = pw
		self.email = email
	
		// 옵셔널 항목
		self.birthDay = dataDic["birthday"] as? String
		
		if let gender = dataDic["gender"] as? Int,
		(gender == 1 || gender == 2){
			self.gender = gender
		}
	}
}

```





