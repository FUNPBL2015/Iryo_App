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
    @IBOutlet weak var case1Label: UILabel!
    @IBOutlet weak var case1Text: UITextView!
    @IBOutlet weak var case2Label: UILabel!
    @IBOutlet weak var case2Text: UITextView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myText: UITextView!
    @IBOutlet weak var myBtn: UIButton!
    
    override func viewDidLayoutSubviews() {
        self.myScroll?.contentSize = CGSizeMake(768,2080)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
         self.speaktext = "テキスト" //読み上げるテキスト
        
        case1Label.text="ケース１: ６０代男性、若年性認知症\n\n【足の切断の決定】"
        case1Label.numberOfLines = 20
        case1Label.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        
        case1Text.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case1Text.text="糖尿病で左足を切断する必要が出てきました。\nご本人は若年性認知症で意思確認ができないため、医師は妻に切断するか、切断する場合どこから切断するかを相談しました。\n「先生の家族だったどうしますか？」と質問したりして、切断後のことも十分説明を受けながら膝上から切断することを決めました。"
        case1Text.font = UIFont.systemFontOfSize(CGFloat(28))

        case2Label.text="ケース２: ９０代女性、アルツハイマー症\n\n【食事の楽しみか窒息の危険か】"
        case2Label.numberOfLines = 20
        case2Label.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        
        case2Text.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        case2Text.text="飲み込みが悪くなり、胃ろうを作るかどうかを検討しました。\n家族からは、ご本人がもともと食事を楽しみにしているところがあったため、できるだけ口から食べる楽しみを残してほしいという希望を出しました。\n医師は言語聴覚士と相談し、胃ろうはせず食事を継続することにしました。"
        case2Text.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myLabel.text="医師と納得のいく治療を話し合いましょう！\n\n話し合いのポイント"
        myLabel.numberOfLines = 20
        myLabel.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        
        myText.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myText.text="・ご家族の気持ち、ご本人ならどう考えるか、近しい家族として伝えることも大切です。\nご本人のこれまでの価値観を推し量る情報があれば、積極的に伝えていきましょう。\n\n・退院後の生活も視野に入れて、ケアマネージャなどの同席も考えてみましょう。"
        myText.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myBtn.setTitle("医師との話し合い例を見る", forState: UIControlState.Normal)
        myBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 28)
        myBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unWindows(segue: UIStoryboardSegue){
    }
    
}

