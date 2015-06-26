//
//  com3.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/26.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class com3: UIViewController {
    
    @IBOutlet weak var myBtn: UIButton!
    @IBOutlet weak var myText1: UITextView!
    @IBOutlet weak var myText2: UITextView!
    @IBOutlet weak var myText3: UITextView!
    @IBOutlet weak var myText4: UITextView!
    @IBOutlet weak var myText5: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myBtn.setTitle("戻る", forState: UIControlState.Normal)
        myBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        myText1.backgroundColor = UIColor(red: 0.789, green: 0.809, blue: 0.98, alpha: 1.0)
        myText1.text="そういえば、おじいちゃん。お隣のおばあさん、この前救急車で運ばれたでしょ。脳梗塞だったんだって。まだ意識が戻らないみたい。今は点滴で様子を見ているけれど、もしかすると胃に穴をあけてチューブで栄養をとらないといけなくなるかもって。"
        myText1.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText2.backgroundColor = UIColor(red: 1.0, green: 0.897, blue: 0.567, alpha: 1.0)
        myText2.text="あんなに元気だったのに…。もう入院して2 週間経つか。いつ何が起こるか、この年になると分からんもんやなぁ…。"
        myText2.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText3.backgroundColor = UIColor(red: 0.789, green: 0.809, blue: 0.98, alpha: 1.0)
        myText3.text="心配だね。おじいちゃんならどう？もしそういう状況になったら。"
        myText3.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText4.backgroundColor = UIColor(red: 1.0, green: 0.897, blue: 0.567, alpha: 1.0)
        myText4.text="人間あるがままが一番や。口から食べられなくなったら無理して生きながらえたくはない。でも、痛かったり苦しかったりするのは嫌やな。"
        myText4.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText5.backgroundColor = UIColor(red: 0.789, green: 0.809, blue: 0.98, alpha: 1.0)
        myText5.text="おじいちゃんがどうしたいかが一番大事だね。他にも病院に運ばれたらどんな治療の可能性があるんだろう。気になってきたな。"
        myText5.font = UIFont.systemFontOfSize(CGFloat(28))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
