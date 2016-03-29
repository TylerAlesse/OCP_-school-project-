//
//  fourthViewController.swift
//  collegeBuilder
//
//  Created by student3 on 2/20/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit

class thirdViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    let imagePicker = UIImagePickerController()
    //to get a description of what something is doing press option and hold it over what you want to know

    @IBAction func unButtonTapped(sender: AnyObject)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func onLibraryTapped(sender: AnyObject)
    {
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet var myImageView: UIImageView!
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        imagePicker.dismissViewControllerAnimated(true, completion:
        {
            var selectedImage = info[UIImagePickerControllerOriginalImage] as UIImage
            self.myImageView.image = selectedImage
        })
        var selectedImage = info[UIImagePickerControllerOriginalImage] as UIImage
        myImageView.image = selectedImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

