//
//  ViewController.swift
//  TotalMemberView
//
//  Created by 주호박 on 2018. 2. 24..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var memberTableView: UITableView!
    var userNameList:[String] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let usrList = userDefault.array(forKey: "UserList") as? [[String: String]]{
            for user in usrList{
                self.userNameList.append(user["Name"]!)
            }
        }else{
            print("userdefault load fail...")
        }
        return userNameList.count
    }//몇줄로 표시될건지..
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MemberCell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! MemberCell
        if userNameList.count > 1{
            cell.cellTitle = userNameList[indexPath.row]
            cell.cellDetail = "자세히"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailMemberViewController") as! DetailMemberViewController
        nextVC.prevData = tableView.cellForRow(at: indexPath)?.textLabel?.text        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let noti = NotificationCenter.default
        noti.addObserver(forName: NSNotification.Name(rawValue: "member"),
                         object: nil,
                         queue: nil) { (noti) in
                            if let usrList = userDefault.array(forKey: "UserList") as? [[String: String]]{
                                for usr in usrList{
                                    if !self.userNameList.contains(usr["Name"]!){
                                        self.userNameList.append(usr["Name"]!)
                                    }
                                }
                                self.memberTableView.reloadData()
                            }else{
                                print("userdefault load fail...")
                            }
                        }
        
        
        
    }

    
    

}

