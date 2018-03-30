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

import Foundation
import UIKit
import Photos
import RxSwift

// 사진 저장을 쉽게 해줄 수 있는 Custom Api 제작.


class PhotoWriter {
  enum Errors: Error {
    case couldNotSavePhoto
  }
    
    // 1
    // save(_image:UIImage) -> Observable<String> 은 이미지를 받아 String 이벤트를 방출하는 Observable을 반환한다.
    // 반환되는 문자열은 뭐.. 사진이 성공적으로 저장되었따는 결과 메시지일수도 있다.
    
    static func save(_ image: UIImage) -> Observable<String> {
        return Observable.create({ observer in
            
            // 2
            // performChanges(_:completionHandler:)의 첫 번째 클로저 파라미터에서 제공된 이미지를 통해 콜라주된 사진을 생성
            // 두 번째 클로저 파라미터에서 assetID 또는 .error 이벤트를 방출하게 될 것이다.
            var savedAssetId: String?
            PHPhotoLibrary.shared().performChanges({
                
                // 3
                let request = PHAssetChangeRequest.creationRequestForAsset(from: image)// image를 포토 라이브러리 에셋에 추가
                savedAssetId = request.placeholderForCreatedAsset?.localIdentifier//
            }, completionHandler: { success, error in
                
                // 4
                // 여기서는 GCD 메인에서 해당 처리를 해주는것에 주목해도 좋을 것 같다.
                DispatchQueue.main.async {
                    if success, let id = savedAssetId {
                        observer.onNext(id)// 저장된 이미지의 에셋 아이디를 방출.
                        observer.onCompleted()// 저장 완료 후 .completed 이벤트 방출
                    } else {
                        observer.onError(error ?? Errors.couldNotSavePhoto)// 아니면 에러
                    }
                }
            })
            
            // 5
            // 디스포즈를 리턴.
            //Disposables.create() 얘는 아무것도 안하는 걍 컴플릿 같은느낌의 이벤트인것 같다.
            // 이거는 뭔지 햇갈린다. 일단은
            //static func create(_ subscribe: @escaping (AnyObserver<String>) -> Disposable) -> Observable<String>
            // .create의 리턴 값이다.
            // 그니까 save라는 함수는  크리에잇의 반환인  Observable<String>을 리턴하고 이 Observable<String>은 디스포즈 를 리턴하는데 이게 암것도 안하는거지..
            // 하 뭘 이렇게 만들었냐... 진심.
            return Disposables.create()
        })
    }

}
