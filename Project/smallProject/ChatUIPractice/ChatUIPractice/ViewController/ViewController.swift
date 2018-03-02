//
//  ViewController.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    let firendList = MainDataCenter.sharedInstance.friendModelList
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("2번째")
        if let cell = sender as? MainCell,
            let nextVC = segue.destination as? DetailViewController{
            nextVC.userDetail = cell.cellData
        }
    }

    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print("1번째")
        return true
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainDataCenter.sharedInstance.friendListCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainCell
//        MainDataCenter.sharedInstance.friendData(with: indexPath.row)
        cell.cellData = firendList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

