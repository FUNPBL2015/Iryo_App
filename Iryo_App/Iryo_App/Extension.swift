//
//  Extension.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/07/07.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /** UIButtonの同時押しを禁止する */
    func exclusiveAllTouches() {
        self.exclusiveTouches(self.view)
    }
    
    private func exclusiveTouches(view: UIView) { // 再帰関数
        for view in view.subviews {
            let aView = view as! UIView
            aView.exclusiveTouch = true
            self.exclusiveTouches(aView)
        }
    }
}
