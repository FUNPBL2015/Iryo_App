//
//  Article1.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/19.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article1:BaseArticleViewController{
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var speakbtn: UIButton!
    @IBOutlet weak var voiceRateSlider: UISlider!
    @IBOutlet weak var voicePitchSlider: UISlider!
    @IBOutlet weak var mytext: UITextView!
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.scrollview.contentSize = self.mytext.frame.size
        self.speaktext = mytext.text
        self.voicerate = voiceRateSlider.value
        self.voicepitch = voicePitchSlider.value
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}