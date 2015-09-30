//
//  FCChallengesTableViewController.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-08-31.
//  Copyright (c) 2015 Farwa Naqi. All rights reserved.
//

import UIKit
import OAuthSwift
import AFNetworking

class FCChallengesTableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
        
    @IBAction func getUserProfile(sender: AnyObject) {
        let manager = AFHTTPRequestOperationManager();
        let defaults = NSUserDefaults.standardUserDefaults();
        let authtoken = defaults.stringForKey("AuthToken")!;
        
        let val = String(format: "Bearer %@", authtoken);
        manager.requestSerializer.setValue(val, forHTTPHeaderField: "Authorization");
        manager.GET("https://api.fitbit.com/1/user/-/profile.json", parameters: nil, success: {
                (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                print("JSON: " + responseObject.description);
            }, failure: {
                (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription);
        });
    }
    
}
