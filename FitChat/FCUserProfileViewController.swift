//
//  FCUserProfileViewController.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-08-31.
//  Copyright (c) 2015 Farwa Naqi. All rights reserved.
//

import UIKit
import OAuthSwift
import AFNetworking

class FCUserProfileViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avgStepsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        // If page is appearing before authentication has occurred, return immediately
        let defaults = NSUserDefaults.standardUserDefaults();
        if defaults.stringForKey(Constants.UserDefaultKey.AuthToken) == nil {
            return;
        }
        
        self.getUserProfile();
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
    
    func getUserProfile() {
        let manager = AFHTTPRequestOperationManager();
        let defaults = NSUserDefaults.standardUserDefaults();
        let authToken = defaults.stringForKey(Constants.UserDefaultKey.AuthToken)!;
        
        let val = String(format: "Bearer %@", authToken);
        manager.requestSerializer.setValue(val, forHTTPHeaderField: "Authorization");
        manager.GET("https://api.fitbit.com/1/user/-/profile.json", parameters: nil, success: {
                (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                if let jsonDict = responseObject as? NSDictionary {
                    let userInfo = jsonDict.objectForKey("user");
                    self.nameLabel.text = userInfo?.objectForKey("fullName") as? String;
                    let avatarStr:String = (userInfo?.objectForKey("avatar") as? String)!;
                    let url:NSURL = NSURL(string: avatarStr)!;
                    if let data = NSData(contentsOfURL: url) {
                        self.avatar.image = UIImage(data: data);
                    }
                    let steps = userInfo?.objectForKey("averageDailySteps") as! NSNumber;
                    self.avgStepsLabel.text = String(format: "Average Daily Steps: %@", steps);
                }
            }, failure: {
                (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription);
        });
        
        
    }
    
}
