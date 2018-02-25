//
//  MemberCell.swift
//  TotalMemberView
//
//  Created by 주호박 on 2018. 2. 24..
//  Copyright © 2018년 주호박. All rights reserved.
//

import UIKit

class MemberCell: UITableViewCell {

    var cellTitle:String?{
        didSet{
            self.textLabel?.text = cellTitle
        }
    }
    var cellDetail:String?{
        didSet{
            self.detailTextLabel?.text = cellDetail
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
