//
//  SettingCell.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    var cellData: DataModel?{
        didSet{
            guard let data = cellData else { return }
            self.textLabel?.text = data.content
            switch data.content {
            case "로그아웃", "회원탈퇴":
                self.textLabel?.textColor = .red
            default:
                self.textLabel?.textColor = .black
                if data.content == "버전정보"{
                    if let doubleConvert = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String{
                        self.detailTextLabel?.text = String(format: "%.1f", Double(Int(doubleConvert)!))
                    }
                }
            }
            
            switch data.cellSytle {
            case "SettingDetailCell":
                self.accessoryType = UITableViewCellAccessoryType(rawValue: 1)!
            case "SettingSwitchCell":
                self.accessoryType = UITableViewCellAccessoryType(rawValue: 0)!
                let cellSwitch:UISwitch = UISwitch(frame: .zero)// 어떠한 프레임을 넣던지 switch는 크기가 정해져 있음.
                cellSwitch.isOn = true
                self.accessoryView = cellSwitch
            default://SettingBasicCell, versionInfo
                self.accessoryType = UITableViewCellAccessoryType(rawValue: 0)!
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

