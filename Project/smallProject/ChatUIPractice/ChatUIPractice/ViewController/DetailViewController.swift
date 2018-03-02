//
//  DetailViewController.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var userDetail: UserModel!
    
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var profileDescriptionLb: UILabel!
    @IBOutlet weak var phonNumberLb: UILabel!
    @IBOutlet weak var emailLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userData = userDetail{
            // 사용자 데이터가 넘어오게 되면 UI 업데이트
            bgImgView.image = UIImage(named: userData.bgImgUrl)
            profileImgView.image = UIImage(named: userData.profileImgUrl)
            nameLb.text = userData.nickName
            profileDescriptionLb.text = userData.profileDescription
            phonNumberLb.text = userData.phoneNumber
            emailLb.text = userData.email
        }
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        profileImgView.clipsToBounds = true
        profileImgView.layer.borderColor = UIColor.black.cgColor
        profileImgView.layer.borderWidth = 1
    }
}
