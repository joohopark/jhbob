//
//  BlackJackViewController.swift
//  BlackJack
//
//  Created by 주호박 on 2018. 2. 13..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class BlackJackViewController: UIViewController {

    // 이전 로그인 창에서 데이터 받아오기위한 프로퍼티임.(without segue)
    //let listLBStr: [String] = ["Name" , "ID", "PW" , "RePW","Address", "Gender", "Money"]
    var loginUserDat: [String: String]!
    var userName,userID,userPW,userRePW,userAddress,userGender,userMoney: String!
    var userDataList: [String]!

    let totalRound:Int = 3
    var currentRound = 0
    var isDoubleDown: Bool = false
    var isCardOpenAtDoubleDown: Bool = false
    //=============================bankerView==========================
    var bankerView: UIView!
    var bankSay: UILabel!
    var totalPrice: UILabel!
    var total = 0
    var bankerNum = arc4random_uniform(21)+1
    //doubledown Signal
    var dbSignalView: UIView!
    var dbSignalLB: UILabel!
    var dbSignal:UIView!
    //currentround signal
    var ssSignalView: UIView!
    var ssSignalLB:UILabel!
    var ssSignalList:[UIView]!
    //=============================bankerView==========================
    //=============================PlayerView==========================+
    var playerView: UIView!
    var cardList: [UIButton] = []
    //=============================PlayerView==========================+
    //=============================BettingBtnView==========================+
    var bettingBtnView: UIView!
    var playerTotal: UILabel!
    var bettingMoneyView: UIView!
    var bettingMoneyLB: UILabel!
    var bettingMoneyTF:UITextField!
    var bettingBtnList:[UIButton] = []
    var bettingBtnListView: UIView!
    //=============================BettingBtnView==========================+

    
    
    var closureLB:UILabel!
    var closureView:UIView!
    var closureViewList: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //  0..get user data
        getLoginUserData(loginUserDat)
        
        // 1.. create & set frame UI
        createBankerUI()
        setFrameOfCBU()
        
        createPlayerCardUI()
        setFrameOfPCU()
        
        createBtnUI()
        setFrameOfBtn()
        
        
        
    }

    func getLoginUserData(_ data: [String: String]){
        if let name = data["Name"], let id = data["ID"], let pw = data["PW"], let repw = data["RePW"], let address = data["Address"], let gender = data["Gender"], let money = data["Money"] {
            userName = name
            userID = id
            userPW = pw
            userRePW = repw
            userAddress = address
            userGender = gender
            userMoney = money
        }else{
            print("err ocur : Some User Data Values include nil")
        }
    }
    
    //MARK:- BtnView
    func createBtnUI(){
        bettingBtnView = {
            let view = UIView()
            self.view.addSubview(view)
            return view
        }()
        
        playerTotal = {
            let label = UILabel()
            label.text = "현재 Player \(userName!)의 총 금액은 \(userMoney!) 입니다."
            label.textColor = .blue
            self.bettingBtnView.addSubview(label)
            return label
        }()
        
        (bettingMoneyView,bettingMoneyLB,bettingMoneyTF) = {
            let subView = UIView()
            let label = UILabel()
            label.text = "BettingMoney"
            let textfield = UITextField()
            textfield.layer.borderWidth = 2
            textfield.placeholder = "Input Betting Money"
            self.bettingBtnView.addSubview(subView)
            subView.addSubview(label)
            subView.addSubview(textfield)
            return (subView, label, textfield)
        }()
        let btnTxtList = ["Hit", "Stay", "DoubleDown", "Betting"]
//        let btnFunctionList = ["didClickedHitBtn(_:)", "didClickedStayBtn(_:)", "didClickedDoubleDownBtn(_:)", "didClickedBettingBtn(_:)"]
        // 이런식으로 objc selector 안에 반복으로 넣을려면 클로져를 써야...? 그럼 objc용으로 어떻게 클로져를 만드나?
        (bettingBtnListView, bettingBtnList) = {
            let subView = UIView()
            var btnList: [UIButton] = []
            for index in 0..<btnTxtList.count{
                let btn = UIButton()
                btn.setTitle(btnTxtList[index], for: .normal)
                btn.setTitle("\(btnTxtList[index])!", for: .highlighted)
                btn.layer.borderWidth = 1
                btn.setTitleColor(.blue, for: .normal)
                btn.setTitleColor(.red, for: .highlighted)
                switch btnTxtList[index]{
                case "Hit":
                    btn.addTarget(self, action: #selector(didClickedHitBtn(_:)), for: .touchUpInside)
                case "Stay":
                    btn.addTarget(self, action: #selector(didClickedStayBtn(_:)), for: .touchUpInside)
                case "DoubleDown":
                    btn.addTarget(self, action: #selector(didClickedDoubleDownBtn(_:)), for: .touchUpInside)
                case "Betting":
                    btn.addTarget(self, action: #selector(didClickedBettingBtn(_:)), for: .touchUpInside)
                default:
                    print("err ocur set btn TargetAction")
                }
                subView.addSubview(btn)
                btnList.append(btn)
            }
            self.bettingBtnView.addSubview(subView)
            return (subView, btnList)
        }()
    }
    
    func setFrameOfBtn(){
        bettingBtnView.frame = CGRect(x: 0,
                                      y: Int(playerView.frame.size.height+bankerView.frame.size.height),
                                      width: Int(view.frame.size.width),
                                      height: Int(view.frame.size.height-playerView.frame.size.height+bankerView.frame.size.height))
        
        playerTotal.frame = CGRect(x: 0,
                                   y: 0,
                                   width: Int(view.frame.size.width),
                                   height: Int(bettingBtnView.frame.size.height/8))
        
        bettingMoneyView.frame = CGRect(x: 0,
                                        y:  Int(bettingBtnView.frame.size.height/8),
                                        width: Int(view.frame.size.width),
                                        height: Int(bettingBtnView.frame.size.height/8))
        bettingMoneyLB.frame = CGRect(x: 0,
                                      y: 0,
                                      width: Int(view.frame.size.width/2),
                                      height: Int(bettingBtnView.frame.size.height/8))
        bettingMoneyTF.frame = CGRect(x: Int(view.frame.size.width/2),
                                      y: 0,
                                      width: Int(view.frame.size.width/2),
                                      height: Int(bettingBtnView.frame.size.height/8))

        bettingBtnListView.frame = CGRect(x: 0,
                                          y: Int(bettingBtnView.frame.size.height/4),
                                          width: Int(view.frame.size.width),
                                          height: Int(bettingBtnView.frame.size.height/4))
        for index in 0..<bettingBtnList.count{
            bettingBtnList[index].frame = CGRect(x: 5+(index*Int(view.frame.size.width/5)),
                                                 y: 50,
                                                 width: Int(view.frame.size.width/5),
                                                 height: 100)
        }
    }
    //MARK:- BankerView
    func createBankerUI(){
        bankerView = UIView()
//        bankerView.backgroundColor = .white
        dbSignalView = UIView()
//        dbSignalView.backgroundColor = .white
        (dbSignalLB, dbSignal) = {
            closureLB = UILabel()
            closureLB.text = "DoubleDown"
            self.dbSignalView.addSubview(closureLB)
            
            closureView = UIView()
//            closureView.backgroundColor = .yellow
            closureView.layer.borderWidth = 1
            self.dbSignalView.addSubview(closureView)
            return (closureLB, closureView)
        }()
        
        ssSignalView = UIView()
//        ssSignalView.backgroundColor = .red
        (ssSignalLB, ssSignalList) = {
            closureLB = UILabel()
            closureLB.text = "CurrentRound"
            self.ssSignalView.addSubview(closureLB)
            
            for n in 0..<3{
            
                let view = UIView()
                view.tag = n
                view.backgroundColor = .yellow
                view.layer.borderWidth = 1
                self.ssSignalView.addSubview(view)
                closureViewList.append(view)
            }
            
            return (closureLB, closureViewList)
        }()
        
        (bankSay, totalPrice) = {
            let returnLB = UILabel()
            returnLB.text = "현재 \(currentRound)턴 입니다."
            returnLB.textAlignment = .center
            self.bankerView.addSubview(returnLB)
            
            closureLB = UILabel()
            closureLB.text = "TotalPrice : \(total)"
            closureLB.textAlignment = .center
            self.bankerView.addSubview(closureLB)
            return (returnLB, closureLB)
        }()
        
        view.addSubview(bankerView)
        bankerView.addSubview(dbSignalView)
        bankerView.addSubview(ssSignalView)
    }
    
    func setFrameOfCBU(){
        bankerView.frame = CGRect(x: 0,
                                  y: 20,
                                  width: Int(view.frame.size.width),
                                  height: Int(view.frame.size.width/3))
        bankSay.frame = CGRect(x: 0,
                               y: Int(bankerView.frame.size.height/2),
                               width: Int(view.frame.size.width),
                               height: 50)
        totalPrice.frame = CGRect(x: 0,
                                  y: 0,
                                  width: Int(view.frame.size.width),
                                  height: 50)
        dbSignalView.frame = CGRect(x: Int(view.frame.size.width/2),
                                    y: Int(bankerView.frame.size.height/4),
                                    width: Int(view.frame.size.width/2),
                                    height: 50)
        dbSignalLB.frame = CGRect(x: 0,
                                  y: 0,
                                  width: Int(dbSignalView.frame.size.width/2),
                                  height: 50)
        dbSignal.frame = CGRect(x: Int(dbSignalLB.frame.size.width),
                                y: 15,
                                width: 20,
                                height: 20)
        ssSignalView.frame = CGRect(x: 0,
                                    y: Int(bankerView.frame.size.height/4),
                                    width: Int(view.frame.size.width/2),
                                    height: 50)
        ssSignalLB.frame = CGRect(x: 0,
                                  y: 0,
                                  width: Int(ssSignalView.frame.size.width/2)+20,
                                  height: 50)
        for index in 0..<ssSignalList.count{
            ssSignalList[index].frame = CGRect(x: Int(ssSignalLB.frame.size.width)+(20*index)+20,
                                y: 15,
                                width: 20,
                                height: 20)
        }
        
    }
    
    //MARK:- PlayerView
    func createPlayerCardUI(){
        playerView = {
            let subView = UIView()
            self.view.addSubview(subView)
//            subView.backgroundColor = .green
            return subView
        }()
        cardList = {
            var btnList:[UIButton] = []
            let img = UIImage(named: "default")
            for index in 0..<totalRound+2{
                let btn = UIButton()
                btn.setImage(img, for: .normal)
                btn.setImage(cardSelect(), for: .selected)
                btn.tag = index
                btn.addTarget(self, action: #selector(didClickCardBtn(_:)), for: .touchUpInside)
                btnList.append(btn)
                self.playerView.addSubview(btn)
            }

            
            return btnList
        }()
    }
    
    func setFrameOfPCU(){
        playerView.frame = CGRect(x: 0,
                                  y: Int(bankerView.frame.size.height),
                                  width: Int(view.frame.size.width),
                                  height: Int(view.frame.size.height/3))

        for index in 0..<cardList.count{
            cardList[index].frame = CGRect(x: 100 + 50*index,
                                y: 50,
                                width: 50,
                                height: 100)
        }
        
    }

    //MARK:- Button Action
    
    /// hit 구현
    ///
    /// - Parameter sender: <#sender description#>
    @objc func didClickedHitBtn(_ sender: UIButton){
        if totalRound <= currentRound{
            bankSay.text = "현재 \(currentRound)턴입니다. hit은 안되안되~"
        }else{
            ssSignalList[currentRound].backgroundColor = .green
            currentRound += 1
            bankSay.text = "현재 \(currentRound)턴 입니다."
        }
    }
    
    // stay 구현
    // 더이상 카드를 받지 않고 결과를 봐야함.
    @objc func didClickedStayBtn(_ sender: UIButton){
        var playerNum = 0
        var winner:String = ""
        for index in 0...currentRound+1{
            playerNum += selectList[index]
        }
        
        bankSay.text = "결과 확인 : BankerNum(\(bankerNum)), playerNum(\(playerNum))"
        
        // !doubledown 일때
        if !isDoubleDown{
            if abs(21 - Int(bankerNum)) > abs(21-playerNum){// player win
                userMoney = String(Int(userMoney)!+total)
                winner = userID
            }else{//banker win
                userMoney = String(Int(userMoney)! - total/2)
                winner = "banker"
            }
        }else if isDoubleDown{
            if abs(21 - Int(bankerNum)) > abs(21-playerNum){// player win
                userMoney = String(Int(userMoney)!+total)
                winner = userID
            }else{//banker win
                userMoney = String(Int(userMoney)! - total/4)
                winner = "banker"
            }
        }
        
        playerTotal.text = "현재 Player \(userName!)의 총 금액은 \(userMoney!) 입니다."
        
        newGameSetting(winner: winner, bankerNum: String(bankerNum), playerNum: playerNum)
    }
    
    /// userDefault에 현재 정보를 저장합니다.
    /// Userdefault의 정보들중 현재 사용자 정보를 찾아 프로퍼티들을 교체 저장.
    var saveUserDatList:[[String: String]] = []
    func saveUserDat(){
//        userName,userID,userPW,userRePW,userAddress,userGender,userMoney
        //as! 와 as?의 차이는... 강제 다운 과 옵셔녈 차이
        // userdefault의 정보를 따로 교체 하는 방법은 removeObject 메소드를 사용하는 방법 뿐인듯??
        let defaults = UserDefaults.standard
        
        if let tmpList = defaults.array(forKey: "UserList") as? [[String: String]]{
            saveUserDatList = tmpList

            for userDataIndex in 0..<saveUserDatList.count{
                if saveUserDatList[userDataIndex]["ID"] == userID{
                    saveUserDatList[userDataIndex]["Money"] = userMoney
                }
                print(saveUserDatList[userDataIndex])
            }
            
            defaults.removeObject(forKey: "UserList")// 기존 정보 다 지우고

            defaults.set(saveUserDatList, forKey: "UserList")// 변경 정보 재저장.. 비효율인데,.
            
        }else{
            print("userDefault Data load fail..")
        }

    }
    
    /// 기존 변수 초기화 && 사용자 정보( 돈) 저장,
    /// 신호 뷰 초기화
    func newGameSetting(winner : String, bankerNum: String, playerNum: Int){
        //초기화 필요한 애들
        selectList = []
        currentRound = 0
        isDoubleDown = false
        isCardOpenAtDoubleDown = false
        total = 0
        if winner == userID{
            bankSay.text = "\(winner) win..Bank:\(bankerNum) vs player:\(playerNum)"
        }else{
            bankSay.text = "ㅎㅎ 까비요...Bank:\(bankerNum) vs player:\(playerNum)"
        }
        totalPrice.text = "totalPrice : \(total)"
        
        for signal in ssSignalList{
            signal.backgroundColor = .yellow
        }
        dbSignal.backgroundColor = .yellow
        
        for card in cardList{
                card.isSelected = false
        }
        saveUserDat()
        
        // card가 변경되지 않는다..왜죠..
    }
    
    // doubleDown 구현
    // 다음 카드 오픈을 끝으로 결과를 본다.
    // 이기면 상금 * 2
    //
    @objc func didClickedDoubleDownBtn(_ sender: UIButton){
        if currentRound < 3{
            dbSignal.backgroundColor = .green
            isDoubleDown = true
            total *= 2
            totalPrice.text = "totalPrice : \(total)"
        }else{
            bankSay.text = "Double Down하기엔 이미 늦음.."
        }
    }
    
    // betting 구현
    // bettingMoneyTF 에 입력한 금액을 현재 금액이 넘어가지않는다면 배팅한다.
    // 베팅후 totlaPrice = (bettingMoneyTF.text) * 2
    @objc func didClickedBettingBtn(_ sender: UIButton){

        guard let isNil = bettingMoneyTF.text  else {
            bankSay.text = "금액 입력 후 눌러여."
            return
        }
        guard let num = Int(bettingMoneyTF.text!)  else {
            bankSay.text = "금액은 숫자로 입력할것."
            return
        }
        
        if Int(userMoney)! < Int(bettingMoneyTF.text!)!{
            bankSay.text = "현재 금액보다 \(abs(Int(bettingMoneyTF.text!)! - Int(userMoney)!))만큼 많이 입력."
            return
        }else{
            total += Int(bettingMoneyTF.text!)! * 2
            totalPrice.text = "totalPrice : \(total)"
        }
        
    }
    
    /// card btn 눌르면 2장까지는 걍 열려 -> tag 이용
    /// 3장쨰부터는 currentRound를 확인 한 이후에 한장씩 열림
    /// - Parameter sender: UIButton
    @objc func didClickCardBtn(_ sender: UIButton){

        if !isDoubleDown{
        // tag 2, 3, 4 는 currentRound가 1일때부터 한장씩 열린다.
        switch sender.tag {
        case 0,1:
            sender.isSelected = true
        case 2,3,4:
            if currentRound+1 == sender.tag{
                sender.isSelected = true
            }
        default:
            print("err ocur while card open")
            }
        }else if isDoubleDown && !isCardOpenAtDoubleDown{
            isCardOpenAtDoubleDown = true
            sender.isSelected = true
            currentRound += 1
        }
    }
    

    // 카드 버튼을 눌렀을때 카드 이미지를 변경해야함.
    // 이미지는 랜덤으로 정해짐.
    // - 중복 이미지는 생기지 않도록
    // - arc4random_uniform(N) 은 0 에서 N - 1 범위의 난수를 반환합니다.
    /// - Returns: UIImage
    var selectList: [Int] = []

    func cardSelect() -> UIImage{
        var resImgNum: Int = Int(arc4random_uniform(13)) + 1
        var isSetOK: Bool = false
        
        var resVal: String!
        
        /*중복 이미지 피하도록 list append*/
        while isSetOK != true{
            if !selectList.contains(resImgNum){
                isSetOK = true
                selectList.append(resImgNum)
            }else{
                resImgNum = Int(arc4random_uniform(13)) + 1
            }
        }
        
        /*A = 1 , J = 11, Q = 12, K= 13*/
        switch resImgNum {
        case 1:
            resVal = "A"
        case 11:
            resVal = "J"
        case 12:
            resVal = "Q"
        case 13:
            resVal = "K"
        default:
            resVal = "\(resImgNum)"
        }
        
        return UIImage(named: resVal)!
    }
}












