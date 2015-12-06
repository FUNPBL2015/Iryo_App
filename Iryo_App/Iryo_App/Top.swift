//
//  Top.swift
//  Iryo_App
//
//  Created by member on 2015/11/01.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import Parse

class Top: UIViewController {
    
    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var albumButton: UIButton!
    @IBOutlet weak var manualButton: UIButton!
    @IBOutlet weak var useButton: UIButton!
    
    private var imageView = UIImageView()
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        
        // NavigationBarを非表示にする
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //別の画面に遷移する直前
        
        // NavigationBarを表示する
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // NavBarを生成
        self.navigationController?.navigationBar
        navigationItem.title = "ホーム"
        
        //ボタンの同時押しを禁止する
        self.exclusiveAllTouches()
        
//        let myLabel = UILabel(frame: CGRectMake(0,0,120,50))
//        myLabel.textColor = UIColor.blackColor()
//        myLabel.layer.masksToBounds = true
//        myLabel.text = "タイトル"
//        myLabel.textAlignment = NSTextAlignment.Center
//        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-924)
//        self.view.addSubview(myLabel)
        
        //ボタンの同時押しを禁止する
        self.exclusiveAllTouches()
        
        self.talkButton.backgroundColor = UIColorFromRGB(0xFFFFFF)
        self.albumButton.backgroundColor = UIColorFromRGB(0xFFFFFF)
        self.manualButton.backgroundColor = UIColorFromRGB(0xFFFFFF)
        self.useButton.backgroundColor = UIColorFromRGB(0xFFFFFF)
        
        self.talkButton.layer.shadowOpacity = 0.8
        self.talkButton.layer.shadowOffset = CGSizeMake(-10, 10)
        self.albumButton.layer.shadowOpacity = 0.8
        self.albumButton.layer.shadowOffset = CGSizeMake(-10, 10)
        self.manualButton.layer.shadowOpacity = 0.8
        self.manualButton.layer.shadowOffset = CGSizeMake(-10, 10)
        self.useButton.layer.shadowOpacity = 0.8
        self.useButton.layer.shadowOffset = CGSizeMake(-10, 10)
        
        initImageView("tabi_camera_nikki.png", pointX: 125, pointY: 350, pointW: 150, pointH: 150)
        initImageView("album_photo.png", pointX: 493, pointY: 350, pointW: 150, pointH: 150)
        initImageView("book_tate.png", pointX: 125, pointY: 718, pointW: 150, pointH: 150)
        initImageView("roujin_TVdenwa.png", pointX: 493, pointY: 718, pointW: 150, pointH: 150)
        initImageView("にこり.png", pointX: 84, pointY: 50, pointW: 600, pointH: 200)
        
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
    
    @IBAction func shouldTransportTalkView(sender: AnyObject) {
        if PFUser.currentUser() == nil{
            let welcomeTalkView: WelcomeTalkVC? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("WelcomeTalkVC") as? WelcomeTalkVC
            self.navigationController?.pushViewController(welcomeTalkView!, animated: true)
        }else{
            let delegate: AppDelegate? = UIApplication.sharedApplication().delegate as? AppDelegate
            self.navigationController?.pushViewController(delegate!.myTabBarController, animated: true)
        }
    }
    
    @IBAction func shouldTransportAlbumView(sender: AnyObject) {
            let albumView: albumlogin? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("albumlogin") as? albumlogin
            self.navigationController?.pushViewController(albumView!, animated: true)
           }
    
    func UIColorFromRGB(rgbValue: Int) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
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
