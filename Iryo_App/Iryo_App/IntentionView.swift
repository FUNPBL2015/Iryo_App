//
//  IntentionView.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
import Synchronized

class IntentionView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
    
        //TODO: Simulator時に余分なトップマージンが取られる
        //initial tableView style
        myTableView = UITableView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight)))
        myTableView.separatorColor = UIColor.clearColor()
        let texturedBackgroundView = UIView(frame: self.view.bounds)
        texturedBackgroundView.backgroundColor = UIColor.hexStr("FFEBCD", alpha: 0.5)
        myTableView.backgroundView = texturedBackgroundView
        myTableView.separatorColor = UIColor.hexStr("FFEBCD", alpha: 0.5)
        let cell = UINib(nibName: "IntentionCell", bundle: nil)
        myTableView.registerNib(cell, forCellReuseIdentifier: "Intention")
        myTableView.showsVerticalScrollIndicator = true
        myTableView.scrollIndicatorInsets = UIEdgeInsetsMake(
            0.0, 0.0, 100.0, 0.0)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        myTableView.estimatedRowHeight = 300
        myTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // セルがない時の表示
        if intentionCount == intentionDataarray.count{
            
        }
        
        //initial navbar
        self.tabBarController!.navigationItem.setRightBarButtonItems([], animated: true)
        self.tabBarController!.navigationItem.title = "みんなのにっき"
    }
    
    // debug
    func update_test(displayLink: CADisplayLink){
        
        // 初回起動からの経過時間をカウントする
        if !(firstTime)!.isEqual(NSNull) {
            self.tabBarController?.navigationItem.title = Int(NSDate().timeIntervalSinceDate(firstTime!)).description
        }else{
            self.tabBarController?.navigationItem.title = "Nil"
        }
    }
    
    // MARK: TalkViewに入ったときをタイマー起点にするならこれを使用する
    func update(displayLink: CADisplayLink){
        // セルが追加される時にupdateDataを呼び出す
        
        //FIXME: 一度も投稿されない時に無駄な処理が加わる
        if talkView!.objects!.count == 0{
            synchronized(self){
                talkView?.loadObjects()
            }
        }
        
        if (Int(NSDate().timeIntervalSinceDate(firstTime!)) % Int(intentionInterval)) == 0 && Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(intentionInterval) <= intentionDataarray.count && Int(NSDate().timeIntervalSinceDate(firstTime!)) != 0{
            var timer = NSTimer()
            intentionDisplayLink!.invalidate()
            intentionDisplayLink = nil
            updateData(timer)
            timer = NSTimer.scheduledTimerWithTimeInterval(intentionInterval, target: self, selector: Selector("updateData:"), userInfo: nil, repeats: true)
            // 別スレッドでタイマー動作させる（スクロール中のタイマー停止回避）
            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        }else if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(intentionInterval) > intentionDataarray.count {
            intentionDisplayLink!.invalidate()
            intentionDisplayLink = nil
        }
    }
    
    func updateData(timer: NSTimer){        
        if intentionCount > 0{
            intentionCount!--
            // TableViewの上からセルを追加していく
            if self.myTableView != nil{
            self.myTableView.beginUpdates()
            self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            self.myTableView.endUpdates()
            }
            
            // -- TalkView --
            //if self.navigationController != nil && self.navigationController!.viewControllers.last == delegate!.myTabBarController{
            var setnum: Int = NSUserDefaults.standardUserDefaults().integerForKey("intentioncellnum")
            
            talkView!.tableView.beginUpdates()
            setnum++
            NSUserDefaults.standardUserDefaults().setInteger(setnum, forKey: "intentioncellnum")
            talkView!.allObjects.insert("intention", atIndex: 0)
            NSUserDefaults.standardUserDefaults().setObject(talkView!.allObjects as NSArray, forKey: "talkViewAllObjects")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            talkView!.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
           // }
            talkView!.tableView.endUpdates()
            
            
            // 投稿がない時の表示
            if talkView!.emptyText.isDescendantOfView(talkView!.view){
                talkView!.emptyText.hidden = true
                talkView!.emptyText.removeFromSuperview()
            }
            
        }else{ timer.invalidate() }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(intentionInterval) <= intentionDataarray.count {
            return intentionDataarray.count - intentionCount
        }else{
            return intentionDataarray.count
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 120.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tableFooter: UILabel    = UILabel(frame: CGRectMake(0.0, 0.0, self.view.frame.width, 120.0))
        tableFooter.backgroundColor = UIColor.clearColor()
        return tableFooter
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let key: String = String(indexPath.row)
        
        if let height = self.cellheight[key]{
            return height!
        }
        
        return self.myTableView.estimatedRowHeight
    }
    
    // estimated height スクロール対策
    // 一度表示したセルの高さを保持する
    var cellheight: Dictionary<String, CGFloat?> = [String: CGFloat]()
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.updateConstraints()
        
        let key: String = String(indexPath.row)
        
        self.cellheight[key] = cell.frame.height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: TestCell? = tableView.dequeueReusableCellWithIdentifier("Intention", forIndexPath: indexPath) as? TestCell
        
        cell?.content.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row - 1][1]
        cell?.title.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row - 1][0]
        
        return cell!
    }
}