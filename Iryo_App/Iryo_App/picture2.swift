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
    var pictures: [String]!
    var numbars: Int!

    @IBOutlet weak var prevPicture: UIButton!
    @IBOutlet weak var nextPicture: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: pictures[numbars])
        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.nextPicture.addTarget(self, action: Selector("nextPictures"), forControlEvents: .TouchUpInside)
        self.prevPicture.addTarget(self, action: Selector("prevPictures"), forControlEvents: .TouchUpInside)
    }
    
    func nextPictures(){
        if(numbars < pictures.count - 1){
        numbars = numbars + 1
        imageView.image = UIImage(named: pictures[numbars])
        }
    }
    
    func prevPictures(){
        if(numbars > 0){
            numbars = numbars - 1
        imageView.image = UIImage(named: pictures[numbars])
        }
    }
        
        
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}