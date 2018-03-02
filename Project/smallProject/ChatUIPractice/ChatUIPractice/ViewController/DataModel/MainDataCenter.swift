//
//  MainDataCenter.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import Foundation

class MainDataCenter{
    static var sharedInstance: MainDataCenter = MainDataCenter()
    private var friendList: [[String: String]]!//원본 데이터 수정을 막기위해 private
    
    var friendListCount:Int{
        return friendList.count
    }
    /*
     func friendListCount()->Int{
     return friendList.count
     }
     */
    var friendModelList:[UserModel]{//모델 인스턴스로 배열을 만들어 받어..
        var list:[UserModel] = []
        for dic in friendList{
            list.append(UserModel(with: dic)!)
        }
        return list
    }//func friendData로 접근하나 이렇게 해주나 도낀 개낀 list 반환 차이
    
    private init(){
        loadFriendList()
    }
    
    private func loadFriendList(){
        let path = Bundle.main.path(forResource: "FriendInfo", ofType: "plist")!
        
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let property =  try! PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)
        let dic = property as! [[String: String]]
        
        friendList = dic
    }
    
    func friendData(with Index:Int) -> UserModel?{
        let dic = friendList[Index]
        return UserModel(with: dic)
    }
}

struct UserModel {
    var phoneNumber: String
    var profileImgUrl: String
    var profileDescription: String
    var bgImgUrl: String
    var statusDescription: String
    var nickName: String
    var email: String
    
    init?(with dic: [String: String]){
        guard let profileImgUrl = dic["ProfileImage"] else { return nil }
        guard let phoneNumber = dic["PhoneNumber"] else { return nil }
        guard let profileDescription = dic["MyProfileDescription"] else { return nil }
        guard let bgImgUrl = dic["BackgroundImage"] else { return nil }
        guard let statusDescription = dic["StatusDescription"] else { return nil }
        guard let nickName = dic["Nickname"] else { return nil }
        guard let email = dic["Email"] else { return nil }
        
        self.phoneNumber = phoneNumber
        self.profileImgUrl = profileImgUrl
        self.profileDescription = profileDescription
        self.bgImgUrl = bgImgUrl
        self.statusDescription = statusDescription
        self.nickName = nickName
        self.email = email
    }
}




