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
    var firstSliderMinInt = 0
    var firstSliderMaxInt = 0
    var middleIndexFirstSlider = 0
    var rangeOfValuesFirstSlider = []
    var middleIndexSecondSlider = 0
    var rangeOfValuesSecondSlider = []
    
    
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
        
        print("End of viewDidLoad() funtion")
        print("------------------------------------")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlert() {
        
        //fix this mess
        print("------------------------------------")
        print("**Beginning of showAlert()**")
        print("------------------------------------")
        let difference = abs(targetValue - currentValue)
    
        let points = 100 - difference
        score += points
        let message = "You scored \(points) points"
        let alert = UIAlertController(title: "Score",
                                      message: message, preferredStyle: .Alert)
//        let action = UIAlertAction(title: "OK", style: .Default,
//                                   handler: nil)
        
        let action = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) in
            self.startNewRound()
        }
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
//        presentViewController(alert, animated: true) {
//
//        }
        //resetSliderToOrigin()
        //print("Called resetSliderToOrigin() at end of showAlert()")
        //startNewRound()
        //print("Called resetSliderToOrigin() at end of showAlert()")
        //updateLabels()
        //print("Called updateLabels() at end of showAlert()")
        //updateOperation()
//        print("Called updateOperation() at end of showAlert()")
//        startNewRound()
//        print("**End of showAlert() function**")
        print("------------------------------------")
    }
    
    @IBAction func sliderMoved(firstSlider: UISlider) {
        print("Beginning of sliderMoved(firstSlider) function")
        currentValue = lroundf(firstSlider.value)
        print("Printing currentValue: ", currentValue)
    }
    
    @IBAction func operatedMoved(secondSlider: UISlider) {
        print("Beginning of sliderMoved(secondSlider) function")
        operatedValue = lroundf(secondSlider.value)
        print("Printing operatedValue: ", operatedValue)
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
        print("Beginning of sliderValues() function")
        getSliderValues()
        print("Called getSliderValues() at beginning of sliderValues")
        while firstSlider.minimumValue == firstSlider.maximumValue {
            getSliderValues()
        }
        
        while secondSlider.minimumValue == secondSlider.maximumValue {
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
            while firstSlider.minimumValue > firstSlider.maximumValue {
                getSliderValues()
            }
            while secondSlider.minimumValue > secondSlider.maximumValue {
                getSliderValues()
            }
            print("------------------------------------")
            print("firstSlider.minumumValue value: \(firstSlider.minimumValue)")
            print("------------------------------------")
            print("firstSlider.maximumValue value: \(firstSlider.maximumValue)")
            print("------------------------------------")
            print("secondSlider.minimumValue value: \(secondSlider.minimumValue)")
            print("------------------------------------")
            print("secondSlider.maximumValue value: \(secondSlider.maximumValue)")
            print("------------------------------------")
        }
        
        print("End of sliderValues() function")
        print("------------------------------------")
    }
    
    func startNewGame() {
        print("Beginning of startNewGame function")
        score = 0
        round = 0
        startNewRound()
        print("Called startNewRound() at the end of startNewGame()")
        print("------------------------------------")
    }
    
    func startNewRound() {
        //Reorganize and complete
        print("Beginning of startNewRound() function")
        round += 1
        sliderValues()
        resetSliderToOrigin()
        print("Called sliderValues() inside of startNewRound()")
        updateOperation()
        updateLabels()
        targetValue = 1 + Int(arc4random_uniform(100))
        print("End of startNewRound() function")
        print("------------------------------------")
    }
    
    func resetSliderToOrigin() {
        print("Beginning of resetSliderToOrigin() function")
        rangeOfValuesFirstSlider = [Int](Int(firstSlider.minimumValue)...Int(firstSlider.maximumValue))
        middleIndexFirstSlider = Int((rangeOfValuesFirstSlider.count - 1) / 2)
        rangeOfValuesSecondSlider = [Int](Int(secondSlider.minimumValue)...Int(secondSlider.maximumValue))
        middleIndexSecondSlider = Int((rangeOfValuesSecondSlider.count - 1) / 2)
        
        firstSlider.value = Float(rangeOfValuesFirstSlider[middleIndexFirstSlider] as! NSNumber)
        
//        firstSlider.value = Float(Int(firstSlider.minimumValue) + Int(firstSlider.maximumValue) / 2)
        print("------------------------------------")
        print("firstSlider.value value: \(firstSlider.value)")
        print("------------------------------------")
        secondSlider.value = Float(rangeOfValuesSecondSlider[middleIndexSecondSlider] as! NSNumber)
//        secondSlider.value = Float(Int(firstSlider.minimumValue) + Int(firstSlider.maximumValue) / 2)
        print("------------------------------------")
        print("secondSlider.value value: \(secondSlider.value)")
        print("------------------------------------")
        print("End of resetSliderToOrigin() function")
        print("------------------------------------")
    }
    
    func getSliderValues() {
        // Reorganize and complete
        print("Beginning of getSliderValues() function")
        firstSlider.minimumValue = Float(arc4random_uniform(50) + 1)
        print("Printing firstSlider.minimumValue: ", firstSlider.minimumValue)
        firstSlider.maximumValue = Float(arc4random_uniform(50) + 50)
        print("Printing firstSlider.maximumValue: ", firstSlider.maximumValue)
        secondSlider.minimumValue = Float(arc4random_uniform(50) + 1)
        secondSlider.maximumValue = Float(arc4random_uniform(50) + 50)
        print("Ending of getSliderValues() function")
        print("------------------------------------")
    }
    
    func updateLabels() {
        print("Beginning of updateLabels() function")
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        firstSliderMinLabel.text = String(Int(firstSlider.minimumValue))
        firstSliderMaxLabel.text = String(Int(firstSlider.maximumValue))
        secondSliderMinLabel.text = String(Int(secondSlider.minimumValue))
        secondSliderMaxLabel.text = String(Int(secondSlider.maximumValue))
        print("End of updateLabels() function")
        print("------------------------------------")
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

