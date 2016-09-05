//
//  EnderecoViewController.swift
//  TesteWaze
//
//  Created by Edgar Junior on 9/5/16.
//  Copyright © 2016 Edgar Junior. All rights reserved.
//

import UIKit

class EnderecoViewController: UIViewController {

    @IBOutlet weak var enderecoField: UITextField!
    @IBAction func AbrirWaze_Click(sender: AnyObject)
    {
        var url : NSString = enderecoField.text!
        url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let urlQuery = NSURL(string: url as String)
        let urlStr:NSString = NSString(format: "waze://?q=%@", urlQuery!)
        
        UIApplication.sharedApplication().openURL(NSURL(string: urlStr as String)!)
        UIApplication.sharedApplication().idleTimerDisabled = true

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
