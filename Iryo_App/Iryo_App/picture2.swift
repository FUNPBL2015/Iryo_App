//
//  picture2.swift
//  Iryo_App
//
//  Created by member on 2015/11/05.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import Parse

class picture2: UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    var pictures: [AnyObject]!
    var numbers: Int!

    @IBOutlet weak var prevPicture: UIButton!
    @IBOutlet weak var nextPicture: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        
        // ToolBarを非表示にする
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    override func viewWillDisappear(animated: Bool) {
        //別の画面に遷移する直前
        
        // ToolBarを表示する
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.toolbar.frame = CGRectMake(0, 924, 768, 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPicture()

        // 画像のアスペクト比を維持しUIImageViewサイズに収まるように表示
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        self.nextPicture.addTarget(self, action: Selector("nextPictures"), forControlEvents: .TouchUpInside)
        self.prevPicture.addTarget(self, action: Selector("prevPictures"), forControlEvents: .TouchUpInside)
    }
    
    func nextPictures(){
        if(numbers < pictures.count - 1){
            numbers = numbers + 1
            showPicture()
        }else{
            numbers = 0
           showPicture()
        }
    }
    
    func prevPictures(){
        if(numbers > 0){
            numbers = numbers - 1
            showPicture()
        }else{
            numbers = pictures.count - 1
            showPicture()
        }
    }
    
    func showPicture(){
        let imageFile: PFFile? = self.pictures[numbers].objectForKey("graphicFile") as! PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if(error == nil) {
                self.imageView.image = UIImage(data: imageData!)!
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}