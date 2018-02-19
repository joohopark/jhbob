//
//  SignInViewController.swift
//  BlackJack
//
//  Created by 주호박 on 2018. 2. 12..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    
    var tFView: UIView!
    var lBView:UIView!
    var bTnView: UIView!
    
    var titleLB: UILabel!
    
    var joinBtn: UIButton!
    var exitBtn: UIButton!
    var checkPWBtn: UIButton!
    
    var closureView: UIView!
    var closureBtn: UIButton!
    var isCollectPW: Bool = false
    var isJoinPossible: Bool = true
    var userList:[[String: String]]!
    
    var listTF:[UITextField] = []
    
    let listLBStr: [String] = ["Name" , "ID", "PW" , "RePW","Address", "Gender", "Money"]
    var pwTag: Int?
    var repwTag: Int?
    var userData: [String: String] = [:]
//    let util: Util!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLB = UILabel(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 50))
        titleLB.text = "New Challenger Infomation"
        titleLB.font = UIFont.systemFont(ofSize: 25)
        titleLB.textAlignment = .center
        view.addSubview(titleLB)
        
        createUI()
        setUIFrame()
        createLBandTF()

        createBtn()
        
    }

    func createBtn(){
        checkPWBtn = {
            closureBtn = UIButton()
            closureBtn.frame = CGRect(x: 100,
                                      y: 5,
                                      width: 80,
                                      height: 50)
            closureBtn.setTitle("CheckPW", for: .normal)
            closureBtn.addTarget(self, action: #selector(didClickedCheckPW(_:)), for: .touchUpInside)
            bTnView.addSubview(closureBtn)
            return closureBtn
        }()
        joinBtn = {
            closureBtn = UIButton()
            closureBtn.frame = CGRect(x: view.frame.size.width-70,
                                      y: 5,
                                      width: 50,
                                      height: 50)
            closureBtn.setTitle("Join", for: .normal)
            closureBtn.addTarget(self, action: #selector(didClickedJoinBtn(_:)), for: .touchUpInside)
            bTnView.addSubview(closureBtn)
            return closureBtn
        }()
        exitBtn = {
            closureBtn = UIButton()
            closureBtn.frame = CGRect(x: 10,
                                      y: 5,
                                      width: 70,
                                      height: 50)
            closureBtn.setTitle("<Back", for: .normal)
            closureBtn.addTarget(self, action: #selector(didClickedExitBtn(_:)), for: .touchUpInside)
            bTnView.addSubview(closureBtn)
            return closureBtn
        }()
    }
    
    func createLBandTF(){
        for n in 0..<listLBStr.count{
            let lB = UILabel()
            lB.frame = CGRect(x: 0, y: Int(lBView.frame.size.height) / listLBStr.count * n,
                              width: Int(lBView.frame.size.width),
                              height: Int(lBView.frame.size.height) / listLBStr.count)
            
            lB.text = listLBStr[n]
            lB.textAlignment = .center
            lB.tag = n
            lBView.addSubview(lB)
            
            let tF = UITextField()
            tF.frame = CGRect(x: 0,
                              y: Int(tFView.frame.size.height) / listLBStr.count * n,
                              width: Int(tFView.frame.size.width),
                              height: Int(tFView.frame.size.height) / listLBStr.count)
            tF.tag = n
            tF.layer.borderWidth = 1
            if listLBStr[n] == "PW" || listLBStr[n] == "RePW"{
                tF.placeholder = " Input Your \(listLBStr[n])"
                tF.isSecureTextEntry = true
                if listLBStr[n] == "PW"{
                    pwTag = n
                }else if listLBStr[n] == "RePW"{
                    repwTag = n
                }
            }else if listLBStr[n] == "Money"{
                tF.placeholder = " Set Your Start \(listLBStr[n])"
            }else{
                tF.placeholder = " Input Your \(listLBStr[n])"
            }
            

            listTF.append(tF)
            tFView.addSubview(tF)
        }
    }
    
    // 기억을 더듬더듬...
    // UI 생성시 클로져를 사용하면 관리하기 더 좋았었던거 같기도 하고...
    func createUI(){
        tFView = {
            closureView = UIView()
//            closureView.backgroundColor = .red
            self.view.addSubview(closureView)
            return closureView
        }()
        
        lBView = {
            closureView = UIView()
//            closureView.backgroundColor = .blue
            self.view.addSubview(closureView)
            return closureView
        }()
        
        bTnView = {
            closureView = UIView()
            self.view.addSubview(closureView)
            closureView.backgroundColor = .black
            return closureView
        }()

}


    
    @objc func didClickedCheckPW(_ sender: UIButton) {

        
        guard let pw = pwTag, let repw = repwTag else{
            return
        }
        let util = Util()
        util.passwordVerify(pw: listTF[pw].text!)

        if listTF[pw].text == listTF[repw].text && listTF[pw].text != ""{
            if util.isIncludeLowerChar && util.isIncludeSpecialChar && util.isIncludeUpperrChar{
                alertActionAtCollect()
            }else{
                alertActionAtNotCollect("verify")
            }
        }else{
            alertActionAtNotCollect("collect")
        }
    }
    
    func alertActionAtNotCollect(_ check: String){
        guard let pw = pwTag, let repw = repwTag else{
            return
        }
        let alert = UIAlertController(title: "도전자등록" , message: "비밀번호 확인 실패", preferredStyle: .alert)
        let alert2 = UIAlertController(title: "도전자등록", message: "비밀번호는 대소문자, 특수문자 포함한 8글자 이상이어야 함.", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "재입력", style: .default) { (action) in
            
            for n in 0..<self.listTF.count {
                if self.listTF[n].tag == pw || self.listTF[n].tag == repw{
                    self.listTF[n].text = ""
                }
            }
            
        }
        
        
        if check == "collect"{
            alert.addAction(action1)
            self.present(alert, animated: true, completion: nil)
        }else if check == "verify"{
            alert2.addAction(action1)
            self.present(alert2, animated: true, completion: nil)
        }
        
    }
    
    func alertActionAtCollect(){
        let alert = UIAlertController(title: "도전자등록" , message: "비밀번호 확인 완료", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .default) { (action) in
            self.isCollectPW = true
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
    func alertActionAtJoin(){
        guard let pw = pwTag, let repw = repwTag else{
            return
        }
        
        let alert = UIAlertController(title: "도전자등록" , message: "비밀번호체크를 안했거나, PW,RePW 불일치,혹시 정보 다입력하시긴 함??", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .default) { (action) in
            for n in 0..<self.listTF.count {
                if self.listTF[n].tag == pw || self.listTF[n].tag == repw{
                    self.listTF[n].text = ""
                }
            }
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }

    
    @objc func didClickedExitBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func didClickedJoinBtn(_ sender: Any) {
        // userdefault 이용 할라면 ~
        // 기존꺼 불러와~
        // 잘 불러와지는 지 확인해~
        // 기존꺼 모양 대로 만들어줘 ~
        // set해 ~
        
        if isCollectPW && isJoinPossible{
            if let tempList = UserDefaults.standard.array(forKey: "UserList") as? [[String:String]]{//메소드 리턴이 Any임 + 등록자가 존재하는지 확인 있으면 불러옴.
                userList = tempList
            }else{
                userList = []// 등록자 없거나 다운캐스팅 실패하면 배열 초기화.
            }
            
            for n in 0..<listTF.count{
                userData.updateValue(listTF[n].text!, forKey: listLBStr[n])
            }
        
            userList.append(userData)
            print(userList)
            UserDefaults.standard.set(userList, forKey: "UserList")
            alertActionAtJoinSucess()
        }else{
            alertActionAtJoin()
        }
    }
    
    func alertActionAtJoinSucess(){
        let alert = UIAlertController(title: "도전자등록" , message: "성공적으로 등록", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .default) { (action) in
          self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setUIFrame(){
        let margin = 10
        lBView.frame = CGRect(x: 0, y: Int(titleLB.frame.size.height)+margin,
                              width: Int(view.frame.size.width/4),
                              height: Int(view.frame.size.height-100))
        tFView.frame = CGRect(x: Int(lBView.frame.size.width), y: Int(titleLB.frame.size.height)+margin,
                              width: Int((view.frame.size.width/4)*3),
                              height: Int(view.frame.size.height-100))
        bTnView.frame = CGRect(x: 0, y: Int(titleLB.frame.size.height)+margin + Int(view.frame.size.height)-100 ,
                               width: Int(view.frame.size.width),
                               height: 100)
        
        
    }
    

}
