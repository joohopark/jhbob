//
//  ViewController.swift
//  Calculator
//
//  Created by 주호박 on 2018. 1. 26..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var displayView:UILabel!
    var keyPadView:UIView!
    var etcView:UIView!
    var operView:UIView!
    var numberPadView:UIView!
    
    var etcBtnList:[UIButton]!
    var operBtnList:[UIButton]!
    var numberBtnList:[UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        updateLayout()
        
    }
    
    
    //UI인스턴스 만드는 메소드
    private func createUI()
    {
        //mainView에 추가되는 가장 큰 영역
        displayView = UILabel()
        displayView.text = "0"
        displayView.textAlignment = NSTextAlignment.right
        displayView.font = UIFont.systemFont(ofSize: 100)
        displayView.textColor = UIColor.white
        view.addSubview(displayView)
        
        
        keyPadView = UIView()
        view.addSubview(keyPadView)
        
        //keyPad에 추가되는 영역
        etcView = UIView()
        keyPadView.addSubview(etcView)
        operView = UIView()
        keyPadView.addSubview(operView)
        numberPadView = UIView()
        keyPadView.addSubview(numberPadView)
        
        
        //test를 위한 색상 지정
        displayView.backgroundColor = .darkGray
        keyPadView.backgroundColor = UIColor.black
        //        etcView.backgroundColor = UIColor.red
        //        operView.backgroundColor = UIColor.blue
        //        numberPadView.backgroundColor = .yellow
        
        etcBtnList = makeBtn(count: 3)
        let etcTitleList = ["C","+/-","%"]
        for index in 0..<etcBtnList.count
        {
            let title = etcTitleList[index]
            let btn = etcBtnList[index]
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            btn.setTitle(title, for: .normal)
            btn.addTarget(self, action: #selector(self.etcHandler(_:)), for: .touchUpInside)
            etcView.addSubview(btn)
        }
        
        operBtnList = makeBtn(count: 5)
        let operTitleList = ["+","-","*","/","="]
        for index in 0..<operBtnList.count
        {
            let title = operTitleList[index]
            let btn = operBtnList[index]
            btn.setTitle(title, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            btn.addTarget(self, action: #selector(self.oprationHandler(_:)), for: .touchUpInside)
            operView.addSubview(btn)
        }
        numberBtnList = makeBtn(count: 10)
        
        let numberTitleList = ["7","8","9","4","5","6","1","2","3","0"]
        for index in 0..<numberBtnList.count
        {
            let title = numberTitleList[index]
            let btn = numberBtnList[index]
            btn.setTitle(title, for: .normal)
            btn.setTitleColor(.orange, for: .highlighted)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.darkGray.cgColor
            btn.addTarget(self, action: #selector(self.numberHandler(_:)), for: .touchUpInside)
            btn.addTarget(self, action: #selector(self.numberDown(_:)), for: .touchDown)
            numberPadView.addSubview(btn)
        }
        
    }
    
    
    @objc func etcHandler(_ sender:UIButton)
    {
        print(sender.tag)
        print(sender.titleLabel?.text)
    }
    
    @objc func oprationHandler(_ sender:UIButton)
    {
        print(sender.tag)
        print(sender.titleLabel?.text)
    }
    
    @objc func numberHandler(_ sender:UIButton)
    {
        sender.backgroundColor = .clear
        print(sender.tag)
        print(sender.titleLabel?.text)
    }
    
    @objc func numberDown(_ sender:UIButton)
    {
        sender.backgroundColor = .white
    }
    
    
    
    private func makeBtn(count:Int) -> [UIButton]
    {
        var returnList:[UIButton] = []
        for index in 0..<count
        {
            let btn = UIButton()
            btn.tag = index
            returnList.append(btn)
        }
        return returnList
    }
    
    
    //UI인스턴스 프레임 설정 메소드
    private func updateLayout()
    {
        //버튼은 화면의 가로에 4개씩 배치
        let btnWidth:CGFloat = self.view.frame.size.width / 4
        //아래에서부터 배치
        var offSetY:CGFloat = self.view.frame.size.height - (btnWidth * 5)
        //=======================================
        //keyPad영역 프레임
        keyPadView.frame = CGRect(x: 0, y: offSetY , width: view.frame.size.width, height: btnWidth*5)
        //Display영역 프레임
        let displayViewHeight:CGFloat = 150
        offSetY -= displayViewHeight
        displayView.frame = CGRect(x: 0, y: offSetY, width: view.frame.size.width, height: displayViewHeight)
        //=======================================
        //<keyPad안 영역>
        
        //etcView영역 프레임
        etcView.frame = CGRect(x: 0, y: 0, width: btnWidth*3, height: btnWidth)
        arrange(viewList: etcBtnList, collumCount: 3, width: btnWidth)
        //연산자영역 프레임
        operView.frame = CGRect(x: btnWidth * 3, y: 0, width: btnWidth, height: btnWidth * 5)
        arrange(viewList: operBtnList, collumCount: 1, width: btnWidth)
        
        //숫자영역 프레임
        numberPadView.frame = CGRect(x: 0, y: btnWidth, width: btnWidth * 3, height: btnWidth * 4)
        arrange(viewList: numberBtnList, collumCount: 3, width: btnWidth)
        
    }
    
    func arrange(viewList:[UIView], collumCount:Int, width:CGFloat)
    {
        for index in 0..<viewList.count
        {
            let col:CGFloat = CGFloat(index % collumCount)
            let row:CGFloat = CGFloat(index / collumCount)
            
            viewList[index].frame = CGRect(x:col*width, y: row*width, width: width, height: width)
        }
    }
    
    
}
