//
//  ViewController.swift
//  BlackJack
//
//  Created by 주호박 on 2018. 2. 9..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit
import AVFoundation

// 로그인 기능 처리
// UserDefault를 통한 사용자 정보 저장.
// 입력값 비교 를통한 로그인 처리
class ViewController: UIViewController {

    private var playBGM: AVAudioPlayer?
    
    var loginView: UIView!
    var loginBtn: UIButton!
    
    var tFList: [UITextField] = []// 옵셔널이면 append할때 에러가 나는데... append그냥 되야 되는거 아님?
    var lBList:[UILabel] = []
    
     var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var nextVC:BlackJackViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 값 넘길꺼에여~
        nextVC = mainStoryboard.instantiateViewController(withIdentifier: "BlackJackViewController") as! BlackJackViewController
        
        bgmPlay()
        ui()
        
    }
    
    func ui(){
        createUI()
        setFrame()
    }
    
    let lBMentList: [String] = ["아디", "비번"]
    
    func createUI(){
        loginBtn = UIButton()
        loginBtn.setTitle("로긴ㄱㄱ", for: .normal)
        loginBtn.setTitleColor(.blue, for: .normal)
        loginBtn.addTarget(self, action: #selector(didClickedLoginBtn(_:)), for: .touchUpInside)
        view.addSubview(loginBtn)
        
        loginView = UIView()
        for n in 0..<lBMentList.count{
            let uiLabel = UILabel()
            let uiTxtField = UITextField()
            uiLabel.layer.borderWidth = 2
            uiTxtField.layer.borderWidth = 1
            uiLabel.text = lBMentList[n]
            uiTxtField.placeholder = "\(lBMentList[n]) 입력요"
            if lBMentList[n] == "비번"{
                uiTxtField.isSecureTextEntry = true
            }

            uiTxtField.tag = n
            uiLabel.tag = n
            
            tFList.append(uiTxtField)
            lBList.append(uiLabel)


            loginView.addSubview(uiLabel)
            loginView.addSubview(uiTxtField)
        }
    }

    func setFrame(){
        loginView.frame = CGRect(x: 0, y: Int(view.frame.size.height/2), width: Int(view.frame.size.width), height: 300)
        
        for n in 0..<lBList.count{
            lBList[n].frame = CGRect(x: 0, y: Int(loginView.frame.size.height/2)*n, width: Int(loginView.frame.size.width/4), height: Int(loginView.frame.size.height/3))
            tFList[n].frame = CGRect(x: Int(lBList[n].frame.size.width)+10, y: Int(lBList[n].frame.origin.y), width: Int(lBList[n].frame.size.width*2), height: Int(lBList[n].frame.size.height))
        }
        
        loginBtn.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        view.addSubview(loginView)
    }
    /// 로그인 조건 확인
    /// id,pw 입력 값과 UserDefault의 값을 비교하여 있는 사용자면
    /// 로그인 처리 후 게임 화면으로 present
    /// 로그인 사용자가 아닐경우 alert
    /// - Parameter sender: LoginBtn
    @objc func didClickedLoginBtn(_ sender: UIButton) {
        let isLoginCheck = { () -> Bool in
            guard let userList:[[String:String]] = UserDefaults.standard.array(forKey: "UserList") as? [[String: String]] else { return false }
            
            for userDat in userList{
                if tFList[0].text == userDat["ID"] && tFList[1].text == userDat["PW"]{
                    nextVC.loginUserDat = userDat
                    return true
                }
            }
            
            return false
        }()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let nextVC: BlackJackViewController = storyboard.instantiateViewController(withIdentifier: "BlackJackViewController") as! BlackJackViewController
        
        
        if isLoginCheck{
            self.present(nextVC, animated: true, completion: nil)
        }else{
            alertActionAtLoginFail()
        }
        
        
    }
    
    func alertActionAtLoginFail(){
        let alert = UIAlertController(title: "로그인" , message: "아디or비번 입력 안했거나, 님 회원가입 아직인듯?", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .default) { (action) in
            for tF in self.tFList{
                tF.text = ""
            }
            
        }
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func checkUser() -> Bool{
        guard let userList:[[String:String]] = UserDefaults.standard.array(forKey: "UserList") as? [[String: String]] else { return false }
        
        for userDat in userList{
            if tFList[0].text == userDat["ID"] && tFList[1].text == userDat["PW"]{
                 nextVC.loginUserDat = userDat
                return true
            }
        }
        
        return false
    }
    
    
    func bgmPlay() -> AVAudioPlayer{
        let path = Bundle.main.path(forResource: "Lambada", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do{
            let playBGM = try AVAudioPlayer(contentsOf: url)// AVAudioPlayer로 인스턴스 생성시 익셉션 처리 필요한듯.
            self.playBGM = playBGM//함수에서만 해주면 viewController에서 bgm객체가 죽어서 프로퍼티 선언한 이후에 넣어줌.
            playBGM.volume = 1.0
            playBGM.numberOfLoops = 1
            playBGM.prepareToPlay()
            playBGM.play()
        }catch{
            print("url error occur")
        }
        return playBGM!
    }

}

