//
//  fourthViewController.swift
//  collegeBuilder
//
//  Created by student3 on 2/23/15.
//  Copyright (c) 2015 PHS. All rights reserved.
//

import UIKit

class fourthViewController: UIViewController, UIWebViewDelegate

{
    @IBOutlet var webView: UIWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var college : College!
    //we are making a variable and making it type College
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.delegate = self
        
       // var websiteURL = NSURL(string: college.url)
       // var websiteURL = NSURL(string: "http://\(college.url)")
        
      //  var urlRequest = NSURLRequest(URL: websiteURL!)
        
//        webView.loadRequest(urlRequest)
//        
//    }
//
//    func webViewDidStartLoad(webView: UIWebView)
//    {
//        activityIndicator.startAnimating()
//    }
//    func webViewDidFinishLoad(webView: UIWebView)
//    {
//        activityIndicator.stopAnimating()
//    }
//    @IBAction func dismissButton(sender: UIBarButtonItem)
//    {
//        dismissViewControllerAnimated(true, completion: nil)
//    }
//    
    
    
    
    
    
    
    
    
    
    
    
    
     func didReceiveMemoryWarning() {
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
}