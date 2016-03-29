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
    
    
    init(usernameTextField u: String, passwordTextField p: String, essayNumber e: String, requiredTesting r: String)
    {
        
        username = u
        password = p
        essayNumber = e
        requiredTesting = r
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
