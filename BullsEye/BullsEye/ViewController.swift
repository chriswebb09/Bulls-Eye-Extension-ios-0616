//
//  ViewController.swift
//  BullsEye
//
//  Created by Chris Webb on 5/13/16.
//  Copyright © 2016 Chris Webb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var firstSliderMinLabel: UILabel!
    @IBOutlet weak var firstSliderMaxLabel: UILabel!
    @IBOutlet weak var secondSliderMinLabel: UILabel!
    @IBOutlet weak var secondSliderMaxLabel: UILabel!
    
    var currentValue: Int = 0
    var targetValue: Int = 0
    var operatedValue: Int = 0
    var score : Int = 0
    var round : Int = 0
    var operationalIndex : Int = 0
    var firstSliderMidpoint : Float = 0
    var secondSliderMidpoint : Float = 0
    var operational : Int = 0
    var calculateVariableOne : Int = 0
    var calculateVariableTwo : Int = 0
    var calculatedValue : Int = 0
    var firstSliderRandomizer : Int = 0
    var secondSliderRandomizer : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        firstSlider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        firstSlider.setThumbImage(thumbImageHighlighted, forState: .Highlighted);
        
        let insets = UIEdgeInsets(top: 0, left:14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
                trackLeftImage.resizableImageWithCapInsets(insets)
            firstSlider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            firstSlider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        secondSlider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        secondSlider.setThumbImage(thumbImageHighlighted, forState: .Highlighted);
        
        if let trackOperatorLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackOperatorLeftResizable =
                trackOperatorLeftImage.resizableImageWithCapInsets(insets)
            secondSlider.setMinimumTrackImage(trackOperatorLeftResizable, forState: .Normal)
        }
        
        if let trackOperatorRightImage = UIImage(named: "SliderTrackRight") {
            let trackOperatorRightResizable = trackOperatorRightImage.resizableImageWithCapInsets(insets)
            secondSlider.setMaximumTrackImage(trackOperatorRightResizable, forState: .Normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: "Score",
                                      message: message, preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) in
            self.startNewRound()
        }
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func sliderMoved(firstSlider: UISlider) {
        currentValue = lroundf(firstSlider.value)
    }
    
    
    @IBAction func operatedMoved(secondSlider: UISlider) {
        operatedValue = lroundf(secondSlider.value)
    }
    
    
    @IBAction func startOver() {
        startNewGame()
        let transition  = CATransition()
        
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    
    func sliderValues() {
        getSliderValues()
        while firstSlider.minimumValue == firstSlider.maximumValue {
            getSliderValues()
            while secondSlider.minimumValue < 1 {
                getSliderValues()
            }
            while secondSlider.maximumValue < 1 {
                getSliderValues()
            }
            while firstSlider.minimumValue < 1 {
                getSliderValues()
            }
            while firstSlider.maximumValue < 1 {
                getSliderValues()
            }
        }
    }
    
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    
    func startNewRound() {
        round += 1
        sliderValues()
        resetSliderToOrigin()
        updateOperation()
        updateLabels()
        mathIt()
        while calculatedValue < 1 {
            mathIt()
        }
        targetValue = calculatedValue
    }
    
    
    func resetSliderToOrigin() {
        firstSliderMidpoint = (firstSlider.minimumValue + firstSlider.maximumValue) / 2
        secondSliderMidpoint = (secondSlider.minimumValue + secondSlider.maximumValue) / 2
        firstSlider.value = firstSliderMidpoint
        secondSlider.value = secondSliderMidpoint
    }
    
    
    
    func getSliderValues() {
        firstSlider.minimumValue = Float(arc4random_uniform(50) + 1)
        firstSlider.maximumValue = Float(arc4random_uniform(50) + 50)
        secondSlider.minimumValue = Float(arc4random_uniform(50) + 1)
        secondSlider.maximumValue = Float(arc4random_uniform(50) + 50)
        randomizeSlider()
    }
    
    
    func randomizeSlider() {
        firstSliderRandomizer = Int(arc4random_uniform(4) + 1)
        secondSliderRandomizer = Int(arc4random_uniform(4) + 1)
        firstSlider.minimumValue = firstSlider.minimumValue / Float(firstSliderRandomizer)
        firstSlider.maximumValue = firstSlider.maximumValue / Float(firstSliderRandomizer)
        secondSlider.minimumValue = secondSlider.minimumValue / Float(secondSliderRandomizer)
        secondSlider.maximumValue = secondSlider.maximumValue / Float(secondSliderRandomizer)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        firstSliderMinLabel.text = String(Int(firstSlider.minimumValue))
        firstSliderMaxLabel.text = String(Int(firstSlider.maximumValue))
        secondSliderMinLabel.text = String(Int(secondSlider.minimumValue))
        secondSliderMaxLabel.text = String(Int(secondSlider.maximumValue))
    }
    
    
    
    func updateOperation() {
        operationalIndex = Int(arc4random_uniform(4))
        switch operationalIndex {
        case 1 :
            operationLabel.text = String("+")
            operational = 1
        case 2 :
            operationLabel.text = String("-")
            operational = 2
        case 3 :
            operationLabel.text = String("÷")
            operational = 3
        case 4 :
            operationLabel.text = String("x")
            operational = 4
        default :
            operationLabel.text = String("+")
            operational = 1
        }
    }
    
    
    func mathIt() {
        updateOperation()
        if (operational == 1) {
            calculatedValue = Int(firstSlider.value) + Int(secondSlider.value)
        } else if (operational == 2) {
            calculatedValue = Int(firstSlider.value) - Int(secondSlider.value)
        } else if (operational == 3) {
            calculatedValue = Int(firstSlider.value) / Int(secondSlider.value)
        } else if (operational == 4) {
            calculatedValue = Int(firstSlider.value) * Int(secondSlider.value)
        } else {
            calculatedValue = Int(firstSlider.value) + Int(secondSlider.value)
        }
    }
}
