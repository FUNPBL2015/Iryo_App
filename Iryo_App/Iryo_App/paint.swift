//
//  paint.swift
//  Iryo_App
//
//  Created by member on 2015/10/23.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class paint:  UIViewController {
    
    @IBOutlet var drawingView: ACEDrawingView!
    
    var pictureData: NSData!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // String to NSData
//        let data = pictureData.dataUsingEncoding(NSUTF8StringEncoding)
        
        self.drawingView.loadImageData(pictureData);
 
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

