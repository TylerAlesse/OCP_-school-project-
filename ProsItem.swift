//
//  ProsItem.swift
//  OCP
//
//  Created by entre on 4/18/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProsItem: NSManagedObject
{

    convenience init(name: String, image: UIImage?, location: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext)
    {
        let entity = NSEntityDescription.entityForName("ProsItem", inManagedObjectContext: managedObjectContext)!
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
//        self.name = name
//        // self.image = image
//        self.location = location
    }
    //
    /// Function to get all CoreData values
    ///
    /// - parameter managedObjectContext: CoreData Connection
    ///
    class func fetchAll(managedObjectContext: NSManagedObjectContext) -> [ProsItem] {
        let listagemCoreData             = NSFetchRequest(entityName: "ProsItem")
        
        // Sort alphabetical by field "name"
        let orderByName = NSSortDescriptor(key: "name", ascending: true, selector: "caseInsensitiveCompare:")
        listagemCoreData.sortDescriptors = [orderByName]
        
        // Get items from CoreData
        return (try? managedObjectContext.executeFetchRequest(listagemCoreData)) as? [ProsItem] ?? []
    }
    
    /// Function to search item by name
    ///
    /// - parameter name: Item name
    /// - parameter managedObjectContext: CoreData Connection
    ///
    class func search(name: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> ProsItem? {
        let fetchRequest       = NSFetchRequest(entityName: "ProsItem")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        
        let result = (try? managedObjectContext.executeFetchRequest(fetchRequest)) as? [ProsItem]
        return result?.first
    }
    
    /// Function to check duplicate item
    ///
    /// - parameter name: Item name
    /// - parameter managedObjectContext: CoreData Connection
    ///
    class func checkDuplicate(name: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Bool {
        return search(name, inManagedObjectContext: managedObjectContext) != nil
    }
    
    /// Function to delete a item
    ///
    /// - parameter managedObjectContext: CoreData Connection
    ///
    func destroy(managedObjectContext: NSManagedObjectContext) {
        managedObjectContext.deleteObject(self)
    }
    
    /// Function to save CoreData values
    ///
    /// - parameter managedObjectContext: CoreData Connection
    ///
    func save(managedObjectContext: NSManagedObjectContext) {
        do {
            try managedObjectContext.save()
        }
        catch {
            let nserror = error as NSError
            print("Error on save: \(nserror.debugDescription)")
        }
    }


}
