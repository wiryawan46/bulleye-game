//
//  ViewController.swift
//  BullEye
//
//  Created by Manggala Pramuditya Wiryawan on 6/7/17.
//  Copyright © 2017 wiryawan. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewGame()
        updateLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func showAlert() {
        
        let difference = abs(currentValue - targetValue)
        var points = 100 - difference
        
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
//        let message = "The value of the slider is : \(currentValue)" +
//                        "\nThe target value is: \(targetValue)" +
//                        "\nThe difference is: \(difference)"
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: { action in
                                            self.startNewRound()
                                            self.updateLabel()
                                            })
        
        alert.addAction(action)
        
        // Here you make alert visible
        present(alert, animated: true, completion: nil)
    
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        //print("The value of the slider is now : \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabel()
        
        let transation = CATransition()
        transation.type = kCATransitionFade
        transation.duration = 1
        transation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transation, forKey: nil)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = lroundf(slider.value)
        slider.value = Float(currentValue)
    }
    
    func updateLabel() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }

}

