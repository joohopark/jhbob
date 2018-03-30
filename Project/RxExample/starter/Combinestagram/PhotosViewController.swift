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
import Photos
import RxSwift


/// 카메라롤에서 사진을 읽고 그것을 콜렉션뷰로 보여주는 코드가 구현되어있음.
//유저가 콜렉션뷰의 셀(사진)을 탭할 때마다 그 사진들을 방출하는 코드를 작성하는 것이 여기서 해야할 전부.

class PhotosViewController: UICollectionViewController {

  // MARK: public properties

  // MARK: private properties
  private lazy var photos = PhotosViewController.loadPhotos()
  private lazy var imageManager = PHCachingImageManager()
  
    //8
    // 사진이 추가 되었을때 바로 알수 있도록 publichSubject t사용.
    private let selectedPhotosSubject = PublishSubject<UIImage>()
//선택된 사진을 방출할 private한 PublishSubject와 subject의 observable을 방출할 selcectedPhotos 프로퍼티를 만들었다.
        //selectedPhotos 는 selectedPhotosSubject에 접근 할 수 있는 연산 프로퍼틴데..
    // 얘를 통해 subscribe가 가능함..
    var selectedPhotos:Observable<UIImage> {
        return selectedPhotosSubject.asObservable()
    }
    
  private lazy var thumbnailSize: CGSize = {
    let cellSize = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
    return CGSize(width: cellSize.width * UIScreen.main.scale,
                  height: cellSize.height * UIScreen.main.scale)
  }()

  static func loadPhotos() -> PHFetchResult<PHAsset> {
    let allPhotosOptions = PHFetchOptions()
    allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    return PHAsset.fetchAssets(with: allPhotosOptions)
  }

  // MARK: View Controller
  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // 포토 뷰컨이 사라질때 구독을 멈춪도록 한다.
    selectedPhotosSubject.onCompleted()
  }

  // MARK: UICollectionView

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let asset = photos.object(at: indexPath.item)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell

    cell.representedAssetIdentifier = asset.localIdentifier
    imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
      if cell.representedAssetIdentifier == asset.localIdentifier {
        cell.imageView.image = image
      }
    })

    return cell
  }

  /// 얘는 선택한 이미지를 가져와서 콜렉션셀을 깜박여서 탭했음을 확인할 수 있는 시각적 피드백을 준다.
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let asset = photos.object(at: indexPath.item)

    if let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell {
      cell.flash()
    }
    //해당 클로저가 잘 작동할 때 선택한 사진의 image와 info 파라미터를 줄 수 있도록 하는 것이다. 여기서 selectedPhotosSubject를 통해 .next이벤트를 방출하는 것이 해야할 일이다
    imageManager.requestImage(for: asset, targetSize: view.frame.size, contentMode: .aspectFill, options: nil, resultHandler: { [weak self] image, info in
      guard let image = image, let info = info else { return }
//        info dictionary를 통해 이미지가 썸네일인지 원본이미지인지 확인할 수 있다.
        print(info)
//        imageManager.requestImage(...)는 해당 클로저를 각각의 사이즈에 대해 한번씩 호출할 것이다.
//        원본이미지를 받았을 때는 !! 원본 이미지를 제공할 수 있도록 onNext(_)이벤트를 subject를 통해 방출한다.
        // 
        if let isThumbnail = info[PHImageResultIsDegradedKey as NSString] as? Bool, !isThumbnail {
            self?.selectedPhotosSubject.onNext(image)
        }
        
    })
  }
}
