//
//  FCChallengesTableViewController.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-08-31.
//  Copyright (c) 2015 Farwa Naqi. All rights reserved.
//

import UIKit
import OAuthSwift

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
    
    func doOAuthFitbit(){
        let oauthswift = OAuth2Swift(consumerKey: "229VK8",
                                  consumerSecret: "633c9d1ecad10e7b36f733d5ede60c82",
                                    authorizeUrl: "https://www.fitbit.com/oauth2/authorize",
                                  accessTokenUrl: "https://api.fitbit.com/oauth2/token",
                                    responseType: "token");
        oauthswift.authorizeWithCallbackURL(
            NSURL(string: "fitbitclient://")!,
            scope: "activity%20nutrition%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight",
            state: "",
            params: [:],
            success: {
                credential, response, parameters in
                print(credential);
                self.showAlertView("Fitbit", message: "oauth_token:\(credential.oauth_token)")
            },
            failure: {
                (error:NSError!) -> Void in print(error.localizedDescription)
        });
    }
    
    @IBAction func request(sender: AnyObject) {
        doOAuthFitbit();
    }
}
