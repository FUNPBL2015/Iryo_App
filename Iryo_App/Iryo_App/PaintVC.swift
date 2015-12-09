//
//  PaintVC.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/10/25.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import AVFoundation
import ACEDrawingView
import MobileCoreServices
import Parse
import ParseUI
import Synchronized
import FormatterKit


protocol PaintVCDelegate{
    func paintDidFinish(paintImg: UIImage)
    func paintDidCancel(temp_draw: PaintVC)
}
class PaintVC: UIViewController,UINavigationControllerDelegate{
    
    var delegate: PaintVCDelegate! = nil
    
    var image: UIImage?
    private var newData: PFObject?
    private let drawingView:ACEDrawingView! = ACEDrawingView(frame: CGRectMake(0, 20, myScreenWidth, myScreenHeight - 110))
    private var first:Bool = true
    // MARK: 複製テスト
//    init(draw:ACEDrawingView){
//        self.drawingView = draw
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
        
        if first{
            self.drawingView.loadImage(self.image)
            first = false
        }
    }
    
    // MARK: 複製テスト
//    func makeClone()->PaintVC{
//        return PaintVC(draw: self.drawingView)
//    }
    
    override func viewWillAppear(animated: Bool) {
        temp_draw = paintView
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
        self.delegate.paintDidCancel(temp_draw!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func Clean(sender: AnyObject) {
        self.drawingView.clear()
        self.drawingView.loadImage(image)
    }
    
    @IBAction func Save(sender: AnyObject) {
        // MARK: カメラロールに保存
        //UIImageWriteToSavedPhotosAlbum(drawingVIew.image!, nil, nil, nil)
        
        self.delegate.paintDidFinish(self.drawingView.image!)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
