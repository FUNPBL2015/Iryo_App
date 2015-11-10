//
//  Top.swift
//  Iryo_App
//
//  Created by member on 2015/11/01.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Top: UIViewController {
    
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var manualButton: UIButton!
    @IBOutlet weak var useButton: UIButton!
    
    private var imageView = UIImageView()
    
//    override func viewWillAppear(animated: Bool) {
//        //画面が表示される直前
//        
//        // NavigationBarを非表示にする
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        //別の画面に遷移する直前
//        
//        // NavigationBarを表示する
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myLabel = UILabel(frame: CGRectMake(0,0,120,50))
        myLabel.textColor = UIColor.blackColor()
        myLabel.layer.masksToBounds = true
        myLabel.text = "タイトル"
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-924)
        self.view.addSubview(myLabel)
        
        self.talkButton.backgroundColor = UIColorFromRGB(0xFF00FF)
        self.albumButton.backgroundColor = UIColorFromRGB(0x00FF00)
        self.manualButton.backgroundColor = UIColorFromRGB(0x0000FF)
        self.useButton.backgroundColor = UIColorFromRGB(0xFF9900)
        self.talkButton.tintColor = UIColorFromRGB(0x000000)
        self.albumButton.tintColor = UIColorFromRGB(0x000000)
        self.manualButton.tintColor = UIColorFromRGB(0x000000)
        self.useButton.tintColor = UIColorFromRGB(0x000000)
        
        initImageView("cc-library010009109zzavm.jpg", pointX: 150, pointY: 350, pointW: 100, pointH: 100)
        initImageView("cc-library010009109zzavm.jpg", pointX: 518, pointY: 350, pointW: 100, pointH: 100)
        initImageView("cc-library010009109zzavm.jpg", pointX: 150, pointY: 718, pointW: 100, pointH: 100)
        initImageView("cc-library010009109zzavm.jpg", pointX: 518, pointY: 718, pointW: 100, pointH: 100)
        
        // UIImage インスタンスの生成
        let image = UIImage(named: "背景.png")
        // UIImageView 初期化
        imageView = UIImageView(image:image)
        // 画像のサイズ位置指定
        imageView.frame = CGRectMake(0, 0, 768, 1024)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func UIColorFromRGB(rgbValue: Int) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.9)
        )
    }
    
    func initImageView(imageName: String, pointX: CGFloat, pointY: CGFloat, pointW: CGFloat, pointH: CGFloat){
        
        // UIImage インスタンスの生成
        let image1 = UIImage(named: imageName)
        // UIImageView 初期化
        imageView = UIImageView(image:image1)
        // 画像のサイズ位置指定
        imageView.frame = CGRectMake(pointX,  pointY, pointW, pointH)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
    }
    
}
