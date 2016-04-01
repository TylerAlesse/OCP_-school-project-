//
//  secondViewController.swift
//  collegeBuilder
//
//  Created by student3 on 2/11/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit
import CoreData

class secondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var recTextField1: UITextField!
    @IBOutlet var recTextField2: UITextField!
    @IBOutlet var recTextField3: UITextField!
    @IBOutlet var recButton1: UIButton!
    @IBOutlet var recButton2: UIButton!
    @IBOutlet var recButton3: UIButton!
    
    @IBOutlet var editLocationButtonTapped: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet var essayNumber: UITextField!
    @IBOutlet var letterOrForm: UISegmentedControl!
    @IBOutlet var requiredTesting: UITextField!
    @IBOutlet var commonApp: UISegmentedControl!
    @IBOutlet var imageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    var selectedCollege : Item!
    
    @IBOutlet var locationEditingTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
  

    
    
    let coreDataDB = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    
    var items:SecondVCItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let i = items {
            usernameTextField.text = "\(i.username)"
            passwordTextField.text = "\(i.password)"
            recTextField1.text = "\(i.teacherRec1)"
            recTextField2.text = "\(i.teacherRec2)"
            recTextField3.text = "\(i.teacherRec3)"
            essayNumber.text = "\(i.numberOfEssays)"
            requiredTesting.text = "\(i.reqTesting)"
          //  dateTextField.text = "\(i.datepicker)"
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext : NSManagedObjectContext = appDelegate.managedObjectContext!
        var fetchRequest = NSFetchRequest(entityName: "SecondVCItem")
        fetchRequest.returnsObjectsAsFaults = false;
        
        
//      var results: NSArray = managedContext.executeFetchRequest(fetchRequest, error: nil)!
//        var logsArray = [""]
//        
//        for res in results {
//            var username = "\(usernameTextField.text)"
//            var password = "\(passwordTextField.text)"
//            logsArray.append(username)
//            logsArray.append(password)
//      }
        
        imagePicker.delegate = self
        dateTextField.enabled = false
        
        locationEditingTextField.text = selectedCollege.location
        
        if let collegeImage = selectedCollege.image {
            let collegeImageUI = UIImage(data: collegeImage)
            imageView.image = collegeImageUI
        }
        
//        let request = NSFetchRequest(entityName: "SecondVCItem")
//        var results : [AnyObject]?
//        
//        do {
//            results = try coreDataDB!.executeFetchRequest(request)
//        } catch {
//            results = nil
//        }
//        
//        if results != nil {
//            self.items = results as! [SecondVCItem]
//        }

        
        navigationItem.title = selectedCollege.name
        
        locationEditingTextField.enabled = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        if items == nil
    {
        let storeDescription = NSEntityDescription.entityForName("SecondVCItem", inManagedObjectContext: coreDataDB!)
        var items = SecondVCItem(entity: storeDescription!, insertIntoManagedObjectContext: coreDataDB!)
    }
        items?.username = (usernameTextField.text!)
        items?.password = (passwordTextField.text!)
        items?.teacherRec1 = (recTextField1.text!)
        items?.teacherRec2 = (recTextField2.text!)
        items?.teacherRec3 = (recTextField3.text!)
        items?.numberOfEssays = (essayNumber.text!)
        items?.reqTesting = (requiredTesting.text!)
       // items?.datepicker = (dateTextField.text!)
        //
        var error: NSError?
        
        do { try coreDataDB?.save() }
        catch let error1 as NSError { error = error1 }
        
        if let err = error {
            let a = UIAlertView(title: "ERROR", message: err.localizedFailureReason, delegate: nil, cancelButtonTitle: "OK")
            a.show()
        } else {
            let a = UIAlertView(title: "SUCCESS", message: "Your College info is saved!", delegate: nil, cancelButtonTitle: "OK")
            a.show()
//            usernameTextField.text = ""
//            passwordTextField.text = ""
//            requiredTesting.text = ""
//            essayNumber.text = ""
//            recTextField1.text = ""
//            recTextField2.text = ""
//            recTextField3.text = ""
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
//    @IBAction func saveButton(sender: UIButton) {
//        let newItem = SecondVCItem(teacherRec1: recTextField1.text!, teacherRec2: recTextField2.text!, teacherRec3: recTextField3.text!, username: usernameTextField.text!, password: passwordTextField.text!, datepicker: datePicker, datepickertextfield: dateTextField.text!, reqTesting: requiredTesting.text!, numberOfEssays: essayNumber.text!, letterOrForm: letterOrForm.selectedSegmentIndex, commonApp: commonApp.selectedSegmentIndex, image: UIImage(named: "Question"), location: locationEditingTextField.text!, inManagedObjectContext: self.coreDataDB!)
//        
//        self.items.append(newItem)
//
//        // CoreData save
//        
//        newItem.save(self.coreDataDB!)
//        
//        let username = "\(usernameTextField.text)"
//        let password = "\(passwordTextField.text)"
//        let numberOfEssays = "\(essayNumber.text)"
//
//        usernameTextField.text = username
//        passwordTextField.text = password
//        essayNumber.text = numberOfEssays
//        navigationItem.title = selectedCollege.name
//
//        // Reload Coredata data
//       // self.items = SecondVCItem().fetchAll(self.coreDataDB!)
//        
//        
//        //self.items = SecondVCItem().fetchAll(self.coreDataDB!)
//        //func fetchAll(managedObjectContext: NSManagedObjectContext) -> [SecondVCItem]
//        
//        self.items = SecondVCItem.fetchAll(self.coreDataDB!)
//        
//        
//        
//        // Reload TableView
//        //self.collegeTableView.reloadData()
//        
//
//   }
    
    @IBAction func textFieldEditingDate(sender: UITextField) {
        let datePicker : UIDatePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    @IBAction func datePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
 
    @IBAction func onTappedTeacherRec(sender: UIButton) {
        let recAlert = UIAlertController(title: "Add Teacher Recs", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
            recAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in textField.placeholder = "Add First Teacher Name" }
            recAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in textField.placeholder = "Add Second Teacher Name" }
            recAlert.addTextFieldWithConfigurationHandler { (textField) -> Void in textField.placeholder = "Add Third Teacher Name" }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        recAlert.addAction(cancelAction)
               
        let addAction = UIAlertAction(title: "Add Teachers", style: .Default)
        { (action) -> Void in
            let firstTeacherField = (recAlert.textFields?[0])! as UITextField
            let secondTeacherField = (recAlert.textFields?[1])! as UITextField
            let thirdTeacherField = (recAlert.textFields?[2])! as UITextField
            
            if firstTeacherField.text == "" {
                self.recTextField1.hidden = true
                self.recButton1.hidden = true
            } else {
                self.recTextField1.hidden = false
                self.recTextField1.text = firstTeacherField.text
                self.recButton1.hidden = false
            }
            
            if  secondTeacherField.text == "" {
                self.recTextField2.hidden = true
                self.recButton2.hidden = true
            } else {
                self.recTextField2.hidden = false
                self.recTextField2.text = secondTeacherField.text
                self.recButton2.hidden = false
            }
            
            if thirdTeacherField.text == "" {
                self.recTextField3.hidden = true
                self.recTextField3.text = thirdTeacherField.text
                self.recButton3.hidden = true
            } else {
                self.recTextField3.hidden = false
                self.recTextField3.text = thirdTeacherField.text
                self.recButton3.hidden  = false
            }
            
            firstTeacherField.text = self.recTextField1.text
            secondTeacherField.text = self.recTextField2.text
            thirdTeacherField.text = self.recTextField3.text
        }
        recAlert.addAction(addAction)
        self.presentViewController(recAlert, animated: true, completion: nil)
    }
    
    @IBAction func editRec1(sender: UIButton) {
        if recTextField1.enabled == false {
            recButton1.setTitle("Save", forState: UIControlState.Normal)
            recTextField1.enabled = true
        } else {
            recTextField1.enabled = false
            recButton1.setTitle("Edit", forState: UIControlState.Normal)
            //selectedCollege.location = recTextField1.text!
        }
    }
    
    @IBAction func editRec2(sender: UIButton) {
        if recTextField2.enabled == false {
            recButton2.setTitle("Save", forState: UIControlState.Normal)
            recTextField2.enabled = true
        } else {
            recTextField2.enabled = false
            recButton2.setTitle("Edit", forState: UIControlState.Normal)
            //selectedCollege.location = recTextField2.text!
        }
    }
    
    @IBAction func editRec3(sender: UIButton) {
        if recTextField3.enabled == false {
            recButton3.setTitle("Save", forState: UIControlState.Normal)
            recTextField3.enabled = true
        } else {
            recTextField3.enabled = false
            recButton3.setTitle("Edit", forState: UIControlState.Normal)
            //selectedCollege.location = recTextField3.text!
        }
    }
    
    func dismissKeyboard() { view.endEditing(true) }
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
     
    @IBAction func editLocationButtonTapped(sender: UIButton) {
        if locationEditingTextField.enabled == false
        {
            editLocationButtonTapped.setTitle("Save new location", forState: UIControlState.Normal)
            locationEditingTextField.enabled = true
        }
        else
        {
            locationEditingTextField.enabled = false
            editLocationButtonTapped.setTitle("Edit Location", forState: UIControlState.Normal)
            selectedCollege.location = locationEditingTextField.text!
            
        }
    }
    
    @IBAction func editImage(sender: UIButton) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: {
                let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                self.imageView.image = selectedImage
        })
    }
}