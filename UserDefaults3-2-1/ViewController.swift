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
    var highScore = 0.0
    
    var scores: [Double] = [] // this will keep track of all the scores...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topLabel.text = "0.00"
        gameButton.setTitle("Start", for: .normal)
        currentScoreLabel.text = "Current Score\n---"
        bestScoreLabel.text = "Best Score\n---"
        
        loadFromUserDefaults()
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
            let timeDifference = count - 3
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
        print("bestscore: \(highScore)")
        var bestscore = highScore
        print("all scores: \(scores)")
        for score in scores
        {
            print("comparing best score: \(score.magnitude)")
            if score.magnitude < bestscore
            {
                bestscore = score.magnitude
                print("bestscore is now \(score)")
            }
        }
        print("Displaying bestscore \(bestscore)")
        highScore = bestscore
        bestScoreLabel.text = String(format: "Best Score\n%.02f", bestscore)
        
        saveToUserDefaults()
        
    }
    
    func startTimer()
    {
        // get a new goal
//        goal = Int.random(in: 1...5)
//
//        gameButton.setTitle("Goal:\(goal)", for: .normal)
        count = 0.0 // reset count
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer()
    {
        if count >= 7.0
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
    
    func saveToUserDefaults()
    {
        let defaults = UserDefaults.standard
        defaults.set(highScore, forKey: "HighScore")
        
        // save scores
        // this will help me display game averages and all stats...
        defaults.setValue(scores, forKey: "scores")
    }
    
    func loadFromUserDefaults()
    {
        let defaults = UserDefaults.standard
        
        // load high score!
        highScore = defaults.double(forKey: "HighScore")
        
        
        // fix highscore if this is the first time loading...
        let hasLoadedBefore = defaults.bool(forKey: "first") // defaults to false if it doesn't exist
        if hasLoadedBefore == false
        {
            print("inside isFirstTimeLoading")
            highScore = 10.0
            defaults.set(true, forKey: "first")
        }
        
        
        bestScoreLabel.text = String(format: "Best Score\n%.02f", highScore)
        
        
        //load scores
        scores = defaults.array(forKey: "scores") as? [Double] ?? [Double]()
    }
    
}

