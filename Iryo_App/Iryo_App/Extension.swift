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
            let aView = view 
            aView.exclusiveTouch = true
            self.exclusiveTouches(aView)
        }
    }
}

extension UIColor {
    // UIColorにhexColor(16進数)を対応させる
    class func hexStr (var hexStr : NSString, alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}

extension String {
    // 文字数を取得
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    func subString(startIndex: Int, length: Int) -> String {
        let start = self.startIndex.advancedBy(startIndex)
        let end = self.startIndex.advancedBy(startIndex + length)
        //        let start = advance(self.startIndex, startIndex)
        //        let end = advance(self.startIndex, startIndex + length)
        return self.substringWithRange(Range<String.Index>(start: start, end: end))
    }
}