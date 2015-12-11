//
//  TopicView.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class TopicView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial tableView style
        myTableView = UITableView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight)))
        myTableView.separatorColor = UIColor.clearColor()
        let texturedBackgroundView = UIView(frame: self.view.bounds)
        texturedBackgroundView.backgroundColor = UIColor.hexStr("FFEBCD", alpha: 0.5)
        myTableView.backgroundView = texturedBackgroundView
        myTableView.separatorColor = UIColor.hexStr("FFEBCD", alpha: 0.5)
        let cell = UINib(nibName: "TipsCell", bundle: nil)
        myTableView.registerNib(cell, forCellReuseIdentifier: "Tips")
        myTableView.showsVerticalScrollIndicator = true
        myTableView.scrollIndicatorInsets = UIEdgeInsetsMake(
            0.0, 0.0, 100.0, 0.0)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        myTableView.estimatedRowHeight = 200
        myTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //initial navbar
        self.tabBarController!.navigationItem.setRightBarButtonItems([], animated: true)
        self.tabBarController!.navigationItem.title = "みんなのおきにいり"
    }
    
    func update(displayLink: CADisplayLink){
        // セルが追加される時にupdateDataを呼び出す
        if (Int(NSDate().timeIntervalSinceDate(firstTime!)) % Int(topicInterval)) == 0 && Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval) <= topicDataarray.count && Int(NSDate().timeIntervalSinceDate(firstTime!)) != 0{
            var timer = NSTimer()
            topicDisplayLink!.invalidate()
            topicDisplayLink = nil
            updateData(timer)
            timer = NSTimer.scheduledTimerWithTimeInterval(topicInterval, target: self, selector: Selector("updateData:"), userInfo: nil, repeats: true)
            // 別スレッドでタイマー動作させる（スクロール中のタイマー停止回避）
            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        }else if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval) > topicDataarray.count {
            topicDisplayLink!.invalidate()
            topicDisplayLink = nil
        }
    }
    
    func updateData(timer: NSTimer){
        if topicCount > 0{
            topicCount!--
            // TableViewの上からセルを追加していく
            if self.myTableView != nil{
                self.myTableView.beginUpdates()
                self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                self.myTableView.endUpdates()
            }
            
            // -- TalkView --
            var setnum: Int = NSUserDefaults.standardUserDefaults().integerForKey("topiccellnum")
            
            talkView!.tableView.beginUpdates()
            setnum++
            NSUserDefaults.standardUserDefaults().setInteger(setnum, forKey: "topiccellnum")
            talkView!.allObjects.insert("topic", atIndex: 0)
            NSUserDefaults.standardUserDefaults().setObject(talkView!.allObjects as NSArray, forKey: "talkViewAllObjects")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            talkView!.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            talkView!.tableView.endUpdates()
            
            // 投稿がない時の表示
            if talkView!.emptyText.isDescendantOfView(talkView!.view){
                talkView!.emptyText.hidden = true
                talkView!.emptyText.removeFromSuperview()
            }
            
        }else{ timer.invalidate() }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval) <= topicDataarray.count {
            return topicDataarray.count - topicCount
        }else{
            return topicDataarray.count
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
        let cell: TestCell? = tableView.dequeueReusableCellWithIdentifier("Tips", forIndexPath: indexPath) as? TestCell
        
        cell?.content.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row - 1][1].stringByReplacingOccurrencesOfString("br", withString: "\n")
        cell?.title.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row - 1][0]
        
        return cell!
    }
}