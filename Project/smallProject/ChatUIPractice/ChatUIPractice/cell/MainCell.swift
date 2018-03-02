//
//  MainCell.swift
//  ChatUIPractice
//
//  Created by 주호박 on 2018. 2. 28..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    @IBOutlet weak var userStatusLable: UILabel!
    
    var cellData: UserModel?{
        willSet{
            if let data = newValue{
               userNameLable.text = data.nickName
                imgView.image = UIImage(named: data.profileImgUrl)
                userStatusLable.text = data.statusDescription
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }//viewdidload
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        imgView.layer.cornerRadius = imgView.frame.size.width/2
        imgView.clipsToBounds = true
        imgView.layer.borderColor = UIColor.black.cgColor
        imgView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
