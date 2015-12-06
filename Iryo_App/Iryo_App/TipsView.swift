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
    private var data: [[String]]!
    private var count: Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initial tableView style
        myTableView = UITableView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight)))
        myTableView.separatorColor = UIColor.clearColor()
        myTableView.registerClass(TipViewCell.self, forCellReuseIdentifier: "Tip")
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
        let path = NSBundle.mainBundle().pathForResource("TipData", ofType: "csv")
        let data = try! String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        var dataArray = [[String]]()
        
        let lines = data.componentsSeparatedByString("\n")
        for line in lines{
            dataArray.append(line.componentsSeparatedByString(","))
        }
        
        // アニメーション処理
        self.data = dataArray
        
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
        return self.cellheight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30 <= 10 {
            return Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30
        }else{
            return 9 //self.data.count
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
    
    var cellheight: CGFloat = 0;
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellIdentifier = "Tip"
        
        var cell: TipViewCell? = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as? TipViewCell
        
        //self.cellheight = cell!.cellheight!
        
        if cell == nil {
            cell = TipViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellIdentifier)
        }
        
        if indexPath.row < self.data.count && (Int(NSDate().timeIntervalSinceDate(NSUserDefaults.standardUserDefaults().objectForKey("firstTime") as! NSDate)) / 30) > indexPath.row && self.count >= 0{
            
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
            let tipTextSize = NSString(string: self.data[self.data.count - self.count - indexPath.row - 1][1]).boundingRectWithSize(tipConstraintsSize, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: tipAttributeDict, context: nil)
            cell!.tipTextSize = tipTextSize
            self.cellheight = cell!.titleHeight + tipTextSize.height + cell!.margin*6
            
            cell!.titleLabel!.text = self.data[self.data.count - self.count - indexPath.row - 1][0]
            cell!.tipsLabel?.text = self.data[self.data.count - self.count - indexPath.row - 1][1]
        }else{
            cell!.titleLabel!.text = nil
            cell!.tipsLabel!.text = nil
        }
        
        return cell!
    }
}