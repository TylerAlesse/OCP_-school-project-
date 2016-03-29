//
//  CoredataTableViewViewController.swift
//  OCP
//
//  Created by entre on 2/1/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit
import CoreData

class CoredataTableViewViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var collegeTableView: UITableView!
    var colleges = [College]()

    let coreDataDB = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var items = [Item]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.collegeTableView.tableFooterView = UIView()
        
        let exampleCollege = College(Name: "Example College", Location: "Unknown Location", NumberOfStudents: 100000, Image: UIImage(named: "Question")!)
        colleges.append(exampleCollege)
        
        let bradley = College(Name: "Bradley", Location: "Peoria", NumberOfStudents: 50000, Image: UIImage(named: "bradley")!)
        colleges.append(bradley)
        
        //colleges = [exampleCollege, bradley]
        
        let request = NSFetchRequest(entityName: "Item")
        var results : [AnyObject]?
        
        do {
            results = try coreDataDB!.executeFetchRequest(request)
        } catch {
            results = nil
        }
        
        if results != nil {
            self.items = results as! [Item]
        }
        
        self.collegeTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        collegeTableView.reloadData()
    }
    ///////////////////////////////Jimmy changed theese
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if collegeTableView.tag == 0
//        {
//            return colleges.count
//        }
//        else
//        {
            return items.count

      //  }
        
        
    }
    
    // Show data in TableView row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
//        if collegeTableView.tag == 0
//        {
//            cell.textLabel?.text = colleges[indexPath.row].name
//            cell.detailTextLabel?.text = colleges[indexPath.row].location
//
//        }
//        else
//        {
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = items[indexPath.row].location
        //cell.accessoryType = .Checkmark
        
        
        
        //cell.imageView?.image = items[indexPath.row].image as! NSData
        //}
        return cell
    }
    
    
    
    
    @IBAction func editBarButton(sender: UIBarButtonItem)
    {
        if sender.tag == 0
        {
            collegeTableView.editing = true
            sender.tag = 1
        }
        else
        {
            collegeTableView.editing = false
            sender.tag = 0
        }
    }
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {
        let addFormAlert    = UIAlertController(title: "Add College", message: nil, preferredStyle: .Alert)
        let saveButton      = UIAlertAction    (title: "Save", style: .Default) { (action: UIAlertAction) -> Void in
            let nameTextField = (addFormAlert.textFields![0] ).text
            let locationTextField = (addFormAlert.textFields![1]).text
            
            // Check if name is empty
            if (nameTextField!.isEmpty) {
                self.alertError("Unable to save", msg: "Item name can't be blank.")
            }
                // Check duplicate item name
            else if (Item.checkDuplicate(nameTextField!, inManagedObjectContext: self.coreDataDB!)) {
                self.alertError("Unable to save", msg: "There is already an item with name: \(nameTextField).")
            }
                // Save data
            else {
                
                
                // Use class "Item" to create a new CoreData object
                let newItem = Item(name: nameTextField!, image: nil, location: locationTextField!, inManagedObjectContext: self.coreDataDB!)
                
                
                // Add item to array
                self.items.append(newItem)
                
                // CoreData save
                newItem.save(self.coreDataDB!)
                
                // Reload Coredata data
                self.items = Item.fetchAll(self.coreDataDB!)
                
                // Reload TableView
                self.collegeTableView.reloadData()
            }
        }
        
        // No action, no need handler
        let cancelButton = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        
        // Show textField in alert
        addFormAlert.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "College Name"
        }
        addFormAlert.addTextFieldWithConfigurationHandler { textField in
            textField.placeholder = "College Location"
        }

        
        addFormAlert.addAction(cancelButton)
        addFormAlert.addAction(saveButton)
        presentViewController(addFormAlert, animated: true, completion: nil)
