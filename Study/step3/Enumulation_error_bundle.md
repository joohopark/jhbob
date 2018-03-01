# Enumulation,
# 에러 처리,
# Data 저장.
---
---


## 열거형이란..??
- 그룹에 대한 연관된 값을 정의하고 사용가능한 타입
- rawValue(원시값)이라는 형태로 실제 값들을 부여 할 수 있다.
	- 값들은 실수, 정수, 문자열등을 넣을 수 있다.
- 열거형은 init을 정의할 수 있고, 프로토콜 준수, 연산 프로퍼티, 메소드등을 만들 수 있음.

```switch
enum <열거형 이름>{
	case <항목1>
	case <항목2>
	...
	
}

enum Planet{
	case earth, venus, mercury, neptune
}
```

### 사용 예시

```switch
var enumExam = Planet.earth
enumExam = .mercury
```


- 각 case값만 들어 갈수 있으며, 선언 후 점( . )문법을 통해 쉽게 다른 값을 설정 할수 있다.

## switch를 통한 binding

- optional bindig은 하나의 값에 대해 nil인지 some인지 확인 한다면, switch binding을 통해서 특정 enum일때 실행 가능 한 구문을 구현하여 사용할 수있다.

## enum, Associated Values

- 연관 열거형.

```switch
enum Barcode{
	case upc(Int, Int, Int, Int)
	case qrCode(String)
}

// 연관 열거형의 값 지정.
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// 연관 열거형 값 불러오기

switch productBarcode{
	case .upc(let numberSystem, let manufacturer, let product, let check):
		print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).”)
    case .qrCode(let productCode):
       print("QR code: \(productCode).")
}

// Pattern Matching
let productBarcode = Barcode.upc(8, 85909, 51226, 3)
   if case let Barcode.upc(8, companyCode, productCode, 3) =
   productBarcode
   {
	//정상 바코드 print(companyCode) print(productCode)
	}// 확인 필요.
```

## RawValues

```switch
enum ASCIIControlCharacter: Character {
             case tab = "\t"
             case lineFeed = "\n"
             case carriageReturn = "\r"
}

enum Planet: Int{
	case mercury=1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPoint: String {
	case north, south, east, west
}


//.rawValue 프로퍼티를 통해 원시값을 가져올수 있다.
let earthsOrder = Planet.earth.rawValue
print(erathsOrder)// 3 출력.
// earth는 Planet enum의 하나의 타입이고 rawValue는 enum안에서 earth의 원시값이다...

enum Planet: Int{
	case mercury=1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let possiblePlanet:Planet? = Planet(rawValue: 1)//(rawValue:값 지정으 로 인해 생성)
// 원시값 열거형에서는 초기화 함수를 통해 instance를 만들수 있다. 
// 초기화를 통해 만든 인스턴스는 옵션널 변수로 만들어 진다.
```

## 중첩 열거형

```swift
//중첩 열거형
enum Wearable {
    enum Weight: Int {
        case Light = 1
		 case Mid = 4
        case Heavy = 10
    }
    enum Armor: Int {
        case Light = 2
        case Strong = 8
        case Heavy = 20
    }
    case Helmet(weight: Weight, armor: Armor)
    case Breastplate(weight: Weight, armor: Armor)
    case Shield(weight: Weight, armor: Armor)
 }// enum안에 enum을 하나 더 선언하여 사용 가능.
```

## 열거형과 메소드

```swift
 enum Wearable {
       enum Weight: Int {
           case Light = 1
       }
       enum Armor: Int {
           case Light = 2
       }
       case Helmet(weight: Weight, armor: Armor)
       func attributes() -> (weight: Int, armor: Int) {
           switch self {
           case .Helmet(let w, let a):
               return (weight: w.rawValue * 2,
                        armor: a.rawValue * 4)
		} 
	}
}
let woodenHelmetProps = Wearable.Helmet(weight: .Light,armor: .Light).attributes()
print (woodenHelmetProps)//(2,8)
```

## 열거형 Exam 1

```swift
enum Device {	case iPad, iPhone, AppleTV, AppleWatch	func introduced() -> String {		switch self {			case .AppleTV:				return "\(self) was introduced 2006"			case .iPhone:				return "\(self) was introduced 2007"			case .iPad:				return "\(self) was introduced 2010"			case .AppleWatch:				return "\(self) was introduced 2014"		}	}}print (Device.iPhone.introduced())

//함수를 안에 선언하고 self로 불러와서 사용 가능해요.. 이건 switch & enum 사용 예시..
// enum을 통해 get set 구현이 가능함..을 알 수 있을려나?!
```

# 에러처리.

## 에러의 예외처리

- 프로그램의 오류 조건에 응답하고 오류 조건에서 복구하는 프로세스

- Swift는 런타임시 복구 가능한 오류를 던지고, 포착하고, 전파하고, 조작하는 기능을 제공함.

## 열거형의 에러 표현
- 열거형은 에러를 표현하는데 적합하기때문에 아래와 같이 사용한다.

```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}// Error는 따로 내부 구현이 없지만, 타입 추론시 Error인것을 알기위해 타입을 설정 한것임.
// Error는 프로토콜이얌.
```
- 에러는 Error 프로토콜을 준수하는 유형의 값으로 나타내고, 실제로 Error프로토콜은 비어 있으나 오류를 처리할수 있는 타입임을 나타내는 용도로 사용한다.

## 에러의 전달.

- 함수의 작성중 에러가 발생할수 있는 함수에는 매개변수 뒤에 throws 키워드를 작성하여 에러가 전달될수 있는 함수를 선언 해서 사용해야 한다. 하지만 이게 습관이 잘 안들거나 하면 잘 사용하지 않을듯... 중요.!!

```swift
//에러전달 가능성 함수
func canThrowErrors() throws -> String
//에러전달 가능성이 없는 함수
func cannotThrowErrors() -> String
```

## 에러처리.

- 함수가 에러를 throw하면 프로그램의 흐름이 변경되므로 에러 가 발생할 수있는 코드의 위치를 신속하게 식별 할 수 있어야합 니다.
- try 나 try?, try!를 사용할수 있습니다
- 발결된 에러를 처리하기 위해 do-catch 문을 사용해서 에러를 처리 합니다.

## Converting Errors to Optional Value

- 'do - catch' 기본형

```swift
do {		try 'expression '		'statements '	} catch 'pattern 1'{ 		'statements' 	} catch 'pattern 2' where 'condition'{ 		'statements' 	} 
```

```swift
func someThrowingFunction() throws -> Int {
	// ...
}

let x = try? someThrowingFunction()

let y: Int?

 do {
      y = try someThrowingFunction()
 } catch {
	  y = nil 
 }
```

# Data 저장

- 파일 저장(property list..)
	- 심플한 “파일” 저장 방법 중 하나.
	- Key,Value구조로 데이터 저장
	- userDefault는 내부에 기본적으로 존재하는 plist 파일에 싱글톤을 통해 접근하여 사용하는거였음.. 
	- xml 형태를 띄고있다.( 마크를 통해 Data를 관리하는 형태)
	- File 형태로 저장되다 보니 외부에서 Access가능(보안 취약)
- DB 저장(core Data.. map 등을 사용)
- 네트워크 사용. (결론적으론 DB지만 DB가 local에 존재하지 않는경우)


## plist의 위치

- 파일이 저장되는곳 Bundle & Documents 폴더
- Bundle은 프로젝트에 추가된 Resorce가 모인 곳
	- App이 설치 될때 같이 설치가 됨.
	- readOnly( App 구동 중에 저장할 수는 없다. 구현중에는 plist 자체에 타이핑해서 저장이 가능.)
- 프로그램이 실행되며 저장하는 파일은 Documents폴더에 저장.
	- 사용자들마다 Documents의 구성이 다를 수 밖에 없음.

