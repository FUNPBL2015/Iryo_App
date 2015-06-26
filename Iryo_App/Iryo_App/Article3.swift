//
//  Article3.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/26.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Article3: UIViewController {
    
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myText: UITextView!
    @IBOutlet weak var comBtn: UIButton!
    @IBOutlet weak var myLabel3: UILabel!
    @IBOutlet weak var myText2: UITextView!
    @IBOutlet weak var cheBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.myScroll?.contentSize = CGSizeMake(768,1840)
        
        myLabel1.text="🔵 病院で医療をうけるとき\n\n  ・ご本人のふだんの様子\n\n  ・ご本人の医療行為に関する希望や意思\n\n  に関する情報がたいへん役に立ちます!"
        myLabel1.numberOfLines=20
        myLabel1.font=UIFont(name:"HiraKakuProN-W6",size: 28)
        
        myLabel2.text="ご家族で一度話し合ってみましょう！\n\n話し合いのポイント"
        myLabel2.numberOfLines=30
        myLabel2.font=UIFont(name: "HiraKakuProN-W6", size: 30)
        
        myText.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myText.text="・身近な他人のケースやテレビのみとりの話題などをきっかけにすると話しやすくなります。\n\n・ご本人の希望はできるだけご本人を取り巻く皆と共有しておきましょう。\n    話し合った内容を事前指示書など書面に記録しておくのも1つです。"
        myText.font = UIFont.systemFontOfSize(CGFloat(28))
        
        comBtn.setTitle("家族での話し合い例を見る", forState: UIControlState.Normal)
        comBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 28)
        comBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        comBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        myLabel3.text="チェックリストを活用しよう！"
        myLabel3.numberOfLines=30
        myLabel3.font=UIFont(name: "HiraKakuProN-W6", size: 30)
        
        myText2.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myText2.text="このチェックリストは・・・\n\n・ご本人の認知症の状態を知るとき\n\n・病院への受診時に状態を伝えるとき\n\nに役立ちます。"
        myText2.font = UIFont.systemFontOfSize(CGFloat(28))
        
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