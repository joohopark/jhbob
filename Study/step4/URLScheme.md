# URL Scheme,
# Dependency Manager,
# Meta-Type

---

## Meta-Type

- Meta- Type : 타입의 타입, Class, Structure, Enum, Protocol등의 타입들에 대한 타입을 말함.
	- 쉽게 말해 자료형들에 대한 타입.

```swift
struct S {}
class C {}
enum E {}
protocol P {}
print(type(of: S.self))
print(type(of: C.self))
print(type(of: E.self))
print(type(of: P.self))

---------------------
// 결과
S.Type
C.Type
E.Type
P.Protocol
```
- 인스턴스 < 타입 < 메타 타입, 우측으로 갈수록 좌측의 것을 포함하는 개념이라고 봐도 될것 같다.
	- 인스턴스 : 타입(혹은 자료형)을 통해 표현된 값으로 메모리에 올라가기 전이라고 보자.(타입의 객체)
	- 타입 : 스트럭쳐, 클래스, 이넘, 프로토콜과 같이 값들에 대한 도메인 값이라고 보자.(메타타입의 객체)
	- 메타 타입 : 타입에 대해서 그를 표현하는 정보를 나타내는 자료형. 

- 키워드
	- .self : 그 자신을 의미.(예로 어떤 인스턴스에 대해 self로 접근)
	- .Type : 그 스스로를 표현 할 수 있는 자료형.
- 메소드
	- type(of : ~~) : ~~의 자료형의 타입을 리턴

```swift
/***************************************************
 String.Type > String > String
 
 let str = "String"
 str : struct String 의 객체
 String : struct String 자체에 대한 참조, String 메타타입(String.Type) 의 객체.  String.self 로 접근
 String.Type : String 의 메타타입
 ***************************************************/

//let _ = Swift.NSString.init("initString")  // Error
let swiftString = Swift.String.init("initString")
let swiftStringSelf = Swift.String.self
let swiftStringType = type(of: swiftString)
let swiftStringMetatype = type(of: Swift.String.self)
let swiftStringMetatypeSelf = swiftStringMetatype.self
let swiftStringMetatypeType = type(of: swiftStringMetatype)
print(swiftString)// 인스턴스
print(swiftStringSelf)// 스트럭쳐
print(swiftStringType)// 인스턴스의 타입 -> 스트럭쳐
print(swiftStringMetatype)// String.self의 타입이니까~
print(swiftStringMetatypeSelf)// 타입 그 자신이니까~
print(swiftStringMetatypeType)// 타입의 타입

print("\n---------- [ String Types ] ----------\n")
// 메타 타입 :  데이터를 관리하기위한 정보들을 관리하는 타입..
// .Type 과 .self
let str: String = "myString"
//let str2: String.Type =
//let str2: String = String("InstanceTest")
let stringSelf: String = "myString".self// 얘는 결론적으로 인스턴스 그자체임
let stringType: String.Type  = type(of: "myString")//String.Type의 인스턴스가 스트링이 되는..그니까 스트링이라는 정보타입이 stringType의 자료형임.
let stringMetatype: String.Type.Type  = type(of: type(of: "myString"))
print(str)// 인스턴스
print(stringSelf)// 인스턴스
print(stringType)//인스턴스의 타입: 인스턴스의 타입의 자료형은 String.Type이다. String.Type == struct String
print(stringMetatype)//타입의 타입
```

- 키워드 : `is`
	- 해당 자료형이 맞는지에 대한 조건문

```swift
print("\n---------- [ Instance Type Check ] ----------\n")

let str = "StringInstance"
print(str is String)           // true, str 은 String Type 의 객체, 스트링의 객체가 맞으면 참트루
print(str == "StringInstance") // true, str 은 "StringInstance" 와 동일
print(str is String.Type)      // false
print(str is String.Type.Type) // false



print("\n---------- [ Type's Type check ] ----------\n")

print(type(of: str) is String)       // false, String is String 과 동일.. 그니까 String == String.Type을 물어본거
print(type(of: str) == String.self)  // true, str 객체의 타입은 String 그 자체, String.Type == String.Type
print(type(of: str) is String.Type)  // true, str 객체의 타입은 String.Type 의 객체 String의 타입 == String.type



print("\n---------- [ Metatype's Type check ] ----------\n")

private let meta = type(of: String.self)
print(meta is String)  // false
print(meta == String.self)  // false
print(meta == String.Type.self)  // true, String 메타타입은 String.Type
print(meta is String.Type.Type)  // true, String 메타타입은 String.Type.Type 의 객체
//============== 결과
---------- [ Instance Type Check ] ----------

true
true
false
false

---------- [ Type's Type check ] ----------

false
true
true

---------- [ Metatype's Type check ] ----------

false
false
true
true
```


## URL Scheme


```swift
// 불리는 쪽에서의 처리..
// Info.plist에서 URL types를 추가해야한다.
// Appdelegate에서 이게 불릴때 열지 말지도 결정 할 수 있다.
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        print("openURL : with options")
        print("url : ", url)
        
        if let scheme = url.scheme, let query = url.query{
            
            print("scheme: ", scheme)
            print("query: ", query)
        }
        print("sourceApplication : ", options[.sourceApplication] as! String)
        return true
    }


// 부르는 쪽에서의 콜
// URL scheme Call
        if UIApplication.shared.canOpenURL(URLScheme){// 화이트 리스트 등록..
            UIApplication.shared.open(URLScheme)
        }
```

