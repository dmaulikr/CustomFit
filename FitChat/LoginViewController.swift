//
//  LoginViewController.swift
//  CustomFit
//
//  Created by Farwa Naqi on 2015-09-29.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = AuthUtils.getAccessToken() {
            let storyboard = UIStoryboard(name: Storyboard.Name, bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier(Storyboard.TabBarController)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
