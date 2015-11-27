//
//  IntentionView.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class IntentionView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private var myTableView: UITableView!
    private var dataarray: [[String]]!
    private var count: Int! = 0
    // セルを自動追加する間隔（秒）
    private let interval: NSTimeInterval = 30.0
    // 初回起動時間
    private let firstTime: NSDate? = NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as? NSDate
    private var displayLink: CADisplayLink? = CADisplayLink()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial tableView style
        myTableView = UITableView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight)))
        myTableView.separatorColor = UIColor.clearColor()
        myTableView.registerClass(IntentionViewCell.self, forCellReuseIdentifier: "Intention")
        myTableView.showsVerticalScrollIndicator = false
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
        
        // csvファイルの読み込み
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "csv")
        let data = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        
        let lines = data.componentsSeparatedByString("\n")
        self.dataarray = [[String]]()
        for line in lines{
            self.dataarray.append(line.componentsSeparatedByString(","))
        }
        
        // 表示できる残りセル数をカウント
        if Int(NSDate().timeIntervalSinceDate(self.firstTime!)) / Int(self.interval) >= 10{
            self.count = 0
        }else{
            self.count = 10 - Int(NSDate().timeIntervalSinceDate(self.firstTime!)) / Int(self.interval)
        }
        
        // 10フレーム毎にupdateを呼び出す
        self.displayLink = CADisplayLink(target: self, selector: Selector("update:"))
        self.displayLink!.frameInterval = 10
        self.displayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        
        // debug：titleに経過時間を表示する
        let displayLinkTest = CADisplayLink(target: self, selector: Selector("update_test:"))
        displayLinkTest.frameInterval = 10
        displayLinkTest.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func update_test(displayLink: CADisplayLink){
        // 初回起動からの経過時間をカウントする
        if !(self.firstTime)!.isEqual(NSNull) {
            self.tabBarController?.navigationItem.title = Int(NSDate().timeIntervalSinceDate(self.firstTime!)).description
        }else{
            self.tabBarController?.navigationItem.title = "Nil"
        }
    }
    
    func update(displayLink: CADisplayLink){
        // セルが追加される時にupdateDataを呼び出す
        if (Int(NSDate().timeIntervalSinceDate(self.firstTime!)) % Int(self.interval)) == 0 && Int(NSDate().timeIntervalSinceDate(self.firstTime!)) / Int(self.interval) <= self.dataarray.count{
            var timer = NSTimer()
            self.displayLink!.invalidate()
            self.displayLink = nil
            updateData(timer)
            timer = NSTimer.scheduledTimerWithTimeInterval(self.interval, target: self, selector: Selector("updateData:"), userInfo: nil, repeats: true)
            // 別スレッドでタイマー動作させる（スクロール中のタイマー停止回避）
            NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        }else if Int(NSDate().timeIntervalSinceDate(self.firstTime!)) / Int(self.interval) > self.dataarray.count {
            self.displayLink!.invalidate()
            self.displayLink = nil
        }
    }
    
    func updateData(timer: NSTimer){
        if self.count > 0{
            self.count!--
            // TableViewの上からセルを追加していく
            self.myTableView.beginUpdates()
            self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
            self.myTableView.endUpdates()
        }else{ timer.invalidate() }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 2 * myScreenHeight / 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Int(NSDate().timeIntervalSinceDate(self.firstTime!)) / Int(self.interval) <= self.dataarray.count {
            return self.dataarray.count - self.count
        }else{
            return self.dataarray.count
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tableFooter: UILabel    = UILabel(frame: CGRectMake(0.0, 0.0, self.view.frame.width, 50.0))
        tableFooter.backgroundColor = UIColor.clearColor()
        return tableFooter
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Intention"
        
        var cell: IntentionViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as? IntentionViewCell
        
        if cell == nil {
            cell = IntentionViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        
        if indexPath.row < self.dataarray.count && (Int(NSDate().timeIntervalSinceDate(self.firstTime!)) / Int(self.interval)) > indexPath.row && self.count >= 0{
            cell!.mylabel.text = self.dataarray[self.dataarray.count - self.count - indexPath.row - 1][0]
            cell!.myTextView?.text = self.dataarray[self.dataarray.count - self.count - indexPath.row - 1][1]
            cell!.myPhoto?.text = self.dataarray[self.dataarray.count - self.count - indexPath.row - 1][2]
        }else{
            cell!.mylabel.text = nil
            cell!.myTextView?.text = nil
            cell!.myPhoto?.text = nil
        }
        
        return cell!
    }
}