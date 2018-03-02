//
//  SettingDataCenter.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import Foundation

class SettingDataCenter{
    static var sharedInstance: SettingDataCenter = SettingDataCenter()
    private var settingList: [[String: Any]]!// 원본데이터

    /// SectionTitle: [[String: String]] 이 SettingModel이 되겠지..
    var settingModelList:[SettingModel]{// 변환 데이터
        var list:[SettingModel] = []
        for dic in settingList{
            list.append(SettingModel(with: dic)!)
        }
        return list
    }
    
    var settingDataListCount: Int{
        return settingModelList.count
    }
    
    private init(){
        loadSettingList(forResource: "Settings", ofType: "plist")
    }
    
    /// 번들의 plist를 가져와서 dictionary형태로 만들어 원본데이터(settingList)를 구해줌.
    private func loadSettingList(forResource: String, ofType: String){
        let path = Bundle.main.path(forResource: forResource, ofType: ofType)!
        
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let property =  try! PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil)
        let dic = property as! [[String: Any]]
        settingList = dic
    }
}

struct SettingModel {
    var sectionTitle: String
    var dataList: [DataModel] = []
    
    init?(with dic: [String:Any]){
        guard let sectionTitle = dic["SectionTitle"] else { return nil}
        self.sectionTitle = sectionTitle as! String
        
        if let dataList = dic["Data"] as? [[String: String]]{
            for data in dataList{
                if let dataModel = DataModel(with: data){
                    self.dataList.append(dataModel)
                }
            }
        }
    }
}

struct DataModel {
    var cellSytle: String
    var content: String
    
    init?(with dic: [String: String]){
        guard let cellStyle = dic["CellStyle"] else { return nil}
        guard let content = dic["Content"] else { return nil}
        
        self.cellSytle = cellStyle
        self.content = content
    }
}










