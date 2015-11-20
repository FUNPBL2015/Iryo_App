//
//  PaintVC.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/10/25.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import AVFoundation


protocol PaintVCDelegate{
    func paintDidFinished(paintImg: UIImage)
}

class PaintVC: UIViewController,UINavigationControllerDelegate{
    
    var delegate: PaintVCDelegate! = nil
    
    var image: UIImage?
    private var newData: PFObject?
    private let drawingView:ACEDrawingView! = ACEDrawingView(frame: CGRectMake(0, 20, myScreenWidth, myScreenHeight - 110))
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let fitframe: CGRect = AVMakeRectWithAspectRatioInsideRect(self.image!.size, self.drawingView.frame)
        
        // widthまたはheightが画面サイズより大きければ、大きい方に合わせてリサイズ・中央表示
        // どちらも画面サイズ以下であれば、オリジナルサイズを維持して中央表示
        if((image!.size.width <= myScreenWidth)&&(image!.size.height <= myScreenHeight)){
            self.drawingView.frame = CGRectMake(fitframe.origin.x,fitframe.origin.y , image!.size.width, image!.size.height)
            self.drawingView.center = CGPointMake((self.view.bounds.width) / 2 , ((self.view.bounds.height-(20 + 55)) / 2) + 20)
        }else{
            self.drawingView.frame = CGRectMake(fitframe.origin.x, fitframe.origin.y, fitframe.size.width, fitframe.size.height)
        }

        self.view.addSubview(drawingView)
        
        //Retina対応
        self.drawingView.drawMode = ACEDrawingMode.Scale
        
        self.drawingView.loadImage(self.image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func UndoBtn(sender: AnyObject) {
        self.drawingView.undoLatestStep()
    }
    
    @IBAction func Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func Clean(sender: AnyObject) {
        self.drawingView.clear()
        self.drawingView.loadImage(image)
    }
    
    @IBAction func Save(sender: AnyObject) {
        // MARK: カメラロールに保存
        //UIImageWriteToSavedPhotosAlbum(drawingVIew.image!, nil, nil, nil)
        
        self.delegate.paintDidFinished(self.drawingView.image!)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        
        /*
        self.newData = PFObject(className: myChatsClassKey)
        
        let resizedImage: UIImage = drawingView.image.resizedImageWithContentMode(UIViewContentMode.ScaleAspectFit, bounds: CGSizeMake(560.0, 560.0), interpolationQuality: CGInterpolationQuality.High)
        let thumbnailImage: UIImage = drawingView.image.thumbnailImage(256, transparentBorder: 0, cornerRadius: 10, interpolationQuality: CGInterpolationQuality.Medium)
        let imageData: NSData = UIImageJPEGRepresentation(resizedImage, 0.8)!
        let thumbnailImageData: NSData = UIImagePNGRepresentation(thumbnailImage)!
        
        let photoFile = PFFile(data: imageData)
        let thumbnailFile = PFFile(data: thumbnailImageData)
        
        // Save image
        self.newData!.setObject(photoFile!, forKey: myChatsGraphicFileKey)
        self.newData!.setObject(thumbnailFile!, forKey: myChatsThumbnailKey)
        
        let alert = SCLAlertView()
        alert.showCloseButton = false
        alert.addButton("OK", action: { () -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        do{
            try self.newData!.save()
            NSNotificationCenter.defaultCenter().postNotificationName("TalkView.didFinishEditingPhoto", object: newData)
            alert.showSuccess("Success", subTitle:"Success")
        }catch{
            alert.showError("Warning", subTitle:"Couldn't post your photo", closeButtonTitle:"OK")
        }
    */
        
    }
    
}
