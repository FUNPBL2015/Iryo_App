//
//  Article1.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/19.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class Article1:UIViewController, AVSpeechSynthesizerDelegate{
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var speakbtn: UIButton!
    @IBOutlet weak var voicevolume: UISlider!
    @IBOutlet weak var voicepitch: UISlider!
    @IBOutlet weak var mytext: UITextView!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var toggle : Bool = true
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.scrollview.contentSize = self.mytext.frame.size
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.speechSynthesizer.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mybtn(sender: AnyObject) {
        
        if toggle{
            let utterance = AVSpeechUtterance(string: self.mytext.text)
            
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = voicevolume.value
            utterance.pitchMultiplier = voicepitch.value
            
            speechSynthesizer.speakUtterance(utterance)
            animateActionButtonAppearance(true)
        }else{
            speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
            animateActionButtonAppearance(false)
        }
    }
    
    @IBAction func stopbutton(sender: AnyObject) {
        speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    func animateActionButtonAppearance(shouldHideSpeakButton: Bool) {
        
        if shouldHideSpeakButton {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.speakbtn.layer.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0).CGColor
                self.speakbtn.setTitle("Pause", forState: UIControlState.Normal)
            })
            toggle = false
        }else{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.speakbtn.layer.backgroundColor = UIColor(red: 0.12, green: 0.78, blue: 0, alpha: 1.0).CGColor
                self.speakbtn.setTitle("Speak", forState: UIControlState.Normal)
            })
            toggle = true
        }
        
    }
}