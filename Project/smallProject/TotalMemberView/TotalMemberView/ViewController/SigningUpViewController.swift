//
//  SigningUpViewController.swift
//  TotalMemberView
//
//  Created by 주호박 on 2018. 2. 24..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

let noti = NotificationCenter.default
let userDefault = UserDefaults.standard
//let listLBString: [String] = ["Name", "Age", "Gender", "PassWord"]
class SigningUpViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var genderTF: UITextField!
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var rePwTF: UITextField!
    
    /// post Notification & set UserDefault by key such as UserList.
    /// only send To prev View occur Evnet .... Using Notification.
    /// - Parameter sender: touchup Inside Btn,,.,
    @IBAction func didClickedJoinBtn(_ sender: UIButton){

        let name: String = nameTF.text!
        let age: String = ageTF.text!
        let gender: String = genderTF.text!
        let pw: String = pwTF.text!
        
//        nameTF.becomeFirstResponder()
        
        if let tempList = userDefault.array(forKey: "UserList") as? [[String:String]]{
            postDataList = tempList
        }else{
            postDataList = []
        }

        //스토리 보드의 폐혜인가... 반복문으로 처리하는 방법이...있을거 같은데...
        userData.updateValue(name , forKey: "Name")
        userData.updateValue(age , forKey: "Age")
        userData.updateValue(gender , forKey: "Gender")
        userData.updateValue(pw , forKey: "PassWord")
        postDataList.append(userData)

        print(postDataList)
        userDefault.set(postDataList, forKey: "UserList")
        noti.post(name: NSNotification.Name(rawValue: "member"),object: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    

    var userData: [String: String] = [:]
    var postDataList: [[String: String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noti.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil)// keyBoard가 보이면 Noti를 받음.
        { (noti) in
            if let keyboardFrame  = noti.userInfo![UIKeyboardFrameEndUserInfoKey] as? CGRect{//UIKeyboardFrameEndUserInfoKey는 화면에 나타나는 키보드의 CGRect값을 NSValue? 로반환 해준다고 한다.. 이걸 타입 캐스팅 해서 사용.
                self.scrollView.contentOffset = CGPoint(x: 0, y: keyboardFrame.size.height)// 컨텐츠뷰의 옵셋이 어디부터 시작할지 결정하는건데 이걸 키보드 크기만큼 내려서 사용하겠다는 뜻
            }
        }
        noti.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil)// keyboard가 사라지면 noti를 받음. 다시 스크롤 사이즈를 ㅂ
        { (noti) in
            self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }

    }

    
}
