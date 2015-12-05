//
//  Extension.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/07/07.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

extension UINavigationBar {
    /** NavigationBarのサイズを設定する */
    override public func sizeThatFits(size: CGSize)->CGSize{
        super.sizeThatFits(size)
        var navigationBarSize = super.sizeThatFits(size)
        navigationBarSize.height = 60
        return navigationBarSize
    }
}

extension UITabBar {
    // UITabbarのサイズを変更する
    override public func sizeThatFits(size: CGSize) -> CGSize {
        super.sizeThatFits(size)
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 100
        return sizeThatFits
    }
}

extension Array {
    // 配列から特定の要素を削除する
    mutating func remove<T : Equatable>(obj : T) -> Array {
        self = self.filter({$0 as? T != obj})
        return self
    }
    
    // 配列に特定の要素が含まれているかを確認する
    func contains<T : Equatable>(obj : T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
    
    // ２配列間の差集合を求める
    func except<T : Equatable>(obj: [T]) -> [T] {
        var ret = [T]()
        
        for x in self {
            if !obj.contains(x as! T) {
                ret.append(x as! T)
            }
        }
        return ret
    }
}

extension UIView {
    // UIViewをキャプチャ、UIImageとして出力する
    func screenCapture() -> UIImage{
        let rect = self.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        self.layer.renderInContext(context)
        let capturedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return capturedImage
    }
}

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