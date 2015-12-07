//
//  TalkView.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/10/30.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import MobileCoreServices
import Parse
import ParseUI
import Synchronized
import FormatterKit

class TalkView: PFQueryTableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate{
    // debug
    private var shouldReloadOnAppear: Bool = false
    private var outstandingSectionHeaderQueries: [NSObject:AnyObject]
    
    private let emptyText: UILabel = UILabel(frame: CGRectMake(myScreenWidth / 2 - 50, myScreenHeight / 2 - 30, 100, 30))
    var allObjects: [NSString]
    private var nonPostCellNum: Int
    
    deinit {
        let defaultNotificationCenter = NSNotificationCenter.defaultCenter()
        defaultNotificationCenter.removeObserver(self, name: "TalkView.didFinishEditingPhoto", object: nil)
        defaultNotificationCenter.removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    override init(style: UITableViewStyle, className: String?) {
        self.outstandingSectionHeaderQueries = [NSObject:AnyObject]()
        self.nonPostCellNum = 0
        
        if let t = NSUserDefaults.standardUserDefaults().objectForKey("talkViewAllObjects") as? [NSString]{
            self.allObjects = t
        }else{
            self.allObjects = []
        }
        
        super.init(style: style, className: myChatsClassKey)
        self.parseClassName = myChatsClassKey
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.loadingViewEnabled = false
        self.shouldReloadOnAppear = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // 投稿がない時の表示
        // FIXME: 初回起動時にプログレスバーと同時表示される
        if self.objects!.count + NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum") == 0{
            emptyText.text = "Nodata"
            emptyText.font = UIFont.systemFontOfSize(30)
            self.view.addSubview(emptyText)
        }else if emptyText.isDescendantOfView(self.view){
            emptyText.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        synchronized(self){
            self.loadObjects()
        }
        
        //initial tableView style
        let texturedBackgroundView = UIView(frame: self.view.bounds)
        texturedBackgroundView.backgroundColor = UIColor.hexStr("FFEBCD", alpha: 0.5)
        self.tableView.backgroundView = texturedBackgroundView
        self.tableView.separatorColor = UIColor.clearColor()
        //self.tableView.showsVerticalScrollIndicator = false
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(
            0.0, 0.0, 100.0, 0.0)
        
        let defaultNotificationCenter = NSNotificationCenter.defaultCenter()
        defaultNotificationCenter.addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        defaultNotificationCenter.addObserver(self, selector: Selector("userDidPublishPhoto:"), name: "TalkView.didFinishEditingPhoto", object: nil)
        
        //initial navbar
        let logoutBtn: UIBarButtonItem! = UIBarButtonItem(title: "×", style: .Plain, target: self, action: "didTapOnLogoutBtn")
        logoutBtn
        let postBtn: UIBarButtonItem! = UIBarButtonItem(title: "写真の投稿", style: .Plain, target: self, action: "didTapOnPostBtn")
        postBtn.setTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -15.0), forBarMetrics: .Default)
        //let addBtn: UIBarButtonItem! = UIBarButtonItem(title: "追加", style: .Plain, target: self, action: "didTapOnAddBtn")
        
        let navRightBtns: NSArray = [postBtn, logoutBtn]
        self.tabBarController!.navigationItem.setRightBarButtonItems(navRightBtns as? [UIBarButtonItem], animated: true)

        self.loadNonPostCellData()
        
        // MARK: intentionView
        intentionDisplayLink = CADisplayLink(target: intentionView!, selector: Selector("update:"))
        intentionDisplayLink!.frameInterval = 10
        intentionDisplayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
        // debug：titleに経過時間を表示する
        let displayLinkTest = CADisplayLink(target: intentionView!, selector: Selector("update_test:"))
        displayLinkTest.frameInterval = 10
        displayLinkTest.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
        // MARK: topicView
        topicDisplayLink = CADisplayLink(target: topicView!, selector: Selector("update:"))
        topicDisplayLink!.frameInterval = 10
        topicDisplayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
        // MARK: tipsView
        tipsDisplayLink = CADisplayLink(target: tipsView!, selector: Selector("update:"))
        tipsDisplayLink!.frameInterval = 10
        tipsDisplayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController!.navigationItem.title = PFUser.currentUser()!.username

