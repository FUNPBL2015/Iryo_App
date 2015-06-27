//
//  Article2.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/23.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article2 :BaseArticleViewController{
    
    @IBOutlet weak var scrollview2: UIScrollView!
    @IBOutlet weak var voicevolume2: UISlider!
    @IBOutlet weak var voicepitch2: UISlider!
    @IBOutlet weak var mytext2: UITextView!
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.scrollview2.contentSize = self.mytext2.frame.size
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.speaktext = mytext2.text //読み上げるテキスト
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}