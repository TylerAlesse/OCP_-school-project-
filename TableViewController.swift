//
//  TableViewController.swift
//  OCP
//
//  Created by entre on 2/29/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var popupDatepicker: UIDatePicker!
    
    var datePickerHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePickerChanged()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func datePickerChanged () {
        detailLabel.text = NSDateFormatter.localizedStringFromDate(popupDatepicker.date, dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            toggleDatepicker()
        }
    }
    
    func toggleDatepicker() {
        
        datePickerHidden = !datePickerHidden
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if datePickerHidden && indexPath.section == 0 && indexPath.row == 1 {
            return 0
        }
        else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    @IBAction func datePickerValue(sender: UIDatePicker) {
        datePickerChanged()
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "MySegue"
//        {
//            
//            let segue = segue.destinationViewController as! secondViewController
//            let dateValue = datePickerValue(popupDatepicker)
//            segue.selectedCollege = Item[dateValue.row]
//        }
//
//    }

}