        // MARK: 画面外にいるときに追加された他セルを同期する
        // テスト段階
//        if NSUserDefaults.standardUserDefaults().boolForKey("firstLaunchAtTalkView")  {
//            var standnum: Int = NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum")
//            if standnum != Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval){
//                let standing = Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval) - standnum
//                for _ in 0..<standing{
//                    self.allObjects.insert("tips", atIndex: 0)
//                    standnum++
//                }
//                NSUserDefaults.standardUserDefaults().setInteger(standnum, forKey: "tipscellnum")
//                NSUserDefaults.standardUserDefaults().setObject(self.allObjects as NSArray, forKey: "talkViewAllObjects")
//                NSUserDefaults.standardUserDefaults().synchronize()
//            }
//        }
    }
    
    // テーブルがリロードされる時
    override func objectsDidLoad(error: NSError?) {
        super.objectsDidLoad(error)
        var newObjects: [NSString] = [], tempObjects: [NSString] = allObjects
        
        if  allObjects.count != 0 && self.objects!.count != 0{
            tempObjects.remove("tips")
            tempObjects.remove("topic")
            tempObjects.remove("intention")
            
            for o in self.objects!{
                if let _o: NSString = o.objectId { newObjects.append(_o) }
            }
            
            // allObjectsを更新する
            if  newObjects != tempObjects {
                
                let checker: Int = self.objects!.count - tempObjects.count
                
                switch checker{
                    case let c where c > 0: // 投稿した時
                        for x in newObjects.except(tempObjects) {
                            allObjects.insert(x,atIndex: 0)
                        }
                    case let c where c < 0: // 削除した時
                        for x in tempObjects.except(newObjects) {
                            allObjects.remove(x)
                        }
                    case 0: //投稿と削除を同じ数だけ行った時
                        for x in newObjects.except(tempObjects) {
                            allObjects.insert(x,atIndex: 0)
                        }
                        for x in tempObjects.except(newObjects) {
                            allObjects.remove(x)
                        }
                    default: break
                }
                
                NSUserDefaults.standardUserDefaults().setObject(allObjects as NSArray, forKey: "talkViewAllObjects")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    }

    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }

    // debug: セル追加処理
//    func didTapOnAddBtn(){
//        var setnum: Int = NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum")
//        
//        self.tableView.beginUpdates()
//        setnum++
//        NSUserDefaults.standardUserDefaults().setInteger(setnum, forKey: "tipscellnum")
//        allObjects.insert("tips", atIndex: 0)
//        
//        NSUserDefaults.standardUserDefaults().setObject(allObjects as NSArray, forKey: "talkViewAllObjects")
//        NSUserDefaults.standardUserDefaults().synchronize()
//        
//        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
//        self.tableView.endUpdates()
//    }
    
    // ログアウト処理
    func didTapOnLogoutBtn(){
        PFUser.logOut()
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    // 投稿処理
    func didTapOnPostBtn(){
        
        // 投稿するときにPaintViewを初期化する
        paintView = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PaintVC") as? PaintVC
        
        let cameraDeviceAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        let photoLibraryAvailable: Bool = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        
        if cameraDeviceAvailable && photoLibraryAvailable {
            let actionController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
            
            let takePhotoAction = UIAlertAction(title: NSLocalizedString("カメラで写真を撮る", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartCameraController() })
            
            let choosePhotoAction = UIAlertAction(title: NSLocalizedString("保存している写真から選ぶ", comment: ""), style: UIAlertActionStyle.Default, handler: { _ in self.shouldStartPhotoLibraryPickerController() })
            let cancelAction = UIAlertAction(title: NSLocalizedString("キャンセル", comment: ""), style: UIAlertActionStyle.Cancel, handler: nil)
            
            // iPadではpopover指定する
            if let popoverController = actionController.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.barButtonItem = self.tabBarController!.navigationItem.rightBarButtonItem
            }
            
            actionController.addAction(takePhotoAction)
            actionController.addAction(choosePhotoAction)
            actionController.addAction(cancelAction)
            
            self.presentViewController(actionController, animated: true, completion: nil)
        } else {
            self.shouldPresentPhotoCaptureController()
        }
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("objectis......\(self.objects!.count)")
//        print("tips......\(NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum"))")
//        print("topic......\(NSUserDefaults.standardUserDefaults().integerForKey("topiccellnum"))")
//        print("intention......\(NSUserDefaults.standardUserDefaults().integerForKey("intentioncellnum"))")
//        print("all......\(self.objects!.count + NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum") + NSUserDefaults.standardUserDefaults().integerForKey("topiccellnum"))")
        return self.objects!.count + NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum") + NSUserDefaults.standardUserDefaults().integerForKey("topiccellnum") + NSUserDefaults.standardUserDefaults().integerForKey("intentioncellnum")// + (self.paginationEnabled ? 1 : 0)
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // Navbar用bottom-margin
        return 120.0
    }
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        //フッターボタンにセルが隠れないようにbottom-marginを付ける
        let tableFooter: UILabel    = UILabel(frame: CGRectMake(0.0, 0.0, self.view.frame.width, 120.0))
        tableFooter.backgroundColor = UIColor.clearColor()
        return tableFooter
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 2 * myScreenHeight / 3
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if self.objectAtIndexPath(indexPath) == nil{
            self.loadNextPage()
        }
    }
    
    override func queryForTable() -> PFQuery {
        
        let query: PFQuery = PFQuery(className: self.parseClassName!)
        query.limit = 30
        query.includeKey(myChatsUserKey)
        query.orderByDescending("createdAt")
        
        query.cachePolicy = PFCachePolicy.NetworkOnly
        
        if (self.objects!.count == 0 ||  UIApplication.sharedApplication().delegate!.performSelector(Selector("isParseReachable")) == nil){
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        return query
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath?) -> PFObject? {
        let index = self.indexForObjectAtIndexPath(indexPath!)
        
        self.nonPostCellNum = 0
        
        // MARK: allObjects初期化
        if !NSUserDefaults.standardUserDefaults().boolForKey("firstLaunchAtTalkView")  {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunchAtTalkView")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            if self.objects!.count != 0 {
                for o in self.objects!{
                    if let _o: NSString = o.objectId { allObjects.append(_o) }
                }
                
                NSUserDefaults.standardUserDefaults().setObject(allObjects as NSArray, forKey: "talkViewAllObjects")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
    
        // 参照しているセルまでに、投稿以外のセルいくつあるのかをカウントする
        for i in 0..<index{
            if allObjects[i] == "tips" || allObjects[i] == "topic" || allObjects[i] == "intention"{
                self.nonPostCellNum++
            }
        }

        
        // 投稿以外のセルがあれば、その分セルの順番をずらす
        if self.nonPostCellNum > 0 && index < self.objects!.count + self.nonPostCellNum{
            return self.objects![index - nonPostCellNum] as? PFObject
        }else if index < self.objects!.count {
            return self.objects![index] as? PFObject
        }
        
        return nil
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        let CellIdentifier = "Cell01"
        var tipsPostCellNum = 0, topicPostCellNum = 0, intentionPostCellNum = 0
        
        let index = self.indexForObjectAtIndexPath(indexPath) - self.nonPostCellNum
        
        synchronized(self){
            for i in 0..<indexPath.row{
                if allObjects[i] != "tips"{
                    tipsPostCellNum++
                }
            }
            
            for i in 0..<indexPath.row{
                if allObjects[i] != "topic"{
                    topicPostCellNum++
                }
            }
            
            for i in 0..<indexPath.row{
                if allObjects[i] != "intention"{
                    intentionPostCellNum++
                }
            }
        }
        
        if  allObjects[indexPath.row] == "tips" {
            let CellIdentifier = "Cell02"
            var cell: TipsViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? TipsViewCell
            
            if cell == nil {
                cell = TipsViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
            }
            
            let p = tipsDataarray.count - tipsCount - indexPath.row + tipsPostCellNum - 1
            if tipsCount != nil && tipsDataarray != nil && p >= 0{
                cell!.mylabel.text = tipsDataarray[tipsDataarray.count - tipsCount - indexPath.row + tipsPostCellNum - 1][0]
                cell!.myTextView?.text = tipsDataarray[tipsDataarray.count - tipsCount - indexPath.row + tipsPostCellNum - 1][1]
                cell!.myPhoto?.text = tipsDataarray[tipsDataarray.count - tipsCount - indexPath.row + tipsPostCellNum - 1][2]
            }
            
            return cell
            
        }else if  allObjects[indexPath.row] == "topic" {
            let CellIdentifier = "Cell03"
            var cell: TopicViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? TopicViewCell
            
            if cell == nil {
                cell = TopicViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
            }
            
            let p = topicDataarray.count - topicCount - indexPath.row + topicPostCellNum - 1
            if topicCount != nil && topicDataarray != nil && p >= 0{
                cell!.mylabel.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row + topicPostCellNum - 1][0]
                cell!.myTextView?.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row + topicPostCellNum - 1][1]
                cell!.myPhoto?.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row + topicPostCellNum - 1][2]
            }
            
            return cell
            
        }else if  allObjects[indexPath.row] == "intention" {
            let CellIdentifier = "Cell04"
            var cell: IntentionViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? IntentionViewCell
            
            if cell == nil {
                cell = IntentionViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
            }
            
            let p = intentionDataarray.count - intentionCount - indexPath.row + intentionPostCellNum - 1
            if intentionCount != nil && intentionDataarray != nil && p >= 0{
                cell!.mylabel.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row + intentionPostCellNum - 1][0]
                cell!.myTextView?.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row + intentionPostCellNum - 1][1]
                cell!.myPhoto?.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row + intentionPostCellNum - 1][2]
            }
            
            return cell
            
        }else{
            var cell: TalkViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? TalkViewCell
            
            if cell == nil {
                cell = TalkViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
                
                cell!.photoButton!.addTarget(self, action: Selector("didTapOnPhotoAction:"), forControlEvents: UIControlEvents.TouchUpInside)
                cell!.commentsReturn!.addTarget(self, action: Selector("didTapOnReturnBtnAction:event:"), forControlEvents: .TouchUpInside)
            }
            
            cell!.commentField!.tag = index
            cell!.commentField!.delegate = self
            
            cell!.commentsReturn!.tag = index
            cell!.comments!.tag = index
            cell!.photoButton!.tag = index
            cell!.imageView!.image = UIImage(named: "PlaceholderPhoto.png")
            cell!.avatarImageView!.image = UIImage(named: "AvatarPlaceholder.png")
            
            if object != nil {
                
                let activity = PFQuery(className: myActivityClassKey)
                activity.whereKey(myActivityPhotoKey, equalTo: object!)
                activity.includeKey(myActivityFromUserKey)
                activity.cachePolicy = .CacheThenNetwork
                
                cell!.imageView!.file = object!.objectForKey(myChatsThumbnailKey) as? PFFile
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                cell!.timestanpLabel!.text =  dateFormatter.stringFromDate(object!.createdAt!)//TTTTimeIntervalFormatter().stringForTimeInterval(object!.createdAt!.timeIntervalSinceNow)
                
                cell!.userName!.text = "匿名"
                if let n = object!.objectForKey(myChatsUserKey)?.objectForKey("displayName") as? String{
                    cell!.userName!.text = n
                }
                
                if let p = object!.objectForKey(myChatsUserKey)?.objectForKey(myUserProfilePicSmallKey) as? PFFile{
                    cell!.avatarImageView!.file = p
                    cell!.avatarImageView!.loadInBackground()
                }
                
                if cell!.imageView!.file!.isDataAvailable {
                    cell!.imageView!.loadInBackground()
                }
                
                //FIXME: コメントがないときの処理
                // countObjects or getfirstobject or findobjects
                // cacheとnetwork分の2回読まれてしまう
                // queryForTable()のcachethennetworkを消すか、nilを代入すれば解消されます
                
                // 同期処理を使って確実にコメントを取得する
                synchronized(self) {
                    let outstandingSectionHeaderQueryStatus: Int? = self.outstandingSectionHeaderQueries[index] as? Int
                    if outstandingSectionHeaderQueryStatus == nil {
                        activity.findObjectsInBackgroundWithBlock { (objects, error) in
                            if error == nil && objects!.count > 0 {
                                cell!.comments!.text = nil
                                for row: PFObject in objects! {
                                    cell!.comments!.text = cell!.comments!.text!.stringByAppendingString((row.objectForKey(myActivityFromUserKey)!.username!)! + ": " + (row.objectForKey("content") as! String) + "\n")
                                }
                            }else{
                                if cell!.comments!.text != "コメントがありません" { cell!.comments!.text = "コメントがありません" }
                            }
                        }
                    }
                }
            }
            
            return cell
        }
    }
    
    //MARK: TalkView
    
    // 豆知識や医療トピックなどのデータを読み込む
    // TODO: 整理
    func loadNonPostCellData(){
        // csvファイルの読み込み
        
        var path: [String]! = [String]()
        path.append((NSBundle.mainBundle().pathForResource("intentionData", ofType: "csv"))!)
        path.append((NSBundle.mainBundle().pathForResource("topicData", ofType: "csv"))!)
        path.append((NSBundle.mainBundle().pathForResource("tipsData", ofType: "csv"))!)
        
        // intentionView
        var data = try! String(contentsOfFile: path[0], encoding: NSUTF8StringEncoding)
        var lines = data.componentsSeparatedByString("\n")
        for line in lines{
            intentionDataarray.append(line.componentsSeparatedByString(","))
        }
        // 表示できる残りセル数をカウント
        if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(intentionInterval) >= intentionDataarray.count{
            intentionCount = 0
        }else{
            intentionCount = intentionDataarray.count - Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(intentionInterval)
        }
        
        // topicView
        data = try! String(contentsOfFile: path[1], encoding: NSUTF8StringEncoding)
        lines = data.componentsSeparatedByString("\n")
        for line in lines{
            topicDataarray.append(line.componentsSeparatedByString(","))
        }
        // 表示できる残りセル数をカウント
        if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval) >= topicDataarray.count{
            topicCount = 0
        }else{
            topicCount = topicDataarray.count - Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval)
        }
        
        // tipsView
        data = try! String(contentsOfFile: path[2], encoding: NSUTF8StringEncoding)
        lines = data.componentsSeparatedByString("\n")
        for line in lines{
            tipsDataarray.append(line.componentsSeparatedByString(","))
        }
        // 表示できる残りセル数をカウント
        if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval) >= tipsDataarray.count{
            tipsCount = 0
        }else{
            tipsCount = tipsDataarray.count - Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval)
        }
    }
    
    // 写真をタップした時
    func didTapOnPhotoAction(sender: UIButton){
        let photo: PFObject? = self.objects![sender.tag] as? PFObject
        
        if photo != nil{
            let photoVC: PhotoDetailVC? = PhotoDetailVC(image: photo!)
            self.navigationController!.pushViewController(photoVC!, animated: true)
        }
    }
    
    // 「コメント」ボタンをタップした時
    func didTapOnReturnBtnAction(sender: UIButton, event: UIEvent){
        let indexPath: NSIndexPath = self.indexPathForControlEvent(event)
        let cell: TalkViewCell? = self.tableView.cellForRowAtIndexPath(indexPath) as? TalkViewCell
        let tf: UITextField? = cell!.commentField?.viewWithTag(sender.tag) as? UITextField
        textFieldShouldReturn(tf!)
    }
    
    //UIEventに絹付けてindexPathを返す
    func indexPathForControlEvent(event: UIEvent) -> NSIndexPath {
        let touch = event.allTouches()!.first
        let point = touch!.locationInView(self.tableView)
        let indexPath = self.tableView.indexPathForRowAtPoint(point)
        return indexPath!
    }
    
    //PFObjectに絹付けてindexPathを返す
    func indexPathForObject(targetObject: PFObject) -> NSIndexPath? {
        for var i = 0; i < self.objects!.count; i++ {
            let object: PFObject = self.objects![i] as! PFObject
            if object.objectId == targetObject.objectId {
                return NSIndexPath(forRow: i + 1, inSection: 0)
            }
        }
        
        return nil
    }
    
    //TODO: 削除機能
    func userDidDeletePhoto(note: NSNotification) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), {
            self.loadObjects()
        })
    }
    
    // 投稿後の処理
    func userDidPublishPhoto(note: NSNotification) {
        if self.objects!.count > 0 {
            self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
        
        self.loadObjects()
    }
    
    func indexPathForObjectAtIndex(index: Int, header: Bool) -> NSIndexPath {
        return NSIndexPath(forItem: (index), inSection: 0)
    }
    
    func indexForObjectAtIndexPath(indexPath: NSIndexPath) -> Int {
        return indexPath.row
    }
    
    // MARK: imagePicker
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(false, completion: nil)
        
        var image: UIImage! = info[UIImagePickerControllerOriginalImage] as? UIImage
        var rotate: UIImageOrientation!
        
        // 画像向きを整理
        if image!.size.width < image!.size.height && image!.imageOrientation.rawValue == 3{
            rotate = UIImageOrientation.Right
        }else if image!.size.width < image!.size.height && image!.imageOrientation.rawValue == 2{
            rotate = UIImageOrientation.Left
        }else if image!.size.width < image!.size.height{
            rotate = UIImageOrientation.Up
        }else{
            rotate = UIImageOrientation.Right
        }
        
        image = UIImage(CGImage: image.CGImage!, scale: image!.scale, orientation: rotate)
        
        let postDetailView: PostDetailVC? = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("PostDetailVC") as? PostDetailVC
        postDetailView!.image = image
        
        self.navigationController?.pushViewController(postDetailView!, animated: true)
        //self.presentViewController(PostDetal!, animated: true, completion: nil)
    }
    
    // カメラが使えなければアルバムを選択する
    func shouldPresentPhotoCaptureController() -> Bool {
        var presentedPhotoCaptureController: Bool = self.shouldStartCameraController()
        
        if !presentedPhotoCaptureController {
            presentedPhotoCaptureController = self.shouldStartPhotoLibraryPickerController()
        }
        
        return presentedPhotoCaptureController
    }
    
    func shouldStartCameraController() -> Bool {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) == false {
            return false
        }
        
        let cameraUI = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
            && UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)!.contains(kUTTypeImage as String) {
                
                cameraUI.mediaTypes = [kUTTypeImage as String]
                cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
                
                if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Rear) {
                    cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Rear
                } else if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.Front) {
                    cameraUI.cameraDevice = UIImagePickerControllerCameraDevice.Front
                }
        } else {
            return false
        }
        
        cameraUI.allowsEditing = false
        cameraUI.showsCameraControls = true
        cameraUI.delegate = self
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    
    
    func shouldStartPhotoLibraryPickerController() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) == false
            && UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) == false {
                return false
        }
        
        let cameraUI = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
            && UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.PhotoLibrary)!.contains(kUTTypeImage as String) {
                
                cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                cameraUI.mediaTypes = [kUTTypeImage as String]
                
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
            && UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.SavedPhotosAlbum)!.contains(kUTTypeImage as String) {
                cameraUI.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                cameraUI.mediaTypes = [kUTTypeImage as String]
                
        } else {
            return false
        }
        
        cameraUI.allowsEditing = false
        cameraUI.delegate = self
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
        
        return true
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        pushReturnBtn(textField)
        textField.resignFirstResponder()
        
        return true
    }
    
    func pushReturnBtn(textField: UITextField){
        let trimmedComment: String = textField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let photo: PFObject? = self.objects![textField.tag] as? PFObject
        
        if trimmedComment.length != 0 {
            let comment = PFObject(className: myActivityClassKey)
            comment.setObject(trimmedComment, forKey: myActivityContentKey) // Set comment text
            comment.setObject("comment", forKey: myActivityTypeKey)
            comment.setObject(photo!, forKey: myActivityPhotoKey)
            comment.setObject(PFUser.currentUser()!, forKey: myActivityFromUserKey)
            
            let timer: NSTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("handleCommentTimeout:"), userInfo: ["comment": comment], repeats: false)
            
            //TODO: バックグラウンド時の挙動
            comment.saveEventually { (succeeded, error) in
                timer.invalidate()
                
                if error != nil && error!.code == PFErrorCode.ErrorObjectNotFound.rawValue {
                    SCLAlertView().showError("エラー", subTitle:"コメントの投稿に失敗しました。投稿先が見つかりません。", closeButtonTitle:"OK")
                }
                
                self.loadObjects()
            }
        }
        
        textField.text = nil
    }
    
    // コメント投稿に失敗した時
    func handleCommentTimeout(aTimer: NSTimer) {
        SCLAlertView().showError("エラー", subTitle:"コメントの投稿に失敗しました。ネットワーク接続を確認してください。", closeButtonTitle:"OK")
    }
    
    //TODO: キーボードが表示される時、Viewを適切な位置にスクロールさせる
    func keyboardWillShow(note: NSNotification) {
        //        let info = note.userInfo
        //        let kbSize: CGSize = (info![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue().size
        //        self.tableView.setContentOffset(CGPointMake(0.0, self.tableView.contentSize.height-kbSize.height), animated: true)
    }
    
}
