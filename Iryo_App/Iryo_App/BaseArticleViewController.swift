//
//  BaseArticleViewController.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/24.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class BaseArticleViewController: UIViewController, AVSpeechSynthesizerDelegate{
    
    var speakDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let speakBtn:UIButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
    /* 音声設定 */
    var voicerate :Float = 0.2 //速さ 0.1~1.0
    var voicepitch :Float = 1.1 //高さ 0.5~2.0
    var speaktext :String = "テキスト"; //読み上げるテキスト
    
    override func viewWillDisappear(animated: Bool) {
        speakDelegate.speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        animateActionButtonAppearance(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speakDelegate.speechSynthesizer.delegate = self
        
        speakBtn.addTarget(self, action: "onClickSpeakBtn", forControlEvents: UIControlEvents.TouchUpInside)
        
        /* speakBtnレイアウト設定 */
        speakBtn.frame = CGRectMake(0, 0, 60, 30)
        speakBtn.layer.cornerRadius = 5
        speakBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        
        if speakDelegate.toggle{
            speakBtn.setTitle("Speak", forState: .Normal )
            speakBtn.layer.backgroundColor = UIColor(red: 0.12, green: 0.78, blue: 0, alpha: 1.0).CGColor
        }else{
            speakBtn.layer.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0).CGColor
            speakBtn.setTitle("Pause", forState: UIControlState.Normal)
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: speakBtn)
    }

    
    /** speakBtnのアニメーションを設定 */
    func animateActionButtonAppearance(shouldHideSpeakButton: Bool) {
        
        if shouldHideSpeakButton {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.speakBtn.layer.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1.0).CGColor
                self.speakBtn.setTitle("Pause", forState: UIControlState.Normal)
            })
            speakDelegate.toggle = false
        }else{
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.speakBtn.layer.backgroundColor = UIColor(red: 0.12, green: 0.78, blue: 0, alpha: 1.0).CGColor
                self.speakBtn.setTitle("Speak", forState: UIControlState.Normal)
            })
            speakDelegate.toggle = true
        }
    }
    
    /** speakBtnを押した時 */
    func onClickSpeakBtn() {
        if speakDelegate.toggle{
            let utterance = AVSpeechUtterance(string: self.speaktext)
            utterance.voice = AVSpeechSynthesisVoice(language: "ja-JP")
            utterance.rate = voicerate
            utterance.pitchMultiplier = voicepitch

            if !speakDelegate.speechSynthesizer.speaking{
            speakDelegate.speechSynthesizer.speakUtterance(utterance)
            }else{
                speakDelegate.speechSynthesizer.continueSpeaking()
            }
            animateActionButtonAppearance(true)
        }else{
            speakDelegate.speechSynthesizer.pauseSpeakingAtBoundary(AVSpeechBoundary.Immediate)
            animateActionButtonAppearance(false)
        }
    }
    
    /** 再生終了時 */
    func speechSynthesizer(synthesizer: AVSpeechSynthesizer!, didFinishSpeechUtterance utterance: AVSpeechUtterance!)
    {
        animateActionButtonAppearance(false)
    }
    

    
}
