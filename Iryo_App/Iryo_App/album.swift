//
//  TopPage.swift
//  Iryo_App
//
//  Created by member on 2015/10/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class album: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let picture = ["cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png","cc-library010009109zzavm.jpg","医師.png"]
//    let title1 = ["背景","医師","背景","医師","背景","医師","背景","医師","背景","医師"]
    
    var Images: UIImage?
    var addBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // タイトルを付けておきましょう
        self.title = "アルバム"
        // addBtnを設置
        addBtn = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "onClick")
            self.navigationItem.rightBarButtonItem = addBtn
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picture.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
//        cell.titleSample.text = title1[indexPath.row]
        cell.imgSample.image = UIImage(named: picture[indexPath.row])
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        Images = UIImage(named: picture[indexPath.row])
        if Images != nil {
            performSegueWithIdentifier("Segues",sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "Segues") {
            let VC: picture2 = (segue.destinationViewController as? picture2)!
            VC.selectedImg = Images
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 6 - 5
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }

}
