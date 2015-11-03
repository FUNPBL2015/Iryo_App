//
//  paint.swift
//  Iryo_App
//
//  Created by member on 2015/10/23.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class paint:  UIViewController {
    


    @IBOutlet weak var pictureView: UIImageView!

    @IBOutlet var drawingView: ACEDrawingView!
    var pictureImage = NSData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.drawingView.loadImageData(pictureImage);
 
//        self.drawingView.backgroundColor = UIColor.blueColor()
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}

