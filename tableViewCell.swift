//
//  tableViewCell.swift
//  collegeBuilder
//
//  Created by entre on 11/5/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit

class tableViewCell: UITableViewCell
{
    
    @IBOutlet weak var cellSwitch: UISwitch!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }


//    override func awakeFromNib()
//    {
//        super.awakeFromNib()
//       
//    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
