//
//  Article2.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/23.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article2 :BaseArticleViewController{
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var exampleBtn: UIButton!
    @IBOutlet weak var checkBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        //self.scrollview.contentSize = CGSizeMake(768,1500)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.speaktext = text1.text //読み上げるテキスト
        
        exampleBtn.setTitle("例えば...", forState: UIControlState.Normal)
        exampleBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 28)
        exampleBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        exampleBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        checkBtn.setTitle("チェックリスト", forState: UIControlState.Normal)
        checkBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 28)
        checkBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        checkBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }

}