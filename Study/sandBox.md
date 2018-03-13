# the SandBox Container Directory,
# Bundle Container ,
# Data Container

---

### App SandBoxing
```
Sandboxing your app is a great way to protect systems
and users by limiting the privileges of an app to its intended functionality, increasing the difficulty for malicious software
to compromise your users’ systems
```

### App SandBox?

- without App SandBox

![screen](withoutSandBox.jpg)

- with App SandBox

![screen](withSandBox.jpg)

> 하드 디스크 안에서 논리적으로 하나의 영역안에 위치하도록 하는것...

> App 하나 하나가 각각의 샌드박스에 위치한다

> 개발자에게는 기능 구현에 있어 약간의 제약을 받는다. ( 문자메시지등에 접근하는것)

## SandBox Containers

![screen]()

### Bundle Containers

- Bundle( Bundle.main.bundlePath)

>- 파일 시스템 내 하나의 디렉토리
>
>- 실행 가능 파일, Info.plist, 각종 리소스등을 하나로 그룹화 한다.. 이거시 번들
>

![screen](printBundleAndFindBundlePakage.jpg)


![screen](inBundlePakage.jpg)

- build phase

![screen](bundlePakageInPRoject)

>- 코드 사인 툴이 signing을 위해 번들 컨테이너를 불러와 code Seal을 적용한다.
>	- 누가 수정했는가..?
>
>- 정적 라이브러리 - 실행가능 파일에 통합 컴파일(1.4 이상 부터 정적 라이브러리도 쓴다)
>
>- 동적 라이브러리 및 프레임웤은 프레임 웤 디렉토리에 존재(swift는 앵간하면 이거씀)
>
>- 위의 파일들은 읽기전용, 수정이 필요한 경우 데이터컨테이너로 옮겨서 작업
>

### Data Container

- Command + Shift + 2 를 통해 연결되어있는 아이폰에 접근하여 앱의 데이터 컨테이너에 접근 할 수 있다.

![screen](DataContainerArchitecture.jpg)

- DataContainer 구조
	- Documents
	- Library
	- Temp
- 접근

```swift
NSHomeDirectory()
// DataContainer의 홈 디렉토리
```
- 사용자가 집접 디렉토리나 파일을 추가 할 수 는 없으며, Documents 같은 서브 디렉토리를 통해 관리 한다.
- 앱에서 사용하는 데이터에 따라서 시스템이 그에 맞는 디렉토리를 추가한다.
- SystemData 디렉토리는 IOS 11부터 추가된 디렉토리임.

### Data Container : Documents

- 접근

```swift
NSHomeDirectory() + "/Documents"
FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)[0]
NSSearchPathForDirectoriesInDomains(.documentDirectory , .userDomainMask, true)[0]

```


- 유저가 앱을 통해 생성한 문서나 데이터, 또는 외부 앱을 통해서 전송한 음악, pdf등의 컨텐츠를 저장
- 설정에 따라 유저가 직접 파일 추가 및 삭제 가능, 따라서 유저에 의해 삭제되거나 내용이 변경되어도 무방하고 유저가 다루는 컨텐츠와 관련이 있는 파일들만 저장되야 한다.
- Documents 디렉토리 자체는 삭제 불가, 디렉토리 삭제 시도 시 Documents 내의 디렉토리, 파일들만 일괄삭제
- 아이튠즈, 아이클라우드에 백업 가능.

|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Backup | Read, Write, Delete, Backup |
| X | Delete              |                             |

### UIFileSharingEnabled

![screen](UIFileSharingEnabled_info.jpg)

### Data Container : Documents : Inbox

- 접근 

```swift
$DocumentsPath + "Inbox"
```
- 타 앱을 통해 전송 받은 파일이 저장되는 디렉토리 (메일 앱 첨부파일 공유 등)
- 파일들을 읽거나 삭제할 수는 있지만, 새 파일을 추가 하거나 기존 파일 수정 불가.
- 타 앱에서 동일 이름의 파일을 전달 하면 덮어쓰기 대신[file-1.txt...] 식으로 번호를 자동 부여 해준당..
- iOS 9.0 부터 디렉토리가 한번 만들어진 이후로 삭제가 불가, 파일만 삭제 가능.(디렉토리를 지우면 파일만 지워진다)

- CFBundleDocumentType : 리시버 앱이 어떠한 타입의 파일을 받을 것인지를 설정

![screen](CFBundleDocumentType.jpg)

### application(_:open:options:)

