//
//  ViewController.swift
//  myTimer
//
//  Created by Andrew Ballantyne on 8/22/15.
//  Copyright (c) 2015 Andrew Ballantyne. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    var startCount = 120
    var counter = 120

    var timer:NSTimer = NSTimer()
    
    @IBOutlet weak var myLabel: UILabel!

    var buttonBeep = AVAudioPlayer()
    var secondBeep = AVAudioPlayer()
    var backgroundMusic = AVAudioPlayer()
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        //2
        var error: NSError?
        
        //3
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4
        return audioPlayer!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myLabel.text = String(counter)
        buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav")
        secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav")
        backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type:"mp3")
         
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButton(sender: AnyObject) {
        counter = startCount
        timer.invalidate()
        myLabel.text = String(counter)
    }
    
    @IBAction func myplaybutton(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector:"updateTimer", userInfo: nil, repeats: true)
        
    }
    func updateTimer(){
        myLabel.text = String(--counter);
        NSLog("started playing")
        buttonBeep.play()
        if counter == 0 {
            myLabel.text = "All Done"
            counter = startCount
            timer.invalidate()
             buttonBeep.play()
        }
    }
    
    @IBAction func myPauseButton(sender: AnyObject) {
        timer.invalidate()
    }
}

