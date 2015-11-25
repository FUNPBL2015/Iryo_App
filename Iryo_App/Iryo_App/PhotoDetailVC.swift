//
//  PhotoView.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/11/13.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class PhotoDetailVC: UIViewController{
    private var photoView: PFImageView?
    private var image: PFObject?
    
    init(image anImage: PFObject ){
        super.init(nibName: nil, bundle: nil)
        
        self.image = anImage
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoView = PFImageView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight)))
        self.photoView!.image = UIImage(named: "PlaceholderPhoto.png")
        self.photoView!.backgroundColor = UIColor.blackColor()
        self.photoView!.contentMode = UIViewContentMode.ScaleAspectFit
        
        let imageFile: PFFile? = self.image!.objectForKey(myChatsGraphicFileKey) as? PFFile
    
        if imageFile != nil{
            self.photoView!.file = imageFile
            self.photoView!.loadInBackground()
        }
        
        self.view.addSubview(self.photoView!)
    }
    
}