- [application(_:open:options:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623112-application)

```swift
//optional 
func application(_ app: UIApplication, 
                     open url: URL, 
                  options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool{
	return true                  
}
```

### tmp/ [Bundle-ID]-Inbox

|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Delete | Read, Write, Delete |
| X | Backup              |           Backup                  |

- 접근 

```swift
NSTemporaryDirectory() + Bundle.main.bundleIdenfier! + "-Inbox"
```
- NSSupportsOpeningDocumentsInPlace의 값이 No 일때, 아이크라우드 드라이브 관련/ 파일즈 앱/ DocumentsPicker 등에서 공유되는 파일들이 **저장되는 디렉토리**..!!!

- Documents/Inbox와 달리 디렉토리 및 파일을 다루는 제약 없음.
- tmp 디렉토리의 속성을 따르므로 백업되지 않는다. (시스템에 의해 삭제될 수도 있음)



- **LSSupportsOpeningDocumentsInPlace**

![screnn]()

- 옵션 : No -> 원본 파일에 대한 사본을 Inbox 디렉토리에 생성
- 옵션 : Yes -> 원본 파일 url을 그대로 사용, 이경우에는 File Cordinator, File Presenter등을 통한 관리 필요.

### Files App

- UIFileSharingEnabled = YES
- LSSupportsOpeningDocumentsInPlace = YES

- 파일 브라우져 같은 역활을 하는 feather

![screen]()

### Library

|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Backup | Read, Write, Delete, Backup |
| X | Delete              |               |

- 접근

```swift
NSHomeDirectory() + "/Library"
FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
```
- 유저 데이터 파일 및 임시 파일을 제외한 모든 파일을 관리..
- 유저에게 노출되는것을 피하고, 앱의 기능이나 관리에 필요한 파일 저장.
- 주로 서브 디렉토리인 Application Support와 Cache를 이용하지만 커스텀 디렉토리 사용가능...?
- Preference, Cookies, Saved Application State, WebKit등 필요할떄만 시스템에서 자동 생성
- 백업 가능(아이튠, 아이클라우드)

### Library/Application Support

|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Backup, Delete | Read, Write, Delete, Backup |
| X |              |               |

- 접근

```swift
FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0]
```
- App의 기능 또는 관리를 위해 지속적으로 관리해야 되는 파일 저장
- Documents와 거의 동일한 속성을 지니며, 유저에 대한 노출 여부에 따라 위치 결정
- BundleID나 회사명 등의 서브 디렉토리를 만들어 관리...?
- coreData의 기본 저장 경로다(Ream은 Documents에 저장된다)
- 백업 가능

### Library/Caches

|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Delete | Read, Write, Delete |
| X | Backup             |   Backup            |

- 앱의 동작 속도/ 데이터 절약 등을 위해 사용하는 공간..
- 들어가는 데이터는 필요시에 쉽게 재생성, 다운로드 가능해야한다.
	- 필요시에(디스크 공간이 부족하거나, 업데이트 해야되는경우)시스템이 삭제 할 수 있다.

### Library/Caches/Snapshot

- applicationDidEnterBackground(_:) 메서드 호출 후 현재 뷰에 대한 스냅샷 생성.
- Background에서 Foreground로 넘어올때 스냅샷 이미지 사용
- Restore Application State 기능 사용 시, Suspend상태에서 종료되었던 앱이 재실행 될때 앱이 종료되지 않았다는 느낌을 받을 수 있도록 해준다.

### Hide Sensitive Data

- Cover Screen

```swift
func applicationWillResignActive(_ application: UIApplication) {
	coverView.backgroundColor = .black	window?.addSubview(coverView)
}
func applicationDidBecomeActive(_ application: UIApplication) {	if window!.contains(coverView) {	coverView.removeFromSuperview()	}}
```

- UIApplicationExitsOnSuspend
	- 이 값을 YES로 하면 Background에 가면 Suspend 없이 앱을 바로 종료
![screen]()

- ignoreSnapshotOnNextApplicationLaunch
	- 스냅샷을 쓰지 않도록 한다.

```swift

```

### Library/Preferences

|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Backup | Read, Write, Delete, Backup |
| X | Delete            |              |

- 접근
```swift
$LibraryPath + "Preferences"
```
- 앱의 설정 정보 저장
- 별도의 파일을 저장 할 수는 있지만, 직접 조작하는것은 정말 좀 그래..
- 대신 UserDefaults, Setting.bundles, CFPreference API등을 사용하면 된다..
- 백업 가능

### tmp(Temporary)


|   | Directory           | File                        |
|---|---------------------|-----------------------------|
| O | Read, Write, Delete | Read, Write, Backup |
| X | Backup           |   Backup           |

- 접근

```swift
NSTemporaryDirectory()
```
- 현재 앱 실행 중에 사용하지만 다음 앱 런칭시까지 유지할 필요 없는 임시 파일 저장
- 시스템이 주기적으로 파일을 삭제하더라도, 사용 후 필요없어진 파일은 삭제해주는 것을 권장하고 있다.
- 앱이 실행 되고 있는 동안에는 삭제 되지 않음.
- 백업되지 않음.



지원동기.. 서로가 서로에게 알고 있는 정보가 많아야 좋다..
기업 조사 좀해..
개선사항 아라보는것도 나쁘지 않아여
앱 다운로드 수
월급이 밀리지 않으려면 추상적이지만 투자금 얼마에 몇명이 있는 회사가 좋은것인가.
3단 정리 정도 하자 질문 답변을
존나 빡샜을떄 어케 넘어갔따
러닝커브가 ㅈ된다



