//
//  FCFriendsTableViewController.swift
//  FitChat
//
//  Created by Farwa Naqi on 2015-09-29.
//  Copyright © 2015 Farwa Naqi. All rights reserved.
//

import UIKit
import AFNetworking

class FCFriendsTableViewController: UITableViewController {
    
    let FriendTableViewCellReuseId :String = "FriendCellReuseId";
    var friends: NSArray = [];

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.navigationItem.title = "Friends";
        let authtoken:String = NSUserDefaults.standardUserDefaults().stringForKey("AuthToken")!;
        let manager = AFHTTPRequestOperationManager();
        
        let val = String(format: "Bearer %@", authtoken);
        manager.requestSerializer.setValue(val, forHTTPHeaderField: "Authorization");
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type");
        manager.GET("https://api.fitbit.com/1/user/-/friends.json", parameters: nil, success: {
            (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
            if let jsonDict = responseObject as? NSDictionary {
                self.friends = jsonDict.objectForKey("friends") as! NSArray;
                self.tableView.reloadData();
            }
            }, failure: {
                (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: " + error.localizedDescription);
        });
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count;
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:FCFriendListTableViewCell = tableView.dequeueReusableCellWithIdentifier(FriendTableViewCellReuseId, forIndexPath: indexPath) as! FCFriendListTableViewCell;
        
        let data:NSDictionary = self.friends.objectAtIndex(indexPath.row).objectForKey("user") as! NSDictionary;
        let nickname:String = data.objectForKey("displayName") as! String!;
        
        cell.nicknameLabel!.text = nickname;
        
        let avatarStr:String = data.objectForKey("avatar") as! String!;
        let url:NSURL = NSURL(string: avatarStr)!;
//        print(url);
        if let data = NSData(contentsOfURL: url) {
            cell.avatar!.image = UIImage(data: data);
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
