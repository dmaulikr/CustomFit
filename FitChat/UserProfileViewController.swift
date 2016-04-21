//
//  UserProfileViewController.swift
//  CustomFit
//
//  Created by Farwa Naqi on 2015-08-31.
//  Copyright (c) 2015 Farwa Naqi. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avgStepsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FitbitClient.sharedInstance.getUserProfile(completion: { profile, error in
            dispatch_async(dispatch_get_main_queue(), {
                if let error = error {
                    self.showAlertView(error.rawValue, message: "")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                    return
                }
                self.setUserProfile(profile)
            })
        })
    }
    
    func showAlertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: {
            self.navigationController?.popToRootViewControllerAnimated(true)
        })
    }
    
    func setUserProfile(profile: UserProfile?) {
        guard let profile = profile else {
            self.showAlertView("Profile Not Found", message: "Error occurred fetching profile")
            navigationController?.popToRootViewControllerAnimated(true)
            return
        }
        
        self.nameLabel.text = profile.fullName ?? "Unknown"
        if let steps = profile.averageDailySteps {
            self.avgStepsLabel.text = "\(steps) average daily steps"
        }
        
        if let imagePath = profile.avatar, let url = NSURL(string: imagePath) {
            if let image = url.getCachedImage() {
                self.avatar.image = image
            } else {
                url.fetchImage({
                    image in
                    self.avatar.image = image
                })
            }
        }
    }
}
