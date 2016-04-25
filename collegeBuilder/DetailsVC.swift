//
//  DetailsVC.swift
//  OCP
//
//  Created by entre on 2/22/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit

class DetailsVC: NSObject
{
    var username: String
    var password: String
    var essayNumber: String
    var requiredTesting: String
    var datepickertextfield: String
    var collegeImage: UIImage
    var counslerForm: Int16
    var commonApp: Int16
    
    init(usernameTextField u: String, passwordTextField p: String, essayNumber e: String, requiredTesting r: String, datepickertextfield d: String, collegeImage i: UIImage, counslerForm c: Int16, commonApp ca: Int16)
    {
        
        username = u
        password = p
        essayNumber = e
        requiredTesting = r
        datepickertextfield = d
        collegeImage = i
        counslerForm = c
        commonApp = ca
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
