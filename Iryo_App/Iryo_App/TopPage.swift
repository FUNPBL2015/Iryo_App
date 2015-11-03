//
//  TopPage.swift
//  Iryo_App
//
//  Created by member on 2015/10/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class TopPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        
        // NavigationBarを非表示にする
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    var sizeX = CGFloat(100)
    var sizeY = CGFloat(300)
    let top = ["トーク","アルバム","マニュアル","使い方"]
    let color = [0xFFFF00,0x00FFFF,0x0000FF,0x00FF00]
    let picture = ["cc-library010009109zzavm.jpg","cc-library010009109zzavm.jpg","cc-library010009109zzavm.jpg","cc-library010009109zzavm.jpg"]
    let x = [470,-470,470,0]
    let y = [0,300,0,0]
    let page = ["talk","album","manual","HowtoUse"]
    
    private var imageView = UIImageView()
    
    let cell = CustomCell()
    
  
    
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
        
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapped:")
        
        // デリゲートをセット
        tapGesture.delegate = self;
        
        // Viewに追加.
        self.view.addGestureRecognizer(tapGesture)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セクションの数（今回は1つだけです）
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 表示するセルの数
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4;
    }
    
    func UIColorFromRGB(rgbValue: Int) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func initImageView(imageName: String){
        
        // UIImage インスタンスの生成
        let image1 = UIImage(named: imageName)
        // UIImageView 初期化
        imageView = UIImageView(image:image1)
        // 画像のサイズ位置指定
        imageView.frame = CGRectMake(sizeX,  sizeY, 100, 100)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        // UIImageViewのインスタンスをビューに追加
        self.view.addSubview(imageView)
        
        
    }
    
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        //cell内のtitle表示
        cell.titleSample.text = top[indexPath.row]
        //cellの色の設定
        cell.backgroundColor = UIColorFromRGB(color[indexPath.row])
        cell.layer.cornerRadius = 150
        //cell内の写真表示
        initImageView(picture[indexPath.row])
        sizeX += CGFloat(x[indexPath.row])
        sizeY += CGFloat(y[indexPath.row])
        
        cell.cellID = page[indexPath.row]
        
        return cell
    }

    
    func tapped(sender: UITapGestureRecognizer){
        collectionView("talk")
    }
    
    
    func collectionView(Name: String) {
        
        switch Name {
            
        case "talk":
            let next : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("talk") as UIViewController!
            self.presentViewController(next as! UIViewController, animated: true, completion: nil)
        
        case "alubm":
            let next : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("alubm") as UIViewController!
            self.presentViewController(next as! UIViewController, animated: true, completion: nil)
        
        case "manual":
            let next : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("manual") as UIViewController!
            self.presentViewController(next as! UIViewController, animated: true, completion: nil)
        
        case "HowtoUse":
            let next : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("HowtoUse") as UIViewController!
            self.presentViewController(next as! UIViewController, animated: true, completion: nil)
        
        default:
            break
        }

        
    }
    
    
}