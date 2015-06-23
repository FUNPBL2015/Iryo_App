//
//  Article2.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/23.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class Article2 :UIViewController, AVSpeechSynthesizerDelegate{
    
    @IBOutlet weak var scrollview2: UIScrollView!
    @IBOutlet weak var speakbtn2: UIButton!
    @IBOutlet weak var voicevolume2: UISlider!
    @IBOutlet weak var voicepitch2: UISlider!
    @IBOutlet weak var mytext2: UITextView!
    
    let speechSynthesizer = AVSpeechSynthesizer()
    var toggle : Bool = true
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.scrollview2.contentSize = self.mytext2.frame.size
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
            let utterance = AVSpeechUtterance(string: self.mytext2.text)
            
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = voicevolume2.value
            utterance.pitchMultiplier = voicepitch2.value
            
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
                self.speakbtn2.layer.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0).CGColor
                self.speakbtn2.setTitle("Pause", forState: UIControlState.Normal)
            })
            toggle = false
        }else{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.speakbtn2.layer.backgroundColor = UIColor(red: 0.12, green: 0.78, blue: 0, alpha: 1.0).CGColor
                self.speakbtn2.setTitle("Speak", forState: UIControlState.Normal)
            })
            toggle = true
        }
        
    }
}