//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by avi on 12/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl",
        "Petite Oyster", "For Kee Restaurant", "Po's Atelier",
        "Bourke Street Bakery", "Haigh’s Chocolate", "Palomino Espresso",
        "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf",
        "Five Leaves", "Cafe Lore", "Confessional", "Barrafina",
        "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["1", "2", "3", "4", "5", "6", "7", "8", "1", "2",
        "3", "4", "5", "6", "7", "8", "1", "2", "3", "4", "5", "6", "7", "8"]
    
    var restaurantLocations = ["G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", "633 Bourke St Sydney New South Wales 2010 Surry Hills", "412-414 George St Sydney New South Wales", "Shop 1 61 York St Sydney New South Wales", "95 1st Ave New York, NY 10003", "229 S 4th St Brooklyn, NY 11211", "445 Graham Ave Brooklyn, NY 11211", "413 Graham Ave Brooklyn, NY 11211", "18 Bedford Ave Brooklyn, NY 11222", "Sunset Park 4601 4th Ave Brooklyn, NY 11220", "308 E 6th St New York, NY 10003", "54 Frith Street London W1D 4SL United Kingdom", "10 Seymour Place London W1H 7ND United Kingdom", "2 Regency Street London SW1P 4BZ United Kingdom", "22 Charlwood Street London SW1V 2DY Pimlico"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House",
        "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate",
        "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch",
        "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish",
        "Spanish", "British", "Thai"]
  
    // following fails :-/
    // var restaurantIsVisted = [Bool](count: restaurantNames.count, repeatedValues: false)
    var restaurantIsVisited = [Bool](count: 21, repeatedValue: false)
    
    var restaurants: [Restaurant] = []
    
    var fetchResultsController: NSFetchedResultsController!
    var searchController: UISearchController!
    var searchResults: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Empty back button (in showDetail scene) or any next scene
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        //tableView.estimatedRowHeight = 80.0
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        // search bar code
        // passing nil says that results will displayed on same view, not on
        // seperate view
        searchController = UISearchController(searchResultsController: nil)
        // does what it says, fits the size into the view, within bounds
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        // When using UISearchController, it’s required to define this property 
        // on the view controller in which you want the search to be presented.
        definesPresentationContext = true
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        // to display walkthrough scenes, using PageViewController
        // so following page view will displayed at the start of the app
        // now we will display walk through only once
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasViewedWalkthrough = defaults.boolForKey("hasViewedWalkthrough")
        
        if !hasViewedWalkthrough {
            if let pageViewController = storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? PageViewController {
                presentViewController(pageViewController, animated: true, completion: nil)
            }
        }
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
        
        // the numbers rows will be different when user is searching
        // so we return number of search results
        if searchController.active {
            return searchResults.count
        }
        return restaurants.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as CustomTableViewCell
        
        // if search is active, then we will display search results as cells.
        let restaurant = (searchController.active) ? searchResults[indexPath.row] : restaurants[indexPath.row]
    
        cell.restaurantNameLabel.text = restaurant.name
        // as of now this code displays random images. should be edited to 
        // display proper image for each restaurant
        //let randomImageIndex = Int(arc4random_uniform(UInt32(restaurantImages.count)))
        //cell.restaurantThumbnail.image = UIImage(named: restaurantImages[randomImageIndex])
        cell.restaurantThumbnail.image = UIImage(data: restaurant.image)
        
        // following code shows rounded thumbnail
        cell.restaurantThumbnail.layer.cornerRadius = cell.restaurantThumbnail.frame.width / 2
        cell.restaurantThumbnail.clipsToBounds = true
        
        cell.restaurantTypeLabel.text = restaurant.type
        cell.restaurantLocationLabel.text = restaurant.location
        //cell.accessoryType = restaurantIsVisited[indexPath.row] ? .Checkmark : .None
        cell.restaurantVisited.text = restaurant.isVisited.boolValue ? "♥️" : ""
        return cell
    }

/* 
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
*/

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
                let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
                let restaurantToDelete = self.fetchResultsController.objectAtIndexPath(indexPath) as Restaurant
                managedObjectContext?.deleteObject(restaurantToDelete)
            
                var e: NSError?
                if managedObjectContext?.save(&e) != true {
                    println("Unable to delete, oops! \(e?.localizedDescription)")
                }
            }
        
        // setting background color
        shareAction.backgroundColor = UIColor(red: 255.0/255.0, green: 166.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        
        return [shareAction, deleteAction]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRestaurantDetails" {
            if let indexPath = tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as RestarurantDetailViewController
                destinationController.restaurant = restaurants[indexPath.row]
                // hide the tab bar
                destinationController.hidesBottomBarWhenPushed = true
            }
        }
    }
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // once the view is loaded (or loaded everytime, unlike viewDidLoad called
        // only first time view is loaded) hide the status bar when user swipes up
        navigationController?.hidesBarsOnSwipe = true
        
        // core data code
        // create a NSFetchRequest for restaurant entity
        let fetchRequest = NSFetchRequest(entityName: "Restaurant")
        // specify how the results want to be sorted
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
            // initiliaze NSFetchResultsController
            fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            // and specify its delegate for monitoring data changes
            fetchResultsController.delegate = self
            
            var e: NSError?
            // execute the fetch request
            var result = fetchResultsController.performFetch(&e)
            // get the restaurant objects, cast them as array of Restaurant
            restaurants = fetchResultsController.fetchedObjects as [Restaurant]
            
            if e != nil {
                println("Error while fetching: \(e?.localizedDescription)")
            }
        }
    }
    
    // following three methods are added cos app wasn't showing newly 
    // added restaurants for the author of the book. However for my verison of 
    // swift, xcode and app, these methods seem unnessecary. cos app does show 
    // new restaurants added.
    //
    // before chaging the content by controller
    // so we will tell tableView that we are gonna change the content
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    // making changes to the table
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        restaurants = controller.fetchedObjects as [Restaurant]
    }
    
    // we have changed the content!
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // search bar code
    // following is the search logic. Its simple, uses filter
    func filterContentForSearchText(searchText: String!) {
        searchResults = restaurants.filter() { (restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            let locationMatch = restaurant.location.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            return nameMatch != nil || locationMatch != nil
        }
    }
    
    // When a user selects the search bar or makes any changes inside it, 
    // this method will be called. By implementing the method, we can instruct
    // the search controller to display the search results
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */


    // makes cell non-editable when user is searching
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        if searchController.active {
            return false
        }
        return true
    }

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
