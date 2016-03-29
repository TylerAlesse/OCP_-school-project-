//
//  mapKitViewController.swift
//  collegeBuilder
//
//  Created by student3 on 2/27/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit
import MapKit

class mapKitViewController: UIViewController, UIActionSheetDelegate
{

    @IBOutlet var mapKitView: MKMapView!
    
    var college : College!

    var locations : [CLPlacemark]!
    
    @IBOutlet var searchTextField: UITextField!
    @IBAction func searchButtonTapped(sender: AnyObject)
    {
        geocodeLocation(searchTextField.text!)
        searchTextField.resignFirstResponder()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       // geocodeLocation(college.location)
    }
    
    func geocodeLocation(location: String)
    {
        let geocode = CLGeocoder()
        geocode.geocodeAddressString(location, completionHandler: { (objects, error) -> Void in
            if error != nil
            {
                print(error)
            }
            else
            {
                self.createActionSheet(objects! as [CLPlacemark])
                self.locations = objects! as [CLPlacemark]
            }
        })
    }


    
    func createActionSheet(placemarks: [CLPlacemark])
    {
     let actionsheet = UIActionSheet(title: "Locations", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil)
        
     for placemark in placemarks
        {
            actionsheet.addButtonWithTitle(placemark.locality)
        }
        
        actionsheet.showInView(view)
    }
    
    
    
     func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int)
    {
        let location = locations[buttonIndex - 1].location
        
        mapKitView.setRegion(MKCoordinateRegionMake(location!.coordinate, MKCoordinateSpanMake(1.0, 1.0)), animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location!.coordinate
        
        mapKitView.addAnnotation(pin)
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