```swift
class A {
  static func staticMethod() { print("Type Method(static func)") }// 상속이 불가.
  class func classMethod() { print("Type Method(class func)") }// 상속이 가능
  func instanceMethod() { print("instance") }
  func instanceMethodWithNumber(_ number: Int) { print("Number :", number) }
}

let aInstance = A()
type(of: aInstance).classMethod()//타입 메소드 
type(of: aInstance).instanceMethodWithNumber(aInstance)(5)//위와동

A.staticMethod()
A.classMethod()
A.instanceMethod(aInstance)()// == aInstance.instanceMethod// 이렇게 쓸수가 있네;;

let aSelf = A.self
aSelf.staticMethod()
aSelf.classMethod()
aSelf.instanceMethod(aInstance)()
aSelf.instanceMethodWithNumber(aInstance)(3)


print("\n---------- [ Custom Type ] ----------\n")

// 일반적으로 typealias 사용
// typealias log = HandyLog
typealias MyString = String
let str = MyString("MyString Value")
print(str)

// 다음 방식으로도 활용 가능. 단 제약사항 존재
let IntArrayType = Array<Int>.self   // IntArrayType: Array<Int>.Type
// initializing from a metatype value must reference 'init' explicitly
let arr = IntArrayType.init(repeating: 5, count: 3)// init은 암시적으로 안써주면 사용되지 않는다.
print(arr)

```

- 실제 사용되는 예
	- JSONDecoder decode

```swift
 open class JSONDecoder {
   func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
 }
 e.g. try JSONDecoder().decode(MyClass.self, from: data)
```

- UITableView Dynamic Cell Register

```swift
 tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
```

- UITableViewCell identifier extension

```swift
 extension UITableViewCell: TableViewCellType {
   static var identifier: String { return String(describing: self.self) }
 }
 e.g. CustomCell.identifier  -> "CustomCell"
```

- Storyboard instantiate extension

```swift
 extension UIStoryboard {
   func instantiateViewController<T>(ofType type: T.Type) -> T {
     return instantiateViewController(withIdentifier: String(describing: type)) as! T
   }
 }
```


## Dependency Manager

- cocoapods, carthage

### cocoapods 설치 및 라이브러리 추가하기.

1. brew 설치
```sh
homebrew install(MacOS 패키지 매니져)
juhobag-ui-MacBook-Pro:jhbob jooho$ brew update; brew upgrade;
```

2. gem 최신 버전 설치
```sh
juhobag-ui-MacBook-Pro:jhbob jooho$sudo gem update; gem upgrade; gem cleanup
```

3. cocoapods 설치 및 업데이트
```sh
juhobag-ui-MacBook-Pro:jhbob jooho$ sudo gem install cocoapods
juhobag-ui-MacBook-Pro:jhbob jooho$ pod repo update;
```

4. pod init
```swift
/Users/jooho/Desktop/LearnSwift/Practice_Project/CocoapodsPractice
juhobag-ui-MacBook-Pro:CocoapodsPractice jooho$ pod init
```

5. ls -al
```sh
juhobag-ui-MacBook-Pro:CocoapodsPractice jooho$ ls -al
total 8
drwxr-xr-x   5 jooho  staff   160  3 16 15:41 .
drwxr-xr-x  64 jooho  staff  2048  3 16 15:39 ..
drwxr-xr-x   7 jooho  staff   224  3 16 15:39 CocoapodsPractice
drwxr-xr-x@  5 jooho  staff   160  3 16 15:39 CocoapodsPractice.xcodeproj
-rw-r--r--   1 jooho  staff   273  3 16 15:41 Podfile
```
6. Podfile 수정(pod 추가시 버전 명시안하면 최신버전을 받아온다)
7. pod install(중간에 추가하고자할때는 인스톨 함 더 해주면 된다. 삭제도 마찬가지)
8. pod.lock에서 확인, workspace 생성 확인.
9. workspace를 통해 프로젝트 시작.

### Carthage
- 깃헙의 오픈소스의 기본적으로 태그를 가져온다.


1. brew를 통한 install
```sh
juhobag-ui-MacBook-Pro:CocoapodsPractice jooho$ brew install carthage
```
2. Cartfile 생성
```sh
// vi Cartfile
github "Alamofire/Alamofile"
//:wq
```
3. carthage update
```sh
juhobag-ui-MacBook-Pro:CarthagePractice jooho$ carthage update
// 에러 발생시 Xcode > Preferences > Locations의 xcodebuild tool을 추가해줘,.
```
4. 프로젝트의 buildPhase 수정
	- Link Binary With Libraries > 카르타고로 받은 라이브러리의 위치를 추가.
	- Run Script 한 이후에 > shell에 "/usr/local/bin/carthage copy-frameworks" 추가 "는 제거
	- input files에 $(SRCROOT)/Carthage/Build/iOS/라이브러리 선택 추가

### 장단점.

- 카르타고는 빌드 타임이 짧다
- 코코아 팟은 헤더 파일 뿐만 아니라 그 카운터 파트도 다 보이기 떄문에 학습용으로 좋다.

# Reference

- [META Type](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Types.html#//apple_ref/doc/uid/TP40014097-CH31-ID455)
- [URL Scheme Ref](https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/Introduction/Introduction.html
)

