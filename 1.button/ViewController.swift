//
//  ViewController.swift
//  1.button
//
//  Created by 陈 则西 on 15/7/19.
//  Copyright (c) 2015年 陈 则西. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentValue: Int = 0 // here we use the Int instead of int for a struct?
    var targetValue: Int = 0 //this is the target value we would like to achieve
    var score : Int = 0
    var round : Int = 0
    
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        mySlider.setThumbImage(thumbImageNormal, forState: UIControlState.Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-HighLighted")
        mySlider.setThumbImage(thumbImageHighlighted, forState: UIControlState.Highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        if let trackleLeftImage = UIImage(named: "SliderTrackLeft"){
            let trackLeftResizable = trackleLeftImage.resizableImageWithCapInsets(insets)
            mySlider.setMinimumTrackImage(trackLeftResizable, forState: UIControlState.Normal)
        }
        
        if let trackleRightImage = UIImage(named: "SliderTrackRight"){
            let trackRightResizable = trackleRightImage.resizableImageWithCapInsets(insets)
            mySlider.setMaximumTrackImage(trackRightResizable, forState: UIControlState.Normal)
        }
        
        startNewGame()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func startNewRound() {
        targetValue = 1+Int(arc4random_uniform(100))
        currentValue = 50
        mySlider.value = Float(currentValue)
        round += 1;
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0;
        round = 0;
        startNewRound()
    }
    
    @IBAction func startOver() {
        self.startNewGame()
        updateLabels()
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        view.layer.addAnimation(transition, forKey: nil)
    }

    
    @IBAction func showAlert(){
        var title : String!
        let different = abs(currentValue - targetValue);
        var points = 100 - different
        if(different == 0) {
            title = "Perfect!"
            points+=100
        } else if different <= 5 {
            title = "You almost had it!"
            if(different == 1) {
                points+=50
            }
        } else if different < 20 {
            title = "Pretty Good!"
        } else {
            title = "Not even close..."
        }
        score += points
        let messge = "You scored \(points) points!"
        
        let alert = UIAlertController(title: title, message: messge, preferredStyle: UIAlertControllerStyle.Alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> () in
            self.startNewRound()
            self.updateLabels()
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    @IBAction func sliderMoved(slider: UISlider) {
        print("The value of the slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }

}

