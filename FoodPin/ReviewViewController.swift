//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by avi on 14/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dialogView: UIView!
    
    var backgroundImage: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // sets the background to the restarunat's image. this data has been 
        // sent by detail view, in prepareSegue
        backgroundImageView.image = UIImage(data: backgroundImage)
        // following lines add blur effect
        var blurEffect = UIBlurEffect(style: .Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // scales down the view when loaded. and then we use grow effect
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        // move the dialog down and out of the view, for slide up effect
        let translate = CGAffineTransformMakeTranslation(0, 500)
        // combine both the effects:
        dialogView.transform = CGAffineTransformConcat(scale, translate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        // following lines add grow effect to the scaled down version of dialogview
        // UIView.animateWithDuration(0.7, delay: 0.0, options: nil, animations: {
        // spring animation
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: {
                let scale = CGAffineTransformMakeScale(1.0, 1.0)
                let translate = CGAffineTransformMakeTranslation(0, 0)
                self.dialogView.transform = CGAffineTransformConcat(scale, translate)
            }, completion: nil)
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
