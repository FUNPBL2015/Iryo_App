//
//  com5.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/26.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class com5: UIViewController {
    
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
        myText1.text="一通りのことをお伝えしましたが、ご家族としてはいかがですか？"
        myText1.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText2.backgroundColor = UIColor(red: 1.0, green: 0.897, blue: 0.567, alpha: 1.0)
        myText2.text="…。そうですね、正直戸惑っています。家族は兄と私だけですが、兄は遠方で母親のことはお前に任すと言われてしまいました。私個人としては、もう高齢ですし、痛い苦しい思いをしてまで手術させるのは可哀そうというか…。"
        myText2.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText3.backgroundColor = UIColor(red: 0.789, green: 0.809, blue: 0.98, alpha: 1.0)
        myText3.text="娘さんとしては、手術せずにということですね。この場合、痛みのコントロールが主な治療になってくると思います。"
        myText3.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText4.backgroundColor = UIColor(red: 1.0, green: 0.897, blue: 0.567, alpha: 1.0)
        myText4.text="はい。…ただ、母は人一倍向上心が強く、最後まであきらめるなというのが口癖でした。母のことを考えると、少しでも良くなる可能性があるのなら手術を希望するかもしれません。…私だけでは決められません。ケアマネさんにも同席してもらいたいのですが。"
        myText4.font = UIFont.systemFontOfSize(CGFloat(28))
        
        myText5.backgroundColor = UIColor(red: 0.789, green: 0.809, blue: 0.98, alpha: 1.0)
        myText5.text="分かりました。もちろんです。それでは、次回もう一度ケアマネさんも一緒に○○さんの治療について考えていきましょう。"
        myText5.font = UIFont.systemFontOfSize(CGFloat(28))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
