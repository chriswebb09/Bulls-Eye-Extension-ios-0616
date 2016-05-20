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
    var score = 0
    var round = 0
    var divisor = 0
    var operationalIndex = 0
    var totalValueFirstSlider = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateOperation()
        getSliderValues()
        updateLabels()
        
        
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        let difference = abs(targetValue - currentValue)
        let points = 100 - difference
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: "Score",
                                      message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,
                                   handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
        getSliderValues()
        if firstSlider.minimumValue == firstSlider.maximumValue {
            getSliderValues()
        }
        
        if secondSlider.minimumValue == secondSlider.maximumValue {
            getSliderValues()
        }
        updateLabels()
        updateOperation()
    }
    
    @IBAction func sliderMoved(firstSlider: UISlider) {
        currentValue = lroundf(firstSlider.value)
    }
    
    @IBAction func operatedMoved(secondSlider: UISlider) {
        operatedValue = lroundf(secondSlider.value)
    }
    
    @IBAction func startOver() {
        
        startNewGame()
        updateLabels()
        
        let transition  = CATransition()
        
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        view.layer.addAnimation(transition, forKey: nil)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        totalValueFirstSlider = Int(firstSlider.minimumValue + firstSlider.maximumValue)
        firstSlider.value = Float(totalValueFirstSlider/2)
        secondSlider.value = Float(currentValue)
    }
    
    func getSliderValues() {
        firstSlider.minimumValue = Float(arc4random_uniform(50))
        firstSlider.maximumValue = Float(arc4random_uniform(50))
        secondSlider.minimumValue = Float(arc4random_uniform(50))
        secondSlider.maximumValue = Float(arc4random_uniform(50))
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        while firstSlider.minimumValue == firstSlider.maximumValue {
            getSliderValues()
            firstSliderMinLabel.text = String(Int(firstSlider.minimumValue))
            firstSliderMaxLabel.text = String(Int(firstSlider.maximumValue))
        }
        
        while secondSlider.minimumValue == secondSlider.maximumValue {
            getSliderValues()
            secondSliderMinLabel.text = String(Int(secondSlider.minimumValue))
            secondSliderMaxLabel.text = String(Int(secondSlider.maximumValue))
        }
    }
    
    func updateOperation() {
        operationalIndex = Int(arc4random_uniform(4))
        switch operationalIndex {
        case 1 :
            operationLabel.text = String("+")
        case 2 :
            operationLabel.text = String("-")
        case 3 :
            operationLabel.text = String("÷")
        case 4 :
            operationLabel.text = String("x")
        default :
            operationLabel.text = String("+")
        }
    }
    
    func mathIt() {
    }
}

