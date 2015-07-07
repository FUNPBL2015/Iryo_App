//
//  CustomNavigationController.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/07/05.
//  Copyright (c) 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    
   /** NavigationBarのサイズを設定する */
   override func sizeThatFits(size: CGSize)->CGSize{
    var navigationBarSize = super.sizeThatFits(size)

    navigationBarSize.height = 60
    return navigationBarSize
    }
    
}
