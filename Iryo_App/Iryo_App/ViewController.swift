//
//  ViewController.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室メンバ on 2015/06/10.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var familyBtn: UIButton!
    @IBOutlet weak var supporterBtn: UIButton!
    @IBOutlet weak var healthproBtn: UIButton!
    
    @IBOutlet weak var infoBtn: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        
        // NavigationBarを非表示にする
            self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //別の画面に遷移する直前

        // NavigationBarを表示する
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        // NavigationBarの高さを設定する
            self.navigationController?.navigationBar.frame.size.height = 60

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //背景画像表示
        let backImage: UIImage = UIImage(named: "homeImg.png")!
        let myImageView: UIImageView = UIImageView()
        myImageView.image = backImage
        myImageView.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height)
        self.view.addSubview(myImageView)
        self.view.sendSubviewToBack(myImageView)//最背面に表示
        
        titleLabel.text = "医療サポーターガイドブック"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont(name: "HiraKakuProN-W6", size: 55)
        
        subtitleLabel.text = "よりよい医療のために"
        subtitleLabel.textColor = UIColor.whiteColor()
        subtitleLabel.font = UIFont(name: "HiraKakuProN-W6", size: 40)
        
        //家族向けボタン
        familyBtn.setTitle("家族向け", forState: UIControlState.Normal)
        familyBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        familyBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        familyBtn.backgroundColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.7)
        familyBtn.layer.cornerRadius = 5
        familyBtn.addTarget(self, action: "DownButton1:", forControlEvents: .TouchDown)
        familyBtn.addTarget(self, action: "UpButton1:", forControlEvents: .TouchUpInside)
        familyBtn.addTarget(self, action: "UpButton1:", forControlEvents: .TouchUpOutside)
        
        //支援者向け
        supporterBtn.setTitle("在宅スタッフ向け", forState: UIControlState.Normal)
        supporterBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        supporterBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        supporterBtn.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0.3, alpha: 0.7)
        supporterBtn.layer.cornerRadius = 5
        
        //医療従業者向け
        healthproBtn.setTitle("医療従業者向け", forState: UIControlState.Normal)
        healthproBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        healthproBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        healthproBtn.backgroundColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.7)
        healthproBtn.layer.cornerRadius = 5
        
        //info
        infoBtn.setTitle("このアプリについて", forState: UIControlState.Normal)
        infoBtn.titleLabel!.font = UIFont(name: "HiraKakuProN-W6",size: 30)
        infoBtn.setTitleColor(UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.7), forState: UIControlState.Normal)
        infoBtn.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        infoBtn.layer.cornerRadius = 5
        infoBtn.layer.borderWidth = 5
        infoBtn.layer.borderColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.7).CGColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //家族ボタンの押したときのアクション
    internal func DownButton1(sender: UIButton){
        familyBtn.backgroundColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.5)
    }
    internal func UpButton1(sender: UIButton){
        familyBtn.backgroundColor = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.7)
    }


}

