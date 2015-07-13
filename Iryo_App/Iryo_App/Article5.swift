//
//  Article5.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/19.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article5 : BaseArticleViewController{

    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var headline1: UILabel!
    @IBOutlet weak var subTextView: UITextView!
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.myScroll?.contentSize = CGSizeMake(768,1250)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.speaktext = text1.text + text2.text + headline1.text! + subTextView.text //読み上げるテキスト
        
        //border設定
        subTextView.layer.borderColor = UIColor(red: 29/255, green: 135/255, blue: 188/255, alpha: 1.0).CGColor
        
        text2.textContainerInset = UIEdgeInsetsMake(15, 22, 0, 10)
        text2.layer.cornerRadius = 10

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
