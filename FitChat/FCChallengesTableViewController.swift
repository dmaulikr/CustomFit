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
    
    var credential: OAuthSwiftCredential!;

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
                self.credential = credential;
            },
            failure: {
                (error:NSError!) -> Void in print(error.localizedDescription)
        });
    }
    
    @IBAction func request(sender: AnyObject) {
        doOAuthFitbit();
    }
    
    @IBAction func getUserProfile(sender: AnyObject) {
        let manager = AFHTTPRequestOperationManager();
        print(self.credential.oauth_token);
        let val = String(format: "Bearer %@", self.credential.oauth_token);
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
