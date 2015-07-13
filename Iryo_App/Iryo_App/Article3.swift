//
//  Article3.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/24.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article3: BaseArticleViewController {

    //@IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var text1: UITextView!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text3: UITextView!
    
    /*
    override func viewDidLayoutSubviews() {
        //myScroll.contentSize = CGSizeMake(768,1740)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        self.title = "病院できかれること"

        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        
        let text1: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+32, self.view.frame.width - 32, 0))
        text1.text = "患者の家族が、治療を判断を求められることがあります。\n例えば ..."
        text1.font = UIFont(name:"HiraKakuProN-W3", size:28)
        text1.textColor = UIColor.blackColor()
        text1.editable = false         //編集禁止
        text1.scrollEnabled = false
        text1.sizeToFit()
        self.view.addSubview(text1)
        var maxSize: CGSize = CGSizeMake(self.view.bounds.width,self.view.bounds.height)
        var text1s: CGSize = text1.sizeThatFits(maxSize)
        
        let text2: UITextView = UITextView(frame: CGRectMake(32, navBarHeight!+32+text1s.height, self.view.frame.width - 32, 0))
        text2.text = "⚫︎急変したら，心臓マッサージ／血圧を上げる薬の投与／\n　 人工呼吸などの救命措置 をしますか？\n⚫︎口からものを食べられないときに，胃ろう／\n 　経鼻経管栄養／中心静脈栄養／点滴 をしますか？\n⚫︎腎臓の働きが悪くなったときに，人工透析をしますか？"
        text2.font = UIFont(name:"HiraKakuProN-W3", size:28)           //フォント・サイズ設定
        text2.textColor = UIColor.blackColor()
        text2.textAlignment = NSTextAlignment.Left         //左詰め
        text2.editable = false         //編集禁止
        text2.scrollEnabled = false   //スクロール禁止
        text2.sizeToFit()
        self.view.addSubview(text2)    //viewに追加
        var text2s: CGSize = text2.sizeThatFits(maxSize)
        
        
        let text3: UITextView = UITextView(frame: CGRectMake(16, navBarHeight!+48+text1s.height+text2s.height, self.view.frame.width - 32, 300))
        text3.text = "家族だけで重大な医療行為を決めるのはとても難しいです。ふだんからよく話し合い、本人の意思や希望を確認しておくとよいでしょう。"
        text3.font = UIFont(name:"HiraKakuProN-W6", size:30)           //フォント・サイズ設定
        text3.textColor = UIColor.whiteColor() /*UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.7)*/
        text3.textAlignment = NSTextAlignment.Left         //左詰め
        text3.editable = false         //編集禁止
        text3.scrollEnabled = false   //スクロール禁止
        text3.textContainerInset = UIEdgeInsetsMake(10, 10, 0, 10)
        text3.sizeToFit()
        text3.layer.cornerRadius = 5
        text3.backgroundColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.5)

        self.view.addSubview(text3)    //viewに追加
        */
        
        text3.textContainerInset = UIEdgeInsetsMake(15, 22, 0, 10)
        //text3.sizeToFit()
        text3.layer.cornerRadius = 10
        //text3.backgroundColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.5)
        
        let t: String = "。"
        self.speaktext = text1.text + t + text2.text + t + text3.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}
