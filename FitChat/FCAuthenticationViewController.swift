//
//  FCAuthenticationViewController.swift
//  FitChat
//
//  Created by farwa on 2015-09-29.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import UIKit
import OAuthSwift

class FCAuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func requestFitbitAccess(sender: AnyObject) {
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
                let defaults = NSUserDefaults.standardUserDefaults();
                defaults.setObject(credential.oauth_token, forKey: "AuthToken");
                self.dismissViewControllerAnimated(true, completion: nil);
            },
            failure: {
                (error:NSError!) -> Void in print(error.localizedDescription)
                // TODO-Show error
        });
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
