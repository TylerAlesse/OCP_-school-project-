//
//  SecondVCItem+CoreDataProperties.swift
//  OCP
//
//  Created by entre on 4/5/16.
//  Copyright © 2016 PHS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension SecondVCItem {

    @NSManaged var commonApp: NSNumber?
    @NSManaged var datepicker: NSDate?
    @NSManaged var datepickertextfield: String?
    @NSManaged var imageView: NSData?
    @NSManaged var letterOrForm: NSNumber?
    @NSManaged var location: String?
    @NSManaged var numberOfEssays: String?
    @NSManaged var password: String?
    @NSManaged var reqTesting: String?
    @NSManaged var teacherRec1: String?
    @NSManaged var teacherRec2: String?
    @NSManaged var teacherRec3: String?
    @NSManaged var username: String?
    @NSManaged var name: String?

}
