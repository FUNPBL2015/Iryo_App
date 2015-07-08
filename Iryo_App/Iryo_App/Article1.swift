//
//  Article1.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/19.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article1:BaseArticleViewController{
    
    //@IBOutlet weak var scrollview: UIScrollView!
    //@IBOutlet weak var speakbtn: UIButton!
    //@IBOutlet weak var voiceRateSlider: UISlider!
    //@IBOutlet weak var voicePitchSlider: UISlider!
    //@IBOutlet weak var text2: UITextView!
    
    /*
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.scrollview.contentSize = self.text2.frame.size //contentSizeをtextViewに合わせる
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "はじめに"
        
        //textview生成
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let text1: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+32, self.view.frame.width - 32, 0))
        text1.text = "もし認知症のおじいちゃん、おばあちゃんが急に入院して検査や手術を受けることになったら…"
        text1.font = UIFont(name:"HiraKakuProN-W3", size:28)
        text1.textColor = UIColor.blackColor()
        text1.editable = false         //編集禁止
        text1.scrollEnabled = false
        text1.sizeToFit()
        self.view.addSubview(text1)
        var maxSize: CGSize = CGSizeMake(self.view.bounds.width,self.view.bounds.height)
        var text1s: CGSize = text1.sizeThatFits(maxSize)
        
        let text2: UITextView = UITextView(frame: CGRectMake(48, navBarHeight!+32+text1s.height, self.view.frame.width - 32, 0))
        text2.text = "⚫︎本人の 同意 が得られない　\n⚫︎本人の 意思 がわからない　\n⚫︎家族の 同意 だけで医療行為が進められる　\n⚫︎場合によっては、本人の 同意 が得られないために、\n   必要な医療行為が受けられない　"
        text2.font = UIFont(name:"HiraKakuProN-W3", size:28)           //フォント・サイズ設定
        text2.textColor = UIColor.blackColor()
        text2.textAlignment = NSTextAlignment.Left         //左詰め
        text2.editable = false         //編集禁止
        text2.scrollEnabled = false   //スクロール禁止
        text2.sizeToFit()
        self.view.addSubview(text2)    //viewに追加
        var text2s: CGSize = text2.sizeThatFits(maxSize)

        
        let text3: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+32+text1s.height+text2s.height, self.view.frame.width - 32, 0))
        text3.text = "ということもありえます"
        text3.font = UIFont(name:"HiraKakuProN-W3", size:28)           //フォント・サイズ設定
        text3.textColor = UIColor.blackColor()
        text3.textAlignment = NSTextAlignment.Left         //左詰め
        text3.editable = false         //編集禁止
        text3.scrollEnabled = false   //スクロール禁止
        text3.sizeToFit()
        self.view.addSubview(text3)    //viewに追加
        var text3s: CGSize = text3.sizeThatFits(maxSize)
        
        let text4: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+32+text1s.height+text2s.height+text3s.height, self.view.frame.width - 32, 0))
        text4.text = "ふだんから本人の意思や希望、気持ちを確認しておくことが大切です！"
        text4.font = UIFont(name:"HiraKakuProN-W6", size:30)           //フォント・サイズ設定
        text4.textColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 1)
        text4.textAlignment = NSTextAlignment.Left         //左詰め
        text4.editable = false         //編集禁止
        text4.scrollEnabled = false   //スクロール禁止
        text4.sizeToFit()
        self.view.addSubview(text4)    //viewに追加
        var text4s: CGSize = text4.sizeThatFits(maxSize)
        
        let text5: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+32+text1s.height+text2s.height+text3s.height+text4s.height, self.view.frame.width - 32, 0))
        text5.text = "このアプリは、本人と家族が納得のいく医療を受けられるように…"
        text5.font = UIFont(name:"HiraKakuProN-W3", size:28)
        text5.textColor = UIColor.blackColor()
        text5.editable = false         //編集禁止
        text5.scrollEnabled = false
        text5.sizeToFit()
        self.view.addSubview(text5)
        var text5s: CGSize = text5.sizeThatFits(maxSize)
        
        let text6: UITextView = UITextView(frame: CGRectMake(48, navBarHeight!+32+text1s.height+text2s.height+text3s.height+text4s.height+text5s.height, self.view.frame.width - 32, 0))
        text6.text = "⚫︎病院で役に立つ情報　\n⚫︎病院できかれること　\n⚫︎医師との話し合いのコツ　\n⚫︎家族のそれから　"
        text6.font = UIFont(name:"HiraKakuProN-W3", size:28)           //フォント・サイズ設定
        text6.textColor = UIColor.blackColor()
        text6.textAlignment = NSTextAlignment.Left         //左詰め
        text6.editable = false         //編集禁止
        text6.scrollEnabled = false   //スクロール禁止
        text6.sizeToFit()
        self.view.addSubview(text6)    //viewに追加
        var text6s: CGSize = text6.sizeThatFits(maxSize)
        
        let text7: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+32+text1s.height+text2s.height+text3s.height+text4s.height+text5s.height+text6s.height, self.view.frame.width - 32, 0))
        text7.text = "について、ご説明します！"
        text7.font = UIFont(name:"HiraKakuProN-W3", size:28)
        text7.textColor = UIColor.blackColor()
        text7.editable = false         //編集禁止
        text7.scrollEnabled = false
        text7.sizeToFit()
        self.view.addSubview(text7)
        
        
        text2.layer.borderWidth = 0
        let t: String = "　"
        self.speaktext = text1.text + t + text2.text + t + text3.text + t + text4.text + t + text5.text + t + text6.text + t + text7.text //読み上げるテキスト
    }
    
    /** Sliderの値が変化したときに実行 */
    /*
    @IBAction func voiceRateChanged(sender: UISlider) {
        self.voicerate = voiceRateSlider.value //声の速さ
    }
    
    @IBAction func voicePitchChanged(sender: UISlider) {
        self.voicepitch = voicePitchSlider.value //声の高さ
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}