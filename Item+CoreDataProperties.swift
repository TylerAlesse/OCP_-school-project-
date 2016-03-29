//
//  Item+CoreDataProperties.swift
//  OCP
//
//  Created by entre on 2/12/16.
//  Copyright © 2016 PHS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Item {

    @NSManaged var image: NSData?
    @NSManaged var location: String?
    @NSManaged var name: String?
    @NSManaged var nameTextField: String?

}
