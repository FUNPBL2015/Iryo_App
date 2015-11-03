//
//  ViewController.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室メンバ on 2015/06/10.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class Menu2: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //余分に表示される境界線を削除する
        tableView.tableFooterView = UIView();
        
        
        // 色を変数に用意しておく
        let background1 = UIColor(red: 0, green: 0.8, blue: 0.3, alpha: 0.7)
        
        // 背景の色を変えたい。
        self.navigationController?.navigationBar.barTintColor = background1
        
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

    @IBOutlet weak var tableViewCell: UITableViewCell!
    
    @IBOutlet var mytableView: UITableView!
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

