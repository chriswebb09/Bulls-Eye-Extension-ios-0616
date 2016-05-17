//
//  ViewController.swift
//  BullsEye
//
//  Created by Chris Webb on 5/13/16.
//  Copyright © 2016 Chris Webb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var operated: UISlider!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var mathLabel: UILabel!
    @IBOutlet weak var mathLabelMax: UILabel!
    var currentValue: Int = 0
    var targetValue: Int = 0
    var operatedValue: Int = 0
    var score = 0
    var round = 0
    var operationalIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
        updateOperation()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, forState: .Normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, forState: .Highlighted);
        
        let insets = UIEdgeInsets(top: 0, left:14, bottom: 0, right: 14)
        
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable =
                trackLeftImage.resizableImageWithCapInsets(insets)
            slider.setMinimumTrackImage(trackLeftResizable, forState: .Normal)
        }
        
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImageWithCapInsets(insets)
            slider.setMaximumTrackImage(trackRightResizable, forState: .Normal)
        }
        operated.setThumbImage(thumbImageNormal, forState: .Normal)
        
        operated.setThumbImage(thumbImageHighlighted, forState: .Highlighted);
        
        if let trackOperatorLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackOperatorLeftResizable =
                trackOperatorLeftImage.resizableImageWithCapInsets(insets)
            operated.setMinimumTrackImage(trackOperatorLeftResizable, forState: .Normal)
        }
        
        if let trackOperatorRightImage = UIImage(named: "SliderTrackRight") {
            let trackOperatorRightResizable = trackOperatorRightImage.resizableImageWithCapInsets(insets)
            operated.setMaximumTrackImage(trackOperatorRightResizable, forState: .Normal)
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
        let alert = UIAlertController(title: "Hello, World",
                                      message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default,
                                   handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        startNewRound()
        updateLabels()
        updateOperation()
    }
    
    @IBAction func sliderMoved(slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func operatedMoved(operated: UISlider) {
        operatedValue = lroundf(operated.value)
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
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
            operationLabel.text = String("default")
        }
    }
}

