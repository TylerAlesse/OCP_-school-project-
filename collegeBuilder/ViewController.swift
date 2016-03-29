//
//  ViewController.swift
//  collegeBuilder
//
//  Created by student3 on 2/4/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet var collegeTableView: UITableView!
    var colleges = [College]()
    
    let coreDataDB = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var items = [Item]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        editButtonItem().tag = 0
        
        collegeTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        items = Item.fetchAll(coreDataDB!)
        
        navigationItem.title = "My Applications"
        let isu = College(Name: "Illinois State University", Location: "Bloomington", NumberOfStudents: 100000, Image: UIImage(named: "Question")!)
        colleges.append(isu)
        
        let bradley = College(Name: "Bradley", Location: "Peoria", NumberOfStudents: 50000, Image: UIImage(named: "bradley")!)
        colleges.append(bradley)
    }
    
    override func viewWillAppear(animated: Bool)
    {
        collegeTableView.reloadData()
    }
    
        @IBAction func cellDidChange(sender: UISwitch)
    {
        
        let currentCell = collegeTableView.cellForRowAtIndexPath(NSIndexPath(forRow: sender.tag, inSection: 0))
        
        if sender.on
        {
           currentCell?.backgroundColor = UIColor.greenColor()
        }
        else
        {
            currentCell?.backgroundColor = UIColor.whiteColor()
        }
    }
    
    @IBAction func onTappedPlusButton(sender: UIBarButtonItem)
    {
        let addFormAlert    = UIAlertController(title: "Add College", message: nil, preferredStyle: .Alert)
        let saveButton      = UIAlertAction    (title: "Save", style: .Default) { (action: UIAlertAction) -> Void in
            let nameTextField = (addFormAlert.textFields![0] ).text
            
            // Check if name is empty
            if (nameTextField!.isEmpty) {
                self.alertError("Unable to save", msg: "College name can't be blank.")
            }
                // Check duplicate item name
            else if (Item.checkDuplicate(nameTextField!, inManagedObjectContext: self.coreDataDB!)) {
                self.alertError("Unable to save", msg: "There is already an college with name: \(nameTextField).")
            }
                // Save data
            else {
                // Use class "Item" to create a new CoreData object
                let newItem = Item(name: nameTextField!, inManagedObjectContext: self.coreDataDB!)
                
                // Add item to array
                self.items.append(newItem)
                
                // CoreData save
                newItem.save(self.coreDataDB!)
                
                // Reload Coredata data
                self.items = Item.fetchAll(self.coreDataDB!)
                
                // Reload TableView
                self.tableView.reloadData()
            }
        }
        
        // No action, no need handler
        let cancelButton = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        
        // Show textField in alert
        addFormAlert.addTextFieldWithConfigurationHandler { textField in
           textField.placeholder = "Insert College name"
        }
        
        addFormAlert.addAction(cancelButton)
        addFormAlert.addAction(saveButton)
        presentViewController(addFormAlert, animated: true, completion: nil)

        let alert = UIAlertController(title: "Add colleges", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add College Here"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add College's Location"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action) -> Void in
            let addCollegesTextField = (addFormAlert.textFields?[0])! as UITextField
            let addLocationTextField = (addFormAlert.textFields?[1])! as UITextField
        
            let newCollege = College(name: addCollegesTextField.text!, location: addLocationTextField.text!, numberOfStudents: 0, image: UIImage(named: "Question")!, url: "")

            self.colleges.append(newCollege)
           self.tableView.reloadData()
        }
        
        alert.addAction(addAction)
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        cell.textLabel?.text = colleges[indexPath.row].name
        cell.detailTextLabel?.text = colleges[indexPath.row].location
        return cell
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
            tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let college = colleges[sourceIndexPath.row]
        colleges.removeAtIndex(sourceIndexPath.row)
        colleges.insert(college, atIndex: destinationIndexPath.row)
    }

    
//    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
//    {
//    
//    //func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
//        let editSwipeButton = UITableViewRowAction(style: .Default, title: "Edit") { (action, indexPath) in
//            let currentName = self.items[indexPath.row].name
//            
//            let alertEdit   = UIAlertController(title: "Editing item", message: "Change item name", preferredStyle: .Alert)
//            let saveButton  = UIAlertAction(title: "Save", style: .Default) { (action) in
//                let newItemName = (alertEdit.textFields![0] ).text
//                
//                // Check if name is empty
//                if (newItemName!.isEmpty) {
//                    self.alertError("Unable to save", msg: "Item name can't be blank.")
//                }
//                    // Current Name equal New Name
//                else if (currentName == newItemName) {
//                    true // do nothing
//                }
//                    // Check duplicate item name
//                else if (Item.checkDuplicate(newItemName!, inManagedObjectContext: self.coreDataDB!)) {
//                    self.alertError("Unable to save", msg: "There is already an item with name: \(newItemName).")
//                }
//                    // Save CoreData
//                else {
//                    // Update item name
//                    let item = Item.search(currentName!, inManagedObjectContext: self.coreDataDB!)
//                    item?.name = newItemName!
//                    item?.save(self.coreDataDB!)
//                    
//                    // Reload Coredata data
//                    self.items = Item.fetchAll(self.coreDataDB!)
//                    
//                    // Reload TableView
//                    self.tableView.reloadData()
//                }
//                
//                // Close cell buttons
//                self.tableView.setEditing(false, animated: false)
//            }
//            
//            let cancelButton = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
//            
//            // Show textField in alert with current name value
//            alertEdit.addTextFieldWithConfigurationHandler { textField in
//                textField.text = currentName
//            }
//            
//            alertEdit.addAction(cancelButton)
//            alertEdit.addAction(saveButton)
//            
//            self.presentViewController(alertEdit, animated: true, completion: nil)
//        }
//        
//        let deleteSwipteButton = UITableViewRowAction(style: .Normal, title: "Delete") { (action, indexPath) in
//            // Find item
//            let itemDelete = self.items[indexPath.row]
//            
//            // Delete item in CoreData
//            itemDelete.destroy(self.coreDataDB!)
//            
//            // Save item
//            itemDelete.save(self.coreDataDB!)
//            
//            // Tableview always load data from "items" array.
//            // If you delete a item from CoreData you need reload array data.
//            self.items = Item.fetchAll(self.coreDataDB!)
//            
//            // Remove item from TableView
//            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        }
//        
//        editSwipeButton.backgroundColor    = UIColor.purpleColor()
//        deleteSwipteButton.backgroundColor = UIColor.redColor()
//        
//        return [editSwipeButton, deleteSwipteButton]
//    }
//    
//    // MARK: - Helpers
//    
//    /// Show a alert error
//    ///
//    /// - parameter  title:  Title
//    /// - parameter  msg:    Message
//    ///
//    func alertError(title: String, msg: String) {
//        let alert    = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
//        let okButton = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
//        
//        alert.addAction(okButton)
//        
//        self.presentViewController(alert, animated: true, completion: nil)
//    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//    {
//
//        
//        let secondVC = segue.destinationViewController as! secondViewController
//
//        let index = tableView.indexPathForSelectedRow?.row
//        
//        secondVC.selectedCollege = colleges[index!]
//        
//    }

}

