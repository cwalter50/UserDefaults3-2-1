//
//  ViewController.swift
//  UserDefaults3-2-1
//
//  Created by  on 11/21/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    

    var timer = Timer()
    var count = 0.0 // this will be used to keep track of the time in the game and also how the user compares to the solution
    var goal = 0
    
    var scores: [Double] = [] // this will keep track of all the scores...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = "0.00"
        gameButton.setTitle("Start", for: .normal)
        currentScoreLabel.text = "Current Score\n---"
        bestScoreLabel.text = "Best Score\n---"
    }


    
    @IBAction func startButtonTapped(_ sender: UIButton)
    {
        // if timer is off... start the timer and reset count
        if !timer.isValid
        {
            startTimer()
        }
        else
        {
            // the game is live. the next click should...
            // 1. stop the timer
            timer.invalidate()
            // 2. compare users time to solution. (Remember count is usertime)
            let timeDifference = count - 3.0
            // 3. display results
            if timeDifference > 0
            {
                currentScoreLabel.text = String(format: "Current Score\n+%.02f ", timeDifference)
            }
            else if timeDifference < 0
            {
                currentScoreLabel.text = String(format: "Current Score\n%.02f ", timeDifference) // negative sign shows up automatically
            }
            else
            {
                currentScoreLabel.text = String(format: "Current Score\n%.02f PERFECT!!!", timeDifference)
            }
            // 4. add score to scores array
            scores.append(timeDifference)
            // 5. compare results to best score
            displayBestScore()
            // 6. save to userdefaults if we beat best score..
        
        }
        
    }
    
    func displayBestScore()
    {
        // loop through array of scores and find the closest one to 0. remmeber absolutevalue
        
        var bestscore = abs(scores[0])
        for score in scores
        {
            if abs(score) < bestscore
            {
                bestscore = score
            }
        }
        
        bestScoreLabel.text = String(format: "Best Score\n%.02f", bestscore)
        
    }
    
    func startTimer()
    {
        count = 0.0 // reset count
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer()
    {
        if count >= 7.00
        {
            timer.invalidate()
        }
        else
        {
            count += 0.01
            
            // format to hundredths
            topLabel.text = String(format: "%.02f ", count)
        }
        
    }
    
}

