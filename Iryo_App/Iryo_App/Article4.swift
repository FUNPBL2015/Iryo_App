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
    @IBOutlet weak var intro: UITextView!
    @IBOutlet weak var case1headline: UILabel!
    @IBOutlet weak var case1view: UIView!
    @IBOutlet weak var case1text: UITextView!
    @IBOutlet weak var case1result: UILabel!
    @IBOutlet weak var case2headline: UILabel!
    @IBOutlet weak var case2view: UIView!
    @IBOutlet weak var case2text: UITextView!
    @IBOutlet weak var case2result: UILabel!
    @IBOutlet weak var conclusion: UILabel!
    @IBOutlet weak var talkingPoints: UILabel!
    @IBOutlet weak var talkingPointsView: UIView!
    @IBOutlet weak var talkingPointsText: UITextView!
    
    override func viewDidLayoutSubviews() {
        //ScrollViewのContentSizeを設定
        self.myScroll?.contentSize = CGSizeMake(768,2300)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         self.speaktext = intro.text + case1headline.text! + case1text.text + case1result.text! + case2headline.text! + case2text.text + case2result.text! + conclusion.text! + talkingPoints.text! + talkingPointsText.text //読み上げるテキスト
        
        //border設定
        case1view.layer.borderColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 1.0).CGColor
        case2view.layer.borderColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 1.0).CGColor
        talkingPointsView.layer.borderColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.5).CGColor
        
        /* Button layout */
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

