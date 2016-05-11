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
    
    var secondItems = [SecondVCItem]()
    
    override func viewDidLoad()
    {
        print("ok")
        super.viewDidLoad()
          navigationItem.title = "My Applications"
        self.collegeTableView.tableFooterView = UIView()
        
        
//        let exampleCollege = College(Name: "Example College", Location: "Unknown Location", NumberOfStudents: 100000, Image: UIImage(named: "Question")!)
//        colleges.append(exampleCollege)
        
//        let bradley = College(Name: "Bradley", Location: "Peoria", NumberOfStudents: 50000, Image: UIImage(named: "bradley")!)
//        colleges.append(bradley)
        
        
//        colleges = [exampleCollege]
        
        self.loadData()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.loadData()
    }
    
    private func loadData() {
        let request = NSFetchRequest(entityName: String(SecondVCItem))
        
        do {
            let results = try coreDataDB?.executeFetchRequest(request) as! [SecondVCItem]
            secondItems = results
        } catch {
            print("error")
        }
        
        if secondItems.count == 0 {
            self.addFakeData()
        }
        
        self.collegeTableView.reloadData()
    }
    
    private func addFakeData() {
        // Use class "Item" to create a new CoreData object
        let secondVCItem = SecondVCItem(teacherRec1: "Mr. Harper", teacherRec2: "Ms. Harper", teacherRec3: "Dr. Harper", username: "Student123", password: "password123", datepickertextfield: " August 22", reqTesting: "ACT", numberOfEssays: "2", letterOrForm: NSNumber(bool: false), commonApp: NSNumber(bool: false), collegeImage: UIImage(named: "Harper"), location: "Illinois", name: "Harper", inManagedObjectContext: self.coreDataDB!)
        
        
        // Add item to array
        self.secondItems.append(secondVCItem)
        
        // CoreData save
        secondVCItem.save(self.coreDataDB!)
        
        // Reload Coredata data
        self.secondItems = SecondVCItem.fetchAll(self.coreDataDB!)
        
        // Reload TableView
        self.collegeTableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool)
    {
    
        collegeTableView.reloadData()
    }
    ///////////////////////////////Jimmy changed these
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
//        if collegeTableView.tag == 0
//        {
//            return colleges.count
//        }
//        else
//        {
            return secondItems.count

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
        cell.textLabel?.text = secondItems[indexPath.row].name
        cell.detailTextLabel?.text = secondItems[indexPath.row].location
        //cell.accessoryType = .Checkmark
        //cell.accessoryType = .Checkmark
        
        if self.secondItems[indexPath.row].imageView == nil {
            cell.imageView?.image = UIImage(named: "Question")
        } else {
            cell.imageView?.image = UIImage(data: secondItems[indexPath.row].imageView!)
        }
        
        
//
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
                let secondVCItem = SecondVCItem(teacherRec1: "", teacherRec2: "", teacherRec3: "", username: "", password: "", datepickertextfield: "", reqTesting: "", numberOfEssays: "", letterOrForm: NSNumber(bool: false), commonApp: NSNumber(bool: false), collegeImage: UIImage(named: "Question"), location: locationTextField!, name: nameTextField!, inManagedObjectContext: self.coreDataDB!)
                
                
                // Add item to array
                self.secondItems.append(secondVCItem)
                
                // CoreData save
                secondVCItem.save(self.coreDataDB!)
                
                // Reload Coredata data
                self.secondItems = SecondVCItem.fetchAll(self.coreDataDB!)
                
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
    
    
    //beginning of swipe actions
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?
    {
        
        let editSwipeButton = UITableViewRowAction(style: .Default, title: "Edit Name") { (action, indexPath) in
            let currentName = self.secondItems[indexPath.row]
            
            let alertEdit = UIAlertController(title: "Editing item", message: "Change item name", preferredStyle: .Alert)
            let saveButton = UIAlertAction(title: "Save", style: .Default) { (action) in
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
                    let itemTwo = SecondVCItem.search("name", inManagedObjectContext: self.coreDataDB!)
                    itemTwo?.name = newItemName!
                    itemTwo?.save(self.coreDataDB!)
                    
                    // Reload Coredata data
                    self.secondItems = SecondVCItem.fetchAll(self.coreDataDB!)
                    
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
        { (action, indexPath) in
            
            let section = indexPath.section
            let numberOfRows = tableView.numberOfRowsInSection(section)
            for row in 0..<numberOfRows {
                if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) {
                    cell.accessoryType = row == indexPath.row ? .Checkmark : .None
                }
            }
//           let itemDone = self.secondItems[indexPath.row]
//            
//            if cell.accessoryType == nil
//            {
//            itemDone.accessibilityActivate()
//            }
//            else
//            {
//            itemDone.accessibilityDecrement()
//            }
        }
        
        let deleteSwipedButton = UITableViewRowAction(style: .Normal, title: "Delete") { (action, indexPath) in
            
            let recAlert = UIAlertController(title: "Are You Sure You Want To delete \(self.secondItems[indexPath.row].name!)", message: nil, preferredStyle: UIAlertControllerStyle.Alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            recAlert.addAction(cancelAction)
            
            let addAction = UIAlertAction(title: "Delete", style: .Default)
        {(action) -> Void in
            // Find item
            let itemDelete = self.secondItems[indexPath.row]
            
            // Delete item in CoreData
            SecondVCItem.destroy(self.coreDataDB!, object: itemDelete)
            
            // Save item
            itemDelete.save(self.coreDataDB!)
            
            // Tableview always load data from "items" array.
            // If you delete a item from CoreData you need reload array data.
            self.secondItems = SecondVCItem.fetchAll(self.coreDataDB!)
            
            // Remove item from TableView
            self.collegeTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
            recAlert.addAction(addAction)
            self.presentViewController(recAlert, animated: true, completion: nil)
        }
        
        editSwipeButton.backgroundColor = UIColor.purpleColor()
        deleteSwipedButton.backgroundColor = UIColor.redColor()
       collegeFinishedSwipe.backgroundColor = UIColor.blueColor()
        
        //Took out editSwipteButton
        
        return [deleteSwipedButton]
      //  return [UITableViewRowAction()]

    }
    //end of swipe actions
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
            
            nvc.selectedCollege = secondItems[indexPath.row]
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
