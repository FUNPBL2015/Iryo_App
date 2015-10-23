//
//  Menu3.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室メンバ on 2015/06/23.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import Foundation
import UIKit


class Menu3: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
        //余分に表示される境界線を削除する
        tableView.tableFooterView = UIView();
        
        
        // 色を変数に用意しておく
        let background1 = UIColor(red: 1, green: 0.8, blue: 0, alpha: 0.7)
        
        // 背景の色を変えたい。
        self.navigationController?.navigationBar.barTintColor = background1

        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
