//
//  FCChallengesTableViewController.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-08-31.
//  Copyright (c) 2015 Farwa Naqi. All rights reserved.
//

import UIKit

class FCChallengesTableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestFitbitAccess() {
        let authURL = NSURL(string: "https://www.fitbit.com/oauth2/authorize?client_id=229VK8&redirect_uri=fitbitclient://&scope=activity,heartrate,profile,social")
        UIApplication.sharedApplication().openURL(authURL!)
    }
    
    @IBAction func request(sender: AnyObject) {
        requestFitbitAccess();
    }
}
