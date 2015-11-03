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
        
        self.talkButton.backgroundColor = UIColorFromRGB(0xFFFF00)
        self.albumButton.backgroundColor = UIColorFromRGB(0x00FFFF)
        self.manualButton.backgroundColor = UIColorFromRGB(0x0000FF)
        self.useButton.backgroundColor = UIColorFromRGB(0x00FF00)
        self.talkButton.tintColor = UIColorFromRGB(0x000000)
        self.albumButton.tintColor = UIColorFromRGB(0x000000)
        self.manualButton.tintColor = UIColorFromRGB(0x000000)
        self.useButton.tintColor = UIColorFromRGB(0x000000)
        
        initImageView("cc-library010009109zzavm.jpg", pointX: 150, pointY: 275)
        initImageView("cc-library010009109zzavm.jpg", pointX: 450, pointY: 275)
        initImageView("cc-library010009109zzavm.jpg", pointX: 150, pointY: 575)
        initImageView("cc-library010009109zzavm.jpg", pointX: 450, pointY: 575)
        
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
            alpha: CGFloat(1.0)
        )
    }
    
    func initImageView(imageName: String, pointX: CGFloat, pointY: CGFloat){
        
        // UIImage インスタンスの生成
        let image1 = UIImage(named: imageName)
        // UIImageView 初期化
        imageView = UIImageView(image:image1)
        // 画像のサイズ位置指定
        imageView.frame = CGRectMake(pointX,  pointY, 100, 100)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
    }
    
}
