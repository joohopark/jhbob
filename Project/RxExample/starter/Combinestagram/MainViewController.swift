/*
 * Copyright (c) 2016-present Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import RxSwift
// ViewController 에서 Variable 사용하기
// BehaviorReplay를 사용해야 한다?!<-- 이친구는 RxCocoa에 있엉...

class MainViewController: UIViewController {

  @IBOutlet weak var imagePreview: UIImageView!
  @IBOutlet weak var buttonClear: UIButton!
  @IBOutlet weak var buttonSave: UIButton!
  @IBOutlet weak var itemAdd: UIBarButtonItem!
    //뷰컨트롤러가 모든 옵져버블을 dispose할때 이후로, dispose bag은 뷰컨트롤러의 소유가 된다.
    //그냥 bag에 구독을 던져놓으면(?), viewController가 할당 해제 될 때 폐기된다.
    private let disposeBag = DisposeBag()
    private let images = Variable<[UIImage]>.init([])//Variable 생성 , 이녀석은 Subject와 비슷한데 value 프로퍼티 접근을 통해서 이벤트를 발행.
    // 이친구를 통해 이벤트가 방출되니까 앞으로 이친구를 주목하면, 변경사항들을 관찰 가능하다..
    
    //4 UI 를 UX적인 사고를 통해 수정.
    // 만약 아직 아무 사진도 추가하지 않았거나, Clear버튼을 누른 직후라면, Clear이 작동하지 않게 할 수 있다.
    //    같은 상황에서 Save 버튼 역시 필요없다.
    //    빈 공간을 남기고 싶지 않다면, 홀수 개의 사진이 추가되었을 때 Save 버튼이 작동하지 않게 할 수 있다.
    //    사진을 6개까지만 추가하도록 제한할 수 있다.
    //    ViewController가 현재 선택 개수를 보여줄 수 있다.
    
  override func viewDidLoad() {
    super.viewDidLoad()

    //3
    //images가 방출하는 .next이벤트를 구독할 수 있고, 이러한 이벤트를 UIImage.collage(image:size:) 함수를 거쳐 콜라주를 만들 수 있다.
    // viewDidLoad 된 이후부터 images variable이 방출하는 이벤트를 관찰 & 구독이 가능하다.
    images.asObservable()
        .subscribe(onNext: { [weak self] photos in
            guard let preview = self?.imagePreview else { return }
            preview.image = UIImage.collage(images: photos,
                                            size: preview.frame.size)// 여기서 collage 메소드는 이미지 배열을 받아서 추가하는 애인가봄. + 버튼을 생성해주는 메소드
        }).disposed(by: disposeBag)
    
    //6
    // 5에서 만든 updateUI 버튼을 통해서 한큐에 해결하는거임..
    images.asObservable()
        .subscribe(onNext: { [weak self] photos in
            self?.updateUI(photos: photos)
        })
        .disposed(by: disposeBag)
    
  }
    
    // 5
    private func updateUI(photos: [UIImage]) {
        buttonSave.isEnabled = photos.count > 0 && photos.count % 2 == 0// 배열의 값이 짝수 이면서 사진이 하나이상이면 트루, 저장 버튼이 활성
        buttonClear.isEnabled = photos.count > 0// 배열 초기화는 사진이 하나이상일때 가능.
        itemAdd.isEnabled = photos.count < 6// 배열의 값이 6개 이상일때만 추가 가능하도록
        title = photos.count > 0 ? "\(photos.count) photos" : "Collage"//사진의 총 갯수를 바로바로 알려줄수 있어 이러면..
    }
    
  @IBAction func actionClear() {
    //2
    // Variable 초기화
    images.value = []
  }

  @IBAction func actionSave() {

  }

    
  @IBAction func actionAdd() {
    //1
    // value는 현재 [UIImage]
    // 그래서 값을 변경해주는 구문을 추가.
    // Variable 클래스는 자동적으로 자신의 value 프로퍼티에 부여한 값들에 대해 각각의 observable 시퀀스를 생성해낸다
    // 따라서 이 함수가 불릴때마다 배열에 이미지가 추가되겠져
//    images.value.append(UIImage(named: "IMG_1907.jpg")!)
    //7
    //사용자에게 사진을 선택 할 수 있도록 기존 코드 주석 처리 하고
    // 포토 뷰컨이랑 연결해준당.. pushpush babe
    // 일케 한 뒤에는 두 뷰컨을 Delegate 해야 될거 같은데
    // RxSwift에서는 (이런 그지같은 방법이 아닌) 두개의 어떠한 클래스라도 연결할 수 있는 아주 universal 한 방법이 있다. 바로 Observable이다! 어떠한 프로토콜도 정의할 필요없다. 왜냐하면 Observable은 어떤 종류의 메시지라도 자신을 구독하는 Observer에게 전달할 수 있기 때문이다.
    
    let photosViewController = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
    navigationController?.pushViewController(photosViewController, animated: true)
//    navigation 관련 동작을 구현한 코드 다음에 다음과 같은 코드를 작성한다.
    // delegate 없이도 관찰을 통해 선택된 이미지를 불러와 배열에 넣는것을 확인 할수 있음..
    photosViewController.selectedPhotos
        .subscribe(onNext: { [weak self] newImage in
            guard let images = self?.images else { return }
            images.value.append(newImage)
            }, onDisposed: {
                print("completed photo selection")
        })
        .disposed(by: disposeBag)
  }

  func showMessage(_ title: String, description: String? = nil) {
    let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
    present(alert, animated: true, completion: nil)
  }
}
