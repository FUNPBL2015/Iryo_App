//
//  TopPage.swift
//  Iryo_App
//
//  Created by member on 2015/10/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class TopPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        
        // NavigationBarを非表示にする
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    var i = 0
    let top = ["トーク","アルバム","マニュアル","使い方"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
    // セルが表示されるときに呼ばれる処理（1個のセルを描画する毎に呼び出されます)
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        cell.titleSample.text = top[i]
        //cell.imgSample.image = UIImage(named: "smile.png")
        cell.backgroundColor = UIColor.blueColor()
        i += 1
        return cell
    }
    
}