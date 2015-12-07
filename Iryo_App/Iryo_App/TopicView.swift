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
        myTableView.registerClass(TopicViewCell.self, forCellReuseIdentifier: "Topic")
        myTableView.showsVerticalScrollIndicator = false
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
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
    
    func update(displayLink: CADisplayLink){
        // セルが追加される時にupdateDataを呼び出す
        if (Int(NSDate().timeIntervalSinceDate(firstTime!)) % Int(topicInterval)) == 0 && Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval) <= topicDataarray.count{
            var timer = NSTimer()
            topicDisplayLink!.invalidate()
            topicDisplayLink = nil
            //updateData(timer)
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
            
        }else{ timer.invalidate() }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 2 * myScreenHeight / 3
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
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Topic"
        
        var cell: TopicViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as? TopicViewCell
        
        if cell == nil {
            cell = TopicViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        
        if indexPath.row < topicDataarray.count && (Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(topicInterval)) > indexPath.row && topicCount >= 0{
            cell!.mylabel.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row - 1][0]
            cell!.myTextView?.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row - 1][1]
            cell!.myPhoto?.text = topicDataarray[topicDataarray.count - topicCount - indexPath.row - 1][2]
        }else{
            cell!.mylabel.text = nil
            cell!.myTextView?.text = nil
            cell!.myPhoto?.text = nil
        }
        
        return cell!
    }
}
