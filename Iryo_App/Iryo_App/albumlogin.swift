//
//  albumlogin.swift
//  Iryo_App
//
//  Created by member on 2015/11/26.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import Parse

class albumlogin: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var loginView: UICollectionView!
    @IBOutlet weak var decide: UIButton!
    @IBOutlet weak var allButton: UIButton!
    var user:[AnyObject] = []
    var number:[AnyObject] = []
    var username:[AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "ユーザー選択"
        
        let myLabel = UILabel(frame: CGRectMake(0,0,500,100))
        myLabel.textColor = UIColor.blackColor()
        myLabel.layer.masksToBounds = true
        myLabel.text = "見たい人を選んでください"
        myLabel.font = UIFont.systemFontOfSize(35)
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-874)
        self.view.addSubview(myLabel)
        
        decide.addTarget(self, action: "clickDecideButton:", forControlEvents: .TouchUpInside)
        allButton.addTarget(self, action: "allSelect:", forControlEvents: .TouchUpInside)
        
        loadData()

    }
    
    func loadData()  {
        let query: PFQuery = PFUser.query()!
//        query.includeKey(myChatsUserKey)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error != nil){
                // エラー処理
                return
            }
            for row:PFObject in objects! {
                self.user.append(row)
            }
            self.loginView.reloadData()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("usercell", forIndexPath: indexPath) as! CustomCell
        
//        print(user[indexPath.row].objectForKey("username"))
    
        let imageFile: PFFile? = user[indexPath.row].objectForKey("profilePictureSmall") as! PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if(error == nil) {
                cell.userPicture.image = UIImage(data: imageData!)!
            }
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        var m = 0
        var location:[Int] = []
//        print(String(user[indexPath.row].objectForKey("username")))
        username.append(user[indexPath.row].objectForKey("username") as! String)
        let check: String = user[indexPath.row].objectForKey("username") as! String
        for(var i = 0 ; i < username.count ; i++){
            if(check == username[i] as! String){
                m++
                location.append(i)
                if(m / 2 == 1){
                username.removeAtIndex(location[1])
                username.removeAtIndex(location[0])
                    print(username)
                }
            }
        }
    }
    
    func clickDecideButton(sender: UIButton){
        performSegueWithIdentifier("albumsegue",sender: nil)
        username = []
    }
    
    func allSelect(sender: UIButton){
        var n = username.count
        for(n ; n > 0 ; n--){
            username.removeAtIndex(n-1)
        }
        for(var i = 0 ; i < user.count ; i++){
        username.append(user[i].objectForKey("username") as! String)
        }
        print(username)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "albumsegue") {
            let VC = segue.destinationViewController as! album
            VC.usernames = username
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 5 - 2
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
}