//
//  Menu.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/06/18.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Menu: UITableViewController {


    @IBOutlet var mytableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //余分に表示される境界線を削除する
        tableView.tableFooterView = UIView();
        
        
        // 色を変数に用意しておく
        let background2 = UIColor(red: 0, green: 0.6, blue: 1, alpha: 0.7)
        
        // 背景の色を変えたい。
        self.navigationController?.navigationBar.barTintColor = background2
    }
    
    /** 境界線　左の余白を削除する */
    func rmLeftMargin (cell:UITableViewCell){
        if cell.respondsToSelector("preservesSuperviewLayoutMargins") {
            if #available(iOS 8.0, *) {
                cell.preservesSuperviewLayoutMargins = false
            } else {
            if #available(iOS 8.0, *) {
                cell.layoutMargins = UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            }           };
        }
        if cell.respondsToSelector("layoutMargins") {
            if #available(iOS 8.0, *) {
                cell.layoutMargins = UIEdgeInsetsZero
            } else {
                // Fallback on earlier versions
            };
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)

        rmLeftMargin(cell)
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}