//
//  College.swift
//  collegeBuilder
//
//  Created by student3 on 2/4/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit

class College
{

    var name : String
    var location : String
    var numberOfStudents: Int
    var image : UIImage
    //var url = NSURL()
    
    init (Name n: String, Location l: String, NumberOfStudents ns: Int, Image i: UIImage)
    {
        name = n
        location = l
        numberOfStudents = ns
        image = i
    }
}
