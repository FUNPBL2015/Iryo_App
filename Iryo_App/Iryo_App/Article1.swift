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
    //@IBOutlet weak var mytext: UITextView!
    
    /*
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.scrollview.contentSize = self.mytext.frame.size //contentSizeをtextViewに合わせる
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "はじめに"
        
        //textview生成
        let mytext: UITextView = UITextView(frame: CGRectMake(16, 16, self.view.frame.width - 32, 1000))
        mytext.text = "もし認知症のおじいちゃん、おばあちゃんが急に入院して検査や手術を受けることになったら… \n・本人の　同意　が得られない\n・本人の　意思　がわからない\n・家族の　同意　だけで医療行為が進められる\n・場合によっては、本人の同意が得られないために、必要な医療行為が受けられない\nということもありえます\nふだんから本人の意思や希望、気持ちを確認しておくことが大切です！\n\n\nこのアプリは、本人と家族が納得のいく医療を受けられるように…\n・ふだんの生活や症状の共有方法\n・病院で家族が聞かれること\n・医師と家族の話し合い\n・家族の今後の生活\nについて、アドバイスします！"
        mytext.font = UIFont.systemFontOfSize(CGFloat(28))
        mytext.font = UIFont(name:"HiraKakuProN-W3", size:28)           //フォント・サイズ設定
        mytext.textColor = UIColor.blackColor()             //文字色
        mytext.textAlignment = NSTextAlignment.Left         //左詰め
        mytext.editable = false         //編集禁止
        mytext.scrollEnabled = false;   //スクロール禁止（;は必要みたい？）
        self.view.addSubview(mytext)    //viewに追加
        
        
        //mytext.text = "test"
        mytext.layer.borderWidth = 0
        self.speaktext = mytext.text //読み上げるテキスト
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