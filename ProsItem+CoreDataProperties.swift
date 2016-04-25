//
//  ProsItem+CoreDataProperties.swift
//  OCP
//
//  Created by entre on 4/18/16.
//  Copyright © 2016 PHS. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ProsItem {

    @NSManaged var proName: String?
    @NSManaged var proNameTextField: String?

}
