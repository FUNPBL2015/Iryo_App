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
    
        //TODO: Simulator時に余分なトップマージンが取られる
        //initial tableView style
        myTableView = UITableView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight)))
        myTableView.separatorColor = UIColor.clearColor()
        let texturedBackgroundView = UIView(frame: self.view.bounds)
        texturedBackgroundView.backgroundColor = UIColor.hexStr("FFEBCD", alpha: 0.5)
        myTableView.backgroundView = texturedBackgroundView
        myTableView.registerClass(IntentionViewCell.self, forCellReuseIdentifier: "Intention")
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
    
    // MARK: TalkViewに入ったときをタイマー起点にするならこれを使用する
    // FIXME: Simulatorと実機で挙動が異なる
    // simulatorでは0秒で最初のセルが挿入されてしまう
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
            talkView!.tableView.endUpdates()
           // }
            
        }else{ timer.invalidate() }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.cellheight
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
    
    var cellheight: CGFloat = 0
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Intention"
        
        var cell: IntentionViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as? IntentionViewCell
        
        if cell == nil {
            cell = IntentionViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        
        if indexPath.row < intentionDataarray.count && (Int(NSDate().timeIntervalSinceDate(firstTime!)) / Int(intentionInterval)) > indexPath.row && intentionCount >= 0{
            
            //以下はtextから高さを取得する処理
            //改行を単語区切りに
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
            //NSAttributedStringのAttributeを指定
            let tipAttributeDict = [
                NSFontAttributeName: UIFont.systemFontOfSize(20),
                NSParagraphStyleAttributeName: paragraphStyle
            ]
            let tipConstraintsSize = CGSizeMake(myScreenWidth - myScreenWidth / 5 - 60, 500)
            let tipTextSize = NSString(string: intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row - 1][1]).boundingRectWithSize(tipConstraintsSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tipAttributeDict, context: nil)
            cell!.tipTextSize = tipTextSize
            self.cellheight = cell!.titleHeight + tipTextSize.height + cell!.margin*9
            cell!.titleLabel!.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row - 1][0]
            cell!.tipsLabel?.text = intentionDataarray[intentionDataarray.count - intentionCount - indexPath.row - 1][1]
        }else{
            cell!.titleLabel!.text = nil
            cell!.tipsLabel!.text = nil
        }
        
        return cell!
    }
}