//
//  PageContentViewController.swift
//  FoodPin
//
//  Created by avi on 16/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subHeadingLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    
    @IBOutlet weak var indexOne: UIButton!
    @IBOutlet weak var indexTwo: UIButton!
    @IBOutlet weak var indexThree: UIButton!
    
    var index = 0
    var heading: String!
    var subHeading: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
        
        // code for page indicator
        switch index {
        case 0:
            indexOne.backgroundColor = UIColor.redColor()
            indexTwo.backgroundColor = UIColor.grayColor()
            indexThree.backgroundColor = UIColor.grayColor()
        case 1:
            indexOne.backgroundColor = UIColor.grayColor()
            indexTwo.backgroundColor = UIColor.redColor()
            indexThree.backgroundColor = UIColor.grayColor()
        case 2:
            indexOne.backgroundColor = UIColor.grayColor()
            indexTwo.backgroundColor = UIColor.grayColor()
            indexThree.backgroundColor = UIColor.redColor()
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
