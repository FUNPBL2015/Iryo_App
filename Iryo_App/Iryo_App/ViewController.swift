//
//  ViewController.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室メンバ on 2015/06/10.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        //画面が表示される直前
        
        // NavigationBarを非表示にする
            self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(animated: Bool) {
        //別の画面に遷移する直前

        // NavigationBarを表示する
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        // NavigationBarの高さを設定する
            self.navigationController?.navigationBar.frame.size.height = 60

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

