//
//  SettingViewController.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    let settingDataList = SettingDataCenter.sharedInstance.settingModelList

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingDataList[section].dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! SettingCell
        cell.cellData = settingDataList[indexPath.section].dataList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settingDataList[section].sectionTitle
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingDataList.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
