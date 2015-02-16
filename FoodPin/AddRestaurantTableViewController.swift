//
//  AddRestaurantTableViewController.swift
//  FoodPin
//
//  Created by avi on 15/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField:UITextField!
    @IBOutlet weak var typeTextField:UITextField!
    @IBOutlet weak var locationTextField:UITextField!
    @IBOutlet weak var yesButton:UIButton!
    @IBOutlet weak var noButton:UIButton!
    
    var restaurant: Restaurant!
    
    @IBAction func printRestaurants(sender: UIButton) {
        var visited: Bool!
        if sender == noButton {
            yesButton.backgroundColor = UIColor.grayColor()
            noButton.backgroundColor = UIColor.redColor()
            visited = false
        } else {
            yesButton.backgroundColor = UIColor.redColor()
            noButton.backgroundColor = UIColor.grayColor()
            visited = true
        }
        
        // unwrapping varibles
        // eww this is ugly
        if let name = nameTextField.text {
            if let type = typeTextField.text {
                if let location = locationTextField.text {
                    // CoreData Code
                    // first get a managed object context
                    if let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext {
                        // Create a managed object for the Restaurant entity
                        restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as Restaurant
                        restaurant.name = name
                        restaurant.type = type
                        restaurant.location = location
                        restaurant.isVisited = visited
                        restaurant.image = UIImagePNGRepresentation(imageView.image)
                        
                        var e: NSError?
                        // save the object in the datastore
                        if managedObjectContext.save(&e) != true {
                            println("inster error: \(e?.localizedDescription)")
                            return
                        }
                    }
                }
            }
        }
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    
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
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // after selecting a photo from image picker, the status bar color changes back to black. 
    // Mostly iOS 8 bug.
    // the following should fix it, but its not working
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    // MARK: - Table view data source

    // we don't need following methods, since we are using static tables
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    */
    
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
