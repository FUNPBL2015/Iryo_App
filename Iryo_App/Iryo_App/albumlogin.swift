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
    let myLabel = UILabel(frame: CGRectMake(0,0,500,100))
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        loadData()
        allButton.enabled = true
        // ToolBarを非表示にする
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidDisappear(animated: Bool) {
        //別の画面に遷移した後
        user = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "ユーザー選択"
        
        //ボタンの同時押しを禁止する
        self.exclusiveAllTouches()
        
        myLabel.textColor = UIColor.blackColor()
        myLabel.layer.masksToBounds = true
        myLabel.text = "見たい人を選んでください"
        myLabel.font = UIFont.systemFontOfSize(35)
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-874)
        self.view.addSubview(myLabel)
        
        decide.addTarget(self, action: "clickDecideButton:", forControlEvents: .TouchUpInside)
        allButton.addTarget(self, action: "allSelect:", forControlEvents: .TouchUpInside)
    }
    
    func loadData()  {
        let query: PFQuery = PFUser.query()!
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error == nil){
                for row:PFObject in objects! {
                    self.user.append(row)
                }
                self.loginView.reloadData()
            }
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
        
        let displayName: String? = user[indexPath.row].objectForKey("displayName") as! String?
        cell.userName.text = displayName

        if cell.alpha != 1.0 || cell.layer.borderWidth != 0{
            cell.alpha = 1.0
            cell.layer.borderWidth = 0
        }
        
        let imageFile: PFFile? = user[indexPath.row].objectForKey("profilePictureSmall") as! PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if(error == nil) {
                cell.userPicture!.image = UIImage(data: imageData!)!
            }
        })
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        if(user.count != 0){
        var m = 0
        var location:[Int] = []
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)!
        
        username.append(user[indexPath.row].objectForKey("username") as! String)
        let check: String = user[indexPath.row].objectForKey("username") as! String
        for(var i = 0 ; i < username.count ; i++){
            if(check == username[i] as! String){
                m++
                location.append(i)
                if(m % 2 == 0){
                    username.removeAtIndex(location[1])
                    username.removeAtIndex(location[0])
                    cell.selected = false
                    print(username)
                }
            }
        }
        if cell.selected == true {
            cell.alpha = 0.5
            cell.layer.borderWidth = 2
        } else if cell.selected == false {
            cell.alpha = 1.0
            cell.layer.borderWidth = 0
        }
        }
    }
    
    func allSelect(sender: UIButton){
        username = []
        for(var i = 0 ; i < user.count ; i++){
            username.append(user[i].objectForKey("username") as! String)
        }
        performSegueWithIdentifier("albumsegue",sender: nil)
        print(username)
        username = []
        allButton.enabled = false
    }
    
    func clickDecideButton(sender: UIButton){
        if(username.count != 0){
            performSegueWithIdentifier("albumsegue",sender: nil)
            print(username)
            username = []
            myLabel.textColor = UIColor.blackColor()
        }else{
            myLabel.textColor = UIColor.redColor()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "albumsegue") {
            let VC = segue.destinationViewController as! album
            VC.usernames = username
        }
    }
    
}