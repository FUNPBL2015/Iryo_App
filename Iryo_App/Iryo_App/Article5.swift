//
//  Article5.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/19.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article5 : BaseArticleViewController{

    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var subTextView: UITextView!
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.myScrollView?.contentSize = CGSizeMake(768.0, 3340)
        self.speaktext = myTextView.text
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        subTextView.layer.borderColor = UIColor(red: 29/255, green: 135/255, blue: 188/255, alpha: 1.0).CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
}
