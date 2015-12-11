//
//  TipsView.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class TipsView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var myTableView: UITableView!
    var data: [String]? = []
    
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
        
        myTableView.estimatedRowHeight = 200
        myTableView.rowHeight = UITableViewAutomaticDimension
        
        self.view.addSubview(myTableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //initial navbar
        self.tabBarController!.navigationItem.setRightBarButtonItems([], animated: true)
        self.tabBarController!.navigationItem.title = "みんなのかわら版"
    }
    
    func update(displayLink: CADisplayLink){
        // セルが追加される時にupdateDataを呼び出す
        if (Int(NSDate().timeIntervalSinceDate(firstTime!)) % Int(tipsInterval)) == 0 && Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval) <= tipsDataarray.count && Int(NSDate().timeIntervalSinceDate(firstTime!)) != 0{
            var timer = NSTimer()
            tipsDisplayLink!.invalidate()
            tipsDisplayLink = nil
            updateData(timer)
            timer = NSTimer.scheduledTimerWithTimeInterval(tipsInterval, target: self, selector: Selector("updateData:"), userInfo: nil, repeats: true)
            // 別スレッドでタイマー動作させる（スクロール中のタイマー停止回避）
            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        }else if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval) > tipsDataarray.count {
            tipsDisplayLink!.invalidate()
            tipsDisplayLink = nil
        }
    }
    
    func updateData(timer: NSTimer){
        if tipsCount > 0{
            tipsCount!--
            // TableViewの上からセルを追加していく
            if self.myTableView != nil{
                self.myTableView.beginUpdates()
                self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
                self.myTableView.endUpdates()
            }
            
            // -- TalkView --
            var setnum: Int = NSUserDefaults.standardUserDefaults().integerForKey("tipscellnum")
            
            talkView!.tableView.beginUpdates()
            setnum++
            NSUserDefaults.standardUserDefaults().setInteger(setnum, forKey: "tipscellnum")
            talkView!.allObjects.insert("tips", atIndex: 0)
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
        if Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(tipsInterval) <= tipsDataarray.count {
            return tipsDataarray.count - tipsCount
        }else{
            return tipsDataarray.count
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
        
        cell?.content.text = tipsDataarray[tipsDataarray.count - tipsCount - indexPath.row - 1][1]
        cell?.title.text = tipsDataarray[tipsDataarray.count - tipsCount - indexPath.row - 1][0]

        return cell!
    }
}