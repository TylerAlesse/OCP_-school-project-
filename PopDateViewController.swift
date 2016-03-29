//
//  PopDateViewController.swift
//  OCP
//
//  Created by entre on 2/24/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit

class PopDateViewController: UIViewController
{
    @IBOutlet var datePicker: UIDatePicker!
    override convenience init()
    {
        self.init(nibName: "PopDateViewController", bundle: nil)
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    init(forTextField: UITextField)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func pick(inViewController : UIViewController, initDate : NSDate?, dataChanged : PopDatePickerCallback)
    
     typealias PopDatePickerCallback = (newDate : NSDate, forTextField : UITextField)->()


   }