- 예로 mp3를 다운받아서 들을떄와 개발중에 넣어 사용할때의 파일 위치가 다르게 된다.
- 즉! plist파일의 데이터만 불러오는 역할은 Bundle을 통해서, plist파일에 데이터를 쓰고 불러오는 역할은 Documents폴더 에 저장된 파일로! 해야한다!
- Xcode를 통해 파일을 넣는것과 코딩을 통해 저장되는것의 차이라고 보면 될듯..
- 모든 App의 샌드박스는 동일기 때문에 모든 개발시에 참고해야함.

## Plist File In Bundle
- bundle에 있는 file 불러와 사용하는 순서.
	1. 불러오기 위해 bundle에 있는 파일 Path 가져오기
	2. 사용을 위해 Path를 통해 객체로 변환, 데이터 불러오기
	3. 사용


## Bundle

- 실행코드, 이미지, 사운드, nib 파일, 프레임 워크,설정파일 등 코드와 리소스가 모여있는 file system내의 Directory
	- Xcode의 navigaion에 있는 파일들은 다 번들이라고 보면됨.
	- build pharse에 자세히 나온다..


### Plist File load for Bundle

```swift
func loadPlist(fileName:String){	//Path	let bundlePath = Bundle.main.path(forResource: fileName, ofType: "plist")// mainBundle가져와서 경로 획득	//Data	if let data = try? Data(contentsOf: URL(fileURLWithPath: bundlePath!)){	//plist의 형식이 Dictionary라면 ...
	
	let dic = try? PropertyListSerialization.propertyList(from: data, 	options: .mutableContainersAndLeaves, format: nil)
	// 파일 -> Data가져와...-> Data를 PropertyListSerialization.propertyList를 통해 Dictionary로 변경. throws 이기때문에 try 문 사용.
	print(dic)	}}
```


```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loadDataDic = loadPlistData(fileName: "Sample")
        print(loadDataDic["name"])
    }

    func loadPlistData(fileName: String) -> [String: String] {
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist"){// path 획득
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path))// 경로를 통해 url 획득하고 이를 통해 Data 객체를 생성.
                let dic = try PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)
                return dic as! [String: String]
            }catch{
                print("안돼썽..")
            }
        }
        return [:]
    }
```

#### - URL??

- URL은 로컬 파일을 참조하는 기본 방법
- 파일에서 데이터를 읽거나 파일에 데이터를 쓰는 대부분의 객체에는 파일 참조와 같이 경로 이름 대신 URL을 허용하는 메소드가 있다. 
	- URL을 통해 Data를 불러와야 하고, URL은 경로를 통해 획득 할 수 있다.


### Plist File In Document

1. Document folder Path 찾기
2. Document folder에 plist 파일이 있는지 확인
	- 만약 없다면 : bundle에 있는 파일 Document에 복사
3. Path를 통해 Data인스턴스로 변환(NSDictionary 는 Class(참조타입), Dictionary는 Struct(값 타입)이기때문에 Data 인스턴스로 변환하는 과정이 있어야 한다....!!)
4. PropertyListSerialization으로 Data를 컬렉션 데이터로 변환 
5. 컬렉션 데이터 가공 후 PropertyListSerialization로 Data 변환 파일에 다시 저장


```swift
let rootPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]// 경로를 Array로 반환하기떄문에 인덱스로 접근.. MAC OS의 경우 경로를 여럿을 가져오게 됨.그래서 배열이 반환 값임. 0번 인덱스인 이유는 하나의 반환값을 가져오기 떄문...
let fullPath:String = rootPath + "/" + fileName + ".plist"

if !FileManager.default.fileExists(atPath: fullPath)// 파일 존재 여부 확인.
{
// 파일이 없을 경우..
	if let bundlePath:String = Bundle.main.path(forResource: fileName, ofType:“plist"){		try? FileManager.default.copyItem(atPath: bundlePath, toPath: fullPath)	}// 번들에 있는 파일을 복사해서 파일을 하나 만들어 사용하겠다 라는거임..
	// XML을 코드로 쓰지 않게 하려면 이런식으로...
}
// 파일이 있을 경우..


```
