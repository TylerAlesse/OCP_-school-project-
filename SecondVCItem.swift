
import Foundation
import CoreData
import UIKit

class SecondVCItem: NSManagedObject
{
    convenience init(teacherRec1: String, teacherRec2: String, teacherRec3: String, username: String, password: String, datepicker: UIDatePicker, datepickertextfield: String, reqTesting: String, numberOfEssays: String, letterOrForm: NSNumber, commonApp: NSNumber, collegeImage: UIImage?, location: String, name: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext)
    {
        let entity = NSEntityDescription.entityForName("SecondVCItem", inManagedObjectContext: managedObjectContext)!
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
        self.teacherRec1 = teacherRec1
        self.teacherRec2 = teacherRec2
        self.teacherRec3 = teacherRec3
        self.username = username
        self.password = password
        self.datepicker = datepicker.date
        self.datepickertextfield = datepickertextfield
        self.reqTesting = reqTesting
        self.numberOfEssays = numberOfEssays
        self.letterOrForm = letterOrForm
        self.commonApp = commonApp
        //self.imageView = imageView
        //self.imageView = collegeImage
        self.location = location
        self.name = name
        
        do {
            try managedObjectContext.save()
        } catch {
            print("error")
        }
    }
    
    class func retrieveSpecifiedItem(item: Item, moc: NSManagedObjectContext) -> SecondVCItem? {
        
        let fetchRequest = NSFetchRequest(entityName: String(SecondVCItem))
        
        guard let name = item.name
            else { return nil }
        
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        // let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [AAAEmployeeMO]
        do {
            let result = try moc.executeFetchRequest(fetchRequest).last as? SecondVCItem
            return result
        } catch {
            return nil
        }
        
    }
    
//
//    class func fetchAll(managedObjectContext: NSManagedObjectContext) -> [SecondVCItem] {
//        let listagemCoreData = NSFetchRequest(entityName: "SecondVCItem")
//        
//        // Sort alphabetical by field "name"
//        
//        // Get items from CoreData
//        return (try? managedObjectContext.executeFetchRequest(listagemCoreData)) as? [SecondVCItem] ?? []
//    }
//
//    
//    
//    func search(name: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> SecondVCItem? {
//        let fetchRequest       = NSFetchRequest(entityName: "SecondVCItem")
//        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
//        
//        let result             = (try? managedObjectContext.executeFetchRequest(fetchRequest)) as? [SecondVCItem]
//        return result?.first
//    }
//
//    
//    func destroy(managedObjectContext: NSManagedObjectContext) {
//        managedObjectContext.deleteObject(self)
//    }
////
////    
//    func save(moc: NSManagedObjectContext) {
//        do {
//            try moc.save()
//        }
//        catch {
//            let nserror = error as NSError
//            print("Error on save: \(nserror.debugDescription)")
//        }
//    }
//
}
    

