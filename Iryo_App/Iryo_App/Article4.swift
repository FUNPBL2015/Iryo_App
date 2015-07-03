//
//  Article4.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/23.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article4: BaseArticleViewController {
    
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var myBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        self.myScroll?.contentSize = CGSizeMake(768,2200)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         self.speaktext = "テキスト" //読み上げるテキスト
        
        myBtn.setTitle("例えば...", forState: UIControlState.Normal)
        myBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 28)
        myBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
}

