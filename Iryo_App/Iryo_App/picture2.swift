//
//  picture2.swift
//  Iryo_App
//
//  Created by member on 2015/11/05.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class picture2: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    var selectedImg: UIImage!
    
//    var appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate //AppDelegateのインスタンスを取得

    override func viewDidLoad() {
        super.viewDidLoad()

//        imageView.image = appDelegate.images
        imageView.image = selectedImg
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}