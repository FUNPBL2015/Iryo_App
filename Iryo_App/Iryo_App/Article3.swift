//
//  Article3.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/24.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article3: BaseArticleViewController {

    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myLabel3: UILabel!
    @IBOutlet weak var cheBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        myScroll.contentSize = CGSizeMake(768,1740)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "病院で家族が聞かれること"
        
        self.speaktext = "テキスト" //読み上げるテキスト
        
        myLabel1.font=UIFont(name:"HiraKakuProN-W3",size: 28)
        myLabel1.text="例えばこのようなとき、家族だけで判断できますか？"
        
        myLabel2.text="・急変したら，心臓マッサージ／血圧をあげる薬の投与／人工呼吸などの救命措置をしますか？\n・口からものを食べられないときに，胃ろう／経鼻経管栄養／中心静脈栄養／点滴をしますか？\n・腎臓の働きが悪くなったときに，人工透析をしますか？"
        myLabel2.numberOfLines=30
        myLabel2.font=UIFont(name: "HiraKakuProN-W3", size: 28)
        
        myLabel3.text="家族だけで重大な医療行為を決めるのはとても難しいです。\nふだんからよく話し合い、本人の意思や希望を確認しておくとよいでしょう。"
        myLabel3.numberOfLines=30
        myLabel3.font=UIFont(name: "HiraKakuProN-W3", size: 28)
        
        cheBtn.setTitle("チェックリストをやる", forState: UIControlState.Normal)
        cheBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 28)
        cheBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cheBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func unWindows(segue: UIStoryboardSegue){
    }

    
}
