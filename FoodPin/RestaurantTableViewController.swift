//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by avi on 12/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
        "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
        "Bourke Street Bakery", "Haigh’s Chocolate", "Palomino Espresso",
        "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf",
        "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
        "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong",
        "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney",
        "Sydney", "New York", "New York", "New York", "New York", "New York",
        "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House",
        "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate",
        "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch",
        "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish",
        "Spanish", "British", "Thai"]
  
    // following fails :-/
    // var restaurantIsVisted = [Bool](count: restaurantNames.count, repeatedValues: false)
    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return restaurantNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomTableViewCell
        cell.restaurantNameLabel.text = restaurantNames[indexPath.row]
        // as of now this code displays random images. should be edited to 
        // display proper image for each restaurant
        let randomImageIndex = Int(arc4random_uniform(UInt32(restaurantImages.count)))
        cell.restaurantThumbnail.image = UIImage(named: restaurantImages[randomImageIndex])
        
        // following code shows rounded thumbnail
        cell.restaurantThumbnail.layer.cornerRadius = cell.restaurantThumbnail.frame.width / 2
        cell.restaurantThumbnail.clipsToBounds = true
        
        cell.restaurantTypeLabel.text = restaurantTypes[indexPath.row]
        cell.restaurantLocationLabel.text = restaurantLocations[indexPath.row]
        //cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark : .None
        cell.restaurantVisited.text = restaurantIsVisited[indexPath.row] ? "♥️" : ""
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "Call me may be?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        let callAction = UIAlertAction(title: "Call " + "123-000-\(indexPath.row)", style: .Default) {
            (action: UIAlertAction!) -> Void in
                let alertMessage = UIAlertController(title: "Service Unavailable", message: "Call feature not available yet", preferredStyle: .Alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                // without self.prese... following would fail. self is required.
                self.presentViewController(alertMessage, animated: true, completion: nil)
        }

        optionMenu.addAction(callAction)
        
        let actionMessageToDisplay = restaurantIsVisited[indexPath.row] ? "I have not been here 😨" : "I have been here 😄"
        
        let isVisitedAction = UIAlertAction(title: actionMessageToDisplay, style: .Default) {
            (action: UIAlertAction!) -> Void in
                if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                    let cell = cell as CustomTableViewCell
                    self.restaurantIsVisited[indexPath.row] = self.restaurantIsVisited[indexPath.row] ? false : true
                    //cell.accessoryType =  self.restaurantIsVisited[indexPath.row] ? .Checkmark : .None
                    cell.restaurantVisited.text = self.restaurantIsVisited[indexPath.row] ? "♥️" : ""
                }
        }
    
        optionMenu.addAction(isVisitedAction)
        presentViewController(optionMenu, animated: true, completion: nil)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    

    // adding delete button on swipe to left
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // looks its not possible to have swipe actions even though this method 
        // is never called. Nor it reqiures any implementation.
    }
    
    // using UITableViewRowAction (iOS 8 or after) to implement delete or other 
    // custom row actions
    // to use this, tableview(_:editActionsForRowAtIndexPath:) needs to be 
    // implemented
    // however this will remove automatically generated delete button. So we 
    // have to implement delete mechanism also
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var shareAction = UITableViewRowAction(style: .Default, title: "Share") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
                let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .ActionSheet)
                let twitterAction = UIAlertAction(title: "Twitter", style: .Default, handler: nil)
                let facebookAction = UIAlertAction(title: "Facebook", style: .Default, handler: nil)
                let emailAction = UIAlertAction(title: "email", style: .Default, handler: nil)
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
                
                shareMenu.addAction(twitterAction)
                shareMenu.addAction(facebookAction)
                shareMenu.addAction(emailAction)
                shareMenu.addAction(cancelAction)
                
                self.presentViewController(shareMenu, animated: true, completion: nil)
            }
        
        
        var deleteAction = UITableViewRowAction(style: .Default, title: "Delete") {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
                self.restaurantNames.removeAtIndex(indexPath.row)
                self.restaurantIsVisited.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        
        return [shareAction, deleteAction]
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
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
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
