//
//  RestarurantDetailViewController.swift
//  FoodPin
//
//  Created by avi on 13/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

// the following class acutally should inherit UITableViewController class. 
// However it fails if done without any changes to the code
// error:  *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '-[UITableViewController loadView] loaded the "nel-69-I5f-view-q3h-T8-DJW" nib but didn't get a UITableView.'
class RestarurantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var restaurant: Restaurant!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var restaurantImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        restaurantImage.image = UIImage(named: restaurant.image)
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        // removes extra seperators:
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // sets the title of navigation bar in DetailView
        title = restaurant.name
        
        // location clips because it is way too long. In order to prevent that
        // self sizing cells can be used (iOS 8 and above)
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as DetailTableViewCell
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = restaurant.isVisited ? "Yes, I have been here!" : "No"
        case 4:
            cell.fieldLabel.text = "☎️"
            cell.valueLabel.text = restaurant.phoneNum
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // set it to false, so that even user swipes down, the status bar 
        // remains visible. When table list view is loaded back, it will set 
        // to true. so that navbar will be hidden when user swipes down
        navigationController?.hidesBarsOnSwipe = false
        // keep it visible always, in this view. So even it was hidden in table 
        // list view, it will be visible here again
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // empty method, but to tell app that view can be closed and this 
    // view will be back. this is called unwind segue
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showReview" {
            let destinationViewController = segue.destinationViewController as ReviewViewController
            destinationViewController.backgroundImage = restaurant.image
        }
        if segue.identifier == "showShare" {
            let destinationViewController = segue.destinationViewController as ShareViewController
            destinationViewController.backgroundImage = restaurant.image
        }
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
