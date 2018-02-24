# Notification

- Notificaion Center라는 타입 및 인스턴스를 이야기함.
- 싱글톤인스턴스이기때문에~ App에 단 하나의 인스턴스만 존재하져~
- VC와 VC간 데이터를 주고 받는것이 아니라 어떠한 이벤트 전달이 가능하도록 해주는 역활.
	- 이벤트 전달뿐만 아니라 이벤트를 전달해주는 역활도 한다. Delegate가 서로 연관된 ViewController간에 전달이라면 Notification은 서로 연관되있지 않다는 점에서 다른점을 보인다.

>탭바 같은 경우 5개의 탭이 존재 한다면 5개의 뷰가 대기상태임.
>
>하지만 5개의 뷰가 연관성이 있지는 않음.
>
>하지만 하나의 뷰에서 행동을 했을때, 다른 탭의 뷰에 영향을 주어야 할경우.
>
>필요한것이 바로 NotificationCenter이다..!


- 특정 이벤트가 발생 하였음을 알리기 위해 불특정 다수의 객체에게 알리기 위해 사용하는 클래스
- 어떤 객체라도 특정 이벤트가 발생했다는 알림을 받을 것이 라고 관찰자(Observer)로 등록을 해두면 노티피케이션 센터 가 모든 관찰자 객체에게 알림을 준다

---
## notification 종류

- push : server <=> OS
- local : OS <=> App
- notificationCenter : App안에서 VC<=>VC

## action 종류

![screen](https://github.com/joohopark/jhbob/blob/master/Study/image/NotificaionCenter.jpg)

- observer(수신)
- poster(발신)

> NotificationCenter에 observing을 하겠다고 등록 하는 행위임.
>
> observer 등록은 Notification Key(enum)를 Notification Center에 등록(정확하게는 NotificationCenter의 Name enum에 rawValue를 추가)함으로써 이뤄진다.
>
>Poster가 post를 보낼때에도 마찬가지로 NotificationCenter에 Notification Key를 기준으로 전송할 object를 넘겨주는 형식으로 진행된다.


## 주요 메소드

<pre>
Initializing
open class var `default`: NotificationCenter { get }

Add Observer
open func addObserver(_ observer: Any,   // 수신은 자기 자신일때 self
			selector aSelector: Selector,  // #selector 를 사용할 경우.
		name aName: NSNotification.Name?,// noti key value
				    object anObject: Any?)// 보낼게 있을 경우.
open func addObserver(forName name: NSNotification.Name?,
						object obj: Any?,  
						queue: OperationQueue?,  // 이벤트를 처리할 큐
						using block: @escaping (Notification) -> Swift.Void)   -> NSObjectProtocol
						// 클로져를 사용할 경우.



Post Notification
open func post(name aName: NSNotification.Name, //noti key value
								object anObject: Any?,  //
								userInfo aUserInfo: [AnyHashable : Any]? = nil)

Remove Observer 
open func removeObserver(_ observer: Any)// 특정 키값을 죽이거나 해당 뷰컨트롤러의 모든 옵저빙을 죽이거나 할수 있다.
</pre>

### - Exam Code

```swift
//===========Observing ViewController
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self/*누굴 등록 할건지?*/, selector: #selector(self.notifiAction(_:)), name: NSNotification.Name(rawValue: "noti"), object: nil/*poster를 지정*/)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "notiUsingClosure"),
                                               object: nil,
                                               queue: nil) { (noti) in
                                                    print("클로져 노티 왔어")
                                                let addlb: UILabel = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
                                                addlb.text = noti.object as! String
                                                self.view.addSubview(addlb)
                                                }
    }

    @objc func notifiAction(_ noti: Notification){
        
        print("notiTest")
        lb.text = noti.object as! String
    }


    deinit {
//        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"noti"), object: nil/*poster를 지정*/)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue:"notiUsingClosure"), object: nil)
    }
}

//============= poster ViewController
import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

            }

    @IBAction func didClickedBtn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"noti"), object: tf.text)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didClickedSecondBtn(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"notiUsingClosure"), object: tf.text)
//        self.navigationController?.popViewController(animated: true)
    }
    
}

```

### - 유의사항

- observ 를 통해 NotificationCenter에 noti Key를 등록 할 경우 항상 remove해줘야 한다.
	- 쌍으로 관리할것을 ... 명심..

- poster가 알림만 주고 싶을 경우 object를 nil로 해도 상관이 없다.
	- 알림과 추가하여 사용할때는 object에 넘길 값을 주거나, object에는 self UserInfo에는 넘길 값을 주면된다.

- Notification.Name은 enum 형식으로 기존에 프레임 워크가 

#### - note
<pre>
쓰레드 == iOS App 에서는 메인 큐
</pre>