//        let alert = UIAlertController(title: "Add New College", message: nil, preferredStyle: .Alert)
//        
//        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
//            textField.placeholder = "Add College Name Here"
//        }
//        
//        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
//            textField.placeholder = "Add College Location Here"
//        }
//        
//        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
//            textField.placeholder = "Add Number of Students Here"
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
//        alert.addAction(cancelAction)
//        
//        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action) -> Void in
//            let nameTextField = alert.textFields?[0]
//            let locationTextField = alert.textFields?[1]
//            let numberOfStudentsTextField = alert.textFields?[2]
//            let image = alert.textFields?[3]
//            
//            let newCollege = College(Name: nameTextField!.text!, Location: locationTextField!.text!, NumberOfStudents: Int(numberOfStudentsTextField!.text!)!, Image: UIImage())
//            
//            if nameTextField!.text == ""
//            {
//                self.alertError("Unable to save", msg: "Item name can't be blank.")
//            }
//                // Check duplicate item name
//            else if (Item.checkDuplicate(nameTextField!.text!, inManagedObjectContext: self.coreDataDB!))
//            {
//                self.alertError("Unable to save", msg: "There is already an item with name: \(nameTextField).")
//            }
//                // Save data
//            else
//            {
//                // Use class "Item" to create a new CoreData object
//                let newItem = items(entity: nameTextField?.text, insertIntoManagedObjectContext: self.coreDataDB!)
//                
//                // Add item to array
//                self.items.append(newItem)
//                
//                // CoreData save
//                newItem.save(self.coreDataDB!)
//                
//                // Reload Coredata data
//                self.items = Item.fetchAll(self.coreDataDB!)
//                
//                // Reload TableView
//                self.collegeTableView.reloadData()
//            }
//            
//            self.colleges.append(newCollege)
//            
//            self.collegeTableView.reloadData()
//        }
//        
//        alert.addAction(addAction)
//        
//        presentViewController(alert, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
   
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            colleges.removeAtIndex(indexPath.row)
            collegeTableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        let editSwipeButton = UITableViewRowAction(style: .Default, title: "Edit Name") { (action, indexPath) in
            let currentName = self.items[indexPath.row]
            
            let alertEdit   = UIAlertController(title: "Editing item", message: "Change item name", preferredStyle: .Alert)
            let saveButton  = UIAlertAction(title: "Save", style: .Default) { (action) in
                let newItemName = (alertEdit.textFields![0] ).text
                
                // Check if name is empty
                if (newItemName!.isEmpty) {
                    self.alertError("Unable to save", msg: "College name can't be blank.")
                
                }
                    // Current Name equal New Name
                else if (currentName == newItemName) {
                    true // do nothing
                }
                    // Check duplicate item name
                else if (Item.checkDuplicate(newItemName!, inManagedObjectContext: self.coreDataDB!)) {
                    self.alertError("Unable to save", msg: "There is already an item with name: \(newItemName).")
                }
                    // Save CoreData
                else {
                    // Update item name
                    let item = Item.search("name", inManagedObjectContext: self.coreDataDB!)
                    item?.name = newItemName!
                    item?.save(self.coreDataDB!)
                    
                    // Reload Coredata data
                    self.items = Item.fetchAll(self.coreDataDB!)
                    
                    // Reload TableView
                    self.collegeTableView.reloadData()
                }
                
                // Close cell buttons
                self.collegeTableView.setEditing(false, animated: false)
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
            
            // Show textField in alert with current name value
            alertEdit.addTextFieldWithConfigurationHandler { textField in
                textField.placeholder = "Insert College"
            }
            
            alertEdit.addAction(cancelButton)
            alertEdit.addAction(saveButton)
            
            self.presentViewController(alertEdit, animated: true, completion: nil)
        }
        
        let collegeFinishedSwipe = UITableViewRowAction(style: .Default, title: "Done")
        {_,_ in
            if tableView.backgroundColor == UIColor.whiteColor()
            {
                tableView.backgroundColor = UIColor.greenColor()
            }
            else
            {
                tableView.backgroundColor = UIColor.whiteColor()
            }
            
        }
        
        let deleteSwipteButton = UITableViewRowAction(style: .Normal, title: "Delete") { (action, indexPath) in
            // Find item
            let itemDelete = self.items[indexPath.row]
            
            // Delete item in CoreData
            itemDelete.destroy(self.coreDataDB!)
            
            // Save item
            itemDelete.save(self.coreDataDB!)
            
            // Tableview always load data from "items" array.
            // If you delete a item from CoreData you need reload array data.
            self.items = Item.fetchAll(self.coreDataDB!)
            
            // Remove item from TableView
            self.collegeTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        editSwipeButton.backgroundColor = UIColor.purpleColor()
        deleteSwipteButton.backgroundColor = UIColor.redColor()
       collegeFinishedSwipe.backgroundColor = UIColor.blueColor()
        
        return [editSwipeButton, deleteSwipteButton, collegeFinishedSwipe]
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let collegeList = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(collegeList, atIndex: destinationIndexPath.row)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "pushToSecondViewController"
        {
            
            let nvc = segue.destinationViewController as! secondViewController
            let indexPath = collegeTableView.indexPathForSelectedRow!
            nvc.selectedCollege = items[indexPath.row]
        }
    }
    
    // MARK: - Helpers
    
    /// Show a alert error
    ///
    /// - parameter  title:  Title
    /// - parameter  msg:    Message
    ///
    func alertError(title: String, msg: String)
    {
        let alert    = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let okButton = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        
        alert.addAction(okButton)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
