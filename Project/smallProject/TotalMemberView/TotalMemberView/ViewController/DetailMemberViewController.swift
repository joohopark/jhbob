//
//  DetailMemberViewController.swift
//  TotalMemberView
//
//  Created by 주호박 on 2018. 2. 24..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class DetailMemberViewController: UIViewController {

    @IBOutlet weak var nameLB: UILabel!
    @IBOutlet weak var ageLB: UILabel!
    @IBOutlet weak var genderLB: UILabel!
    
    var prevData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let usrList = userDefault.array(forKey: "UserList") as? [[String: String]]{
            for usr in usrList{
                if usr["Name"] == self.prevData{
                    self.nameLB.text = usr["Name"]
                    self.ageLB.text = usr["Age"]
                    self.genderLB.text = usr["Gender"]
                }
            }
        }
    }
}
