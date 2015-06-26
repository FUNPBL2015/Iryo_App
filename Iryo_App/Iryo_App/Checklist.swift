//
//  ViewController.swift
//  checklist
//
//  Created by 公立はこだて未来大学高度ICTコース on 2015/06/22.
//  Copyright (c) 2015年 公立はこだて未来大学高度ICTコース. All rights reserved.
//

import UIKit

class Checklist: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myBtny1: UIButton!
    @IBOutlet weak var myBtnn1: UIButton!
    @IBOutlet weak var myLabel2: UILabel!
    @IBOutlet weak var myBtny2: UIButton!
    @IBOutlet weak var myBtnn2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myLabel.text="認知症と診断されたことがあります。"
        myLabel.numberOfLines=20
        myLabel.font=UIFont(name:"HiraKakuProN-W6",size: 28)
        
        myBtny1.setTitle("はい", forState: UIControlState.Normal)
        myBtny1.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtny1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtny1.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        myBtnn1.setTitle("いいえ", forState: UIControlState.Normal)
        myBtnn1.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtnn1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtnn1.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        myLabel2.text="本人には認知症であると説明していません。"
        myLabel2.numberOfLines=20
        myLabel2.font=UIFont(name:"HiraKakuProN-W6",size: 28)
        
        myBtny2.setTitle("はい", forState: UIControlState.Normal)
        myBtny2.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtny2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtny2.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        myBtnn2.setTitle("いいえ", forState: UIControlState.Normal)
        myBtnn2.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        myBtnn2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBtnn2.backgroundColor = UIColor(red: 0, green: 0.5, blue: 0.8, alpha: 0.5)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

