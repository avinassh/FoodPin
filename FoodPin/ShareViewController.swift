//
//  ShareViewController.swift
//  FoodPin
//
//  Created by avi on 15/02/15.
//  Copyright (c) 2015 avi. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var fbShareButton: UIButton!
    @IBOutlet weak var twitterShareButton: UIButton!
    @IBOutlet weak var messageShareButton: UIButton!
    @IBOutlet weak var emailShareButton: UIButton!
    
    var backgroundImage: NSData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        backgroundImageView.image = UIImage(data: backgroundImage)
        var blurEffect = UIBlurEffect(style: .Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let translateDown = CGAffineTransformMakeTranslation(0, 500)
        fbShareButton.transform = translateDown
        messageShareButton.transform = translateDown
        
        let translateUp = CGAffineTransformMakeTranslation(0, -2000)
        twitterShareButton.transform = translateUp
        emailShareButton.transform = translateUp
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(2.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: {
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.twitterShareButton.transform = translate
            self.fbShareButton.transform = translate
            self.emailShareButton.transform = translate
            self.messageShareButton.transform = translate
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
