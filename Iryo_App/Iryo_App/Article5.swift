//
//  Article5.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/19.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article5 : BaseArticleViewController{

    @IBOutlet weak var troubleText: UITextView!
    @IBOutlet weak var subTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //読み上げるテキスト
        self.speaktext = troubleText.text
        
        //相談窓口 border設定
        subTextView.layer.borderColor = UIColor(red: 29/255, green: 135/255, blue: 188/255, alpha: 1.0).CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
