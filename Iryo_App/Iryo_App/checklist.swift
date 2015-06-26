//
//  checklist.swift
//  Iryo_App
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/26.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class checklist: UIViewController {
    
    @IBOutlet weak var myBtn: UIButton!
    @IBOutlet weak var myLabel1: UILabel!
    @IBOutlet weak var myBtny1: UIButton!
    @IBOutlet weak var myBtnn1: UIButton!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myBtny2: UIButton!
    @IBOutlet weak var myBtnn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myBtn.setTitle("戻る", forState: UIControlState.Normal)
        myBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtn.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        myLabel1.text="認知症と診断されたことがあります。"
        myLabel1.numberOfLines=20
        myLabel1.font=UIFont(name:"HiraKakuProN-W6",size: 28)
        
        myBtny1.setTitle("はい", forState: UIControlState.Normal)
        myBtny1.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtny1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtny1.backgroundColor = UIColor(red: 0.3, green: 0.9, blue: 0.3, alpha: 0.5)
        
        myBtnn1.setTitle("いいえ", forState: UIControlState.Normal)
        myBtnn1.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtnn1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtnn1.backgroundColor = UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 0.5)
        
        myLabel2.text="本人には認知症であると説明していません。"
        myLabel2.numberOfLines=20
        myLabel2.font=UIFont(name:"HiraKakuProN-W6",size: 28)
        
        myBtny2.setTitle("はい", forState: UIControlState.Normal)
        myBtny2.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtny2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtny2.backgroundColor = UIColor(red: 0.3, green: 0.9, blue: 0.3, alpha: 0.5)
        
        myBtnn2.setTitle("いいえ", forState: UIControlState.Normal)
        myBtnn2.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtnn2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtnn2.backgroundColor = UIColor(red: 0.9, green: 0.3, blue: 0.3, alpha: 0.5)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
