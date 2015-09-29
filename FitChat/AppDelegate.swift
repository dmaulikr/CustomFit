//
//  AppDelegate.swift
//  FitChat
//
//  Created by farwa on 2015-08-31.
//  Copyright (c) 2015 Farwa Naqi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        exchangeCodeInURL(url);
        return true
    }
    
    func exchangeCodeInURL(codeURL : NSURL) {
        if let code = codeURL.query {
            let request = NSMutableURLRequest(URL: NSURL(string: "https://api.fitbit.com/oauth2/token?client_id=229VK8&&client_secret=633c9d1ecad10e7b36f733d5ede60c82grant_type=authorization_code&redirect_uri=fitbitclient://")!)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                if let httpResponse = response as? NSHTTPURLResponse {
                    var jsonError: NSError?
                    if let rootObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String : AnyObject], token = rootObject["access_token"] as? String {
                        NSLog(token);
                    }
                }
            }).resume()
        }
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

