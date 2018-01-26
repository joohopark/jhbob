# preInterfaceBuilder

- 인터페이스 빌더(스토리보드) 에서 실시간 렌더링을 통해 UI를 확인 하고자 할 경우.

##Description
<pre>
When Interface Builder instantiates a class with the IB_DESIGNABLE attribute, it calls this method to let the resulting object know that it was created at design time. You can implement this method in your designable classes and use it to configure their design-time appearance. For example, you might use the method to configure a custom text control with a default string. The system does not call this method; only Interface Builder calls it.
Interface Builder waits until all objects in a graph have been created and initialized before calling this method. So if your object’s runtime configuration relies on subviews or parent views, those objects should exist by the time this method is called.
Your implementation of this method must call super at some point so that parent classes can perform their own custom setup.
</pre>

- IBDesignable Attribute를 가진 클래스가 인스턴스화 할때 시스템이 아닌 인터 페이스 빌더가 이 함수를 호출한다.
	- 인터페이스 빌더는 이 메소드를 호출 하기 전에 모든 graph(도표라는 의미로 해석) 의 인스턴스가 생성(초기화)되길 기다린다.
	- 따라서 인스턴스들의 런타임 구성이 하위 뷰, 상위 뷰가 포함 될경우 모든 뷰가 이 메서드가 호출 될때 까지 대기 타야함.(이 메서드 사용했을때 유난히 느려지는 이유가 이때문인듯..)

- 이 메서드를 통해 UI를 인터페이스 빌더에서 코드로 작성한 커스텀 UI를 바로 확인 하며 구성 가능하다.

### 예시

- custom ui를 인터페이스에서 실시간으로 확인 하고자 할떄 ..
<pre>
@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var roundButton: Bool = false {
        didSet{
            
            if roundButton {
            
                layer.cornerRadius = frame.height / 2
                
            }
            
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
        if roundButton{
            layer.cornerRadius = frame.height / 2
        }
    }
    
}
</pre>
