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
    private var data: [[String]]!
    private var count: Int! = 0
    
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
        
        // 表示できる残りセル数をカウント
        if Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30 >= 10{
            self.count = 0
        }else{
            self.count = 10 - Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30
        }
        
        // csvファイルの読み込み
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "csv")
        let data = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        var dataarray = [[String]]()
        
        let lines = data.componentsSeparatedByString("\n")
        for line in lines{
            dataarray.append(line.componentsSeparatedByString(","))
        }
        
        // アニメーション処理
        self.data = dataarray
        
        // 10フレーム毎にupdateを呼び出す
        let displayLink = CADisplayLink(target: self, selector: Selector("update:"))
        displayLink.frameInterval = 10
        displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func update(displayLink: CADisplayLink){
        
        // 初回起動からの経過時間をカウントする
        if !(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate).isEqual(NSNull) {
            self.tabBarController?.navigationItem.title = Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)).description
        }else{
            self.tabBarController?.navigationItem.title = "Nil"
        }
        
        // セルが追加される時にupdateDataを呼び出す
        if (Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) % 30) == 0 && Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30 <= 10{
            updateData()
        }
    }
    
    func updateData(){
        if self.count >= 0{ self.count!-- }
        
        // TableViewの上からセルを追加していく
        self.myTableView.beginUpdates()
        self.myTableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
        sleep(1) // ???: numberOfRowsInSectionが間に合っていない？　要検討
        self.myTableView.endUpdates()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 2 * myScreenHeight / 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30 <= 10 {
            return Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30
        }else{
            return 10
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
        
        if indexPath.row < self.data.count && (Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30) > indexPath.row && self.count >= 0{
            cell!.mylabel.text = self.data[self.data.count - self.count - indexPath.row - 1][0]
            cell!.myTextView?.text = self.data[self.data.count - self.count - indexPath.row - 1][1]
            cell!.myPhoto?.text = self.data[self.data.count - self.count - indexPath.row - 1][2]
        }else{
            cell!.mylabel.text = nil
            cell!.myTextView?.text = nil
            cell!.myPhoto?.text = nil
        }
        
        return cell!
    }
}