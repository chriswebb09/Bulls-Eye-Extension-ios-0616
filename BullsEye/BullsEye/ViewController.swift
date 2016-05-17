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
    var currentValue: Int = 0
    var targetValue: Int = 0
    var operatedValue: Int = 0
    var score = 0
    var round = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
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
}

