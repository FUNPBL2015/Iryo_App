//
//  PaintVC.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/10/25.
//  Copyright © 2015年 b1013075. All rights reserved.
//

import UIKit
import AVFoundation
import Parse
import ACEDrawingView

@IBDesignable
class PotBtn: UIButton{
    @IBInspectable var cornerRadius: CGFloat = 0.0{
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor = UIColor.clearColor(){
        didSet {
            self.layer.borderColor = borderColor.CGColor
        }
    }
}

protocol PaintVCDelegate{
    func paintDidFinish(paintImg: UIImage)
}
class PaintVC: UIViewController,UINavigationControllerDelegate{
    
    var delegate: PaintVCDelegate! = nil

    var image: UIImage?
    // 画像と描画を内包したview. 画像の合成処理は重いため、これのキャプチャを使用する
    private let paintView: UIView! = UIView()
    // Eraser対策 背面に画像を置くことで画像ごと消されるのを避ける
    private let backgroundView: UIImageView! = UIImageView()
    let drawingView:ACEDrawingView! = ACEDrawingView()
    // 「戻る」を押した時と「保存」を押した時のpopを識別する
    var isBack: Bool?
    private var first:Bool = true
    
    @IBOutlet weak var paintToolbar: UIToolbar!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.paintView.frame = CGRectMake(0,navigationBarHeight(self)! + myStatusBarHeight + 10, myScreenWidth, myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight) - (self.paintToolbar.frame.height + 20))
        
        let fitframe: CGRect = AVMakeRectWithAspectRatioInsideRect(self.image!.size, self.paintView.frame)
        
        // widthまたはheightが画面サイズより大きければ、大きい方に合わせてリサイズ・中央表示
        // どちらも画面サイズ以下であれば、オリジナルサイズを維持して中央表示
        if((image!.size.width <= myScreenWidth)&&(image!.size.height <= myScreenHeight)){
            self.paintView.frame = CGRectMake(fitframe.origin.x,fitframe.origin.y , image!.size.width, image!.size.height)
            self.paintView.center = CGPointMake(myScreenWidth / 2 , ((myScreenHeight - (navigationBarHeight(self)! + myStatusBarHeight) - self.paintToolbar.frame.height + 20) / 2) + (navigationBarHeight(self)! + myStatusBarHeight))
        }else{
            self.paintView.frame = CGRectMake(fitframe.origin.x, fitframe.origin.y, fitframe.size.width, fitframe.size.height)
        }
        
        self.drawingView.frame = CGRectMake(0, 0, self.paintView.frame.width, self.paintView.frame.height)
        self.backgroundView.frame = self.drawingView.frame
        self.drawingView.backgroundColor = UIColor.clearColor()
        
        self.backgroundView.backgroundColor = UIColor.clearColor()
        self.paintView.addSubview(backgroundView)
        self.paintView.addSubview(drawingView)
        self.paintView.bringSubviewToFront(drawingView)
        self.view.addSubview(self.paintView)
        
        //Retina対応
        self.drawingView.drawMode = ACEDrawingMode.Scale
        
        if first{
            self.backgroundView.image = self.image
            //self.drawingView.loadImage(self.image)
            first = false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.isBack = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveBtn: UIButton = UIButton(type: .System)
        saveBtn.addTarget(self, action: "didTapSaveBtn", forControlEvents: UIControlEvents.TouchUpInside)
        saveBtn.frame = CGRectMake(0, 0, 100, 30)
        saveBtn.layer.cornerRadius = 8
        saveBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        saveBtn.setTitle("保存する", forState: UIControlState.Normal)
        saveBtn.layer.backgroundColor = UIColor.hexStr("ff9933", alpha: 1.0).CGColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        // 「戻る」を押した時の挙動
        if self.isMovingFromParentViewController() && self.isBack == true{
            // MARK: ACEDrawingView.m に以下を追加
            // - (NSUInteger)undoSteps{ return self.pathArray.count; }
            // - (NSUInteger)redoSteps{ return self.bufferArray.count; }
            // Undo, Redo可能ステップ数を取得
            // ステップ数の差分を取ることで見かけ上キャンセルを再現する
            if self.drawingView.undoSteps > temp_undo{
                for _ in 1...self.drawingView.undoSteps - temp_undo!{
                    self.drawingView.undoLatestStep()
                }
            }else if self.drawingView.redoSteps > temp_redo{
                for _ in 1...self.drawingView.redoSteps - temp_redo!{
                    self.drawingView.redoLatestStep()
                }
            }
        }
    }
    
    // MARK: enumとswitch
    
    @IBAction func didTapWhite(sender: AnyObject) {
        self.drawingView.lineColor = UIColor.whiteColor()
    }
    
    @IBAction func didTapBlack(sender: AnyObject) {
        self.drawingView.lineColor = UIColor.blackColor()
    }
    
    @IBAction func didTapRed(sender: AnyObject) {
        self.drawingView.lineColor = UIColor.redColor()
    }
    
    @IBAction func didTapGreen(sender: AnyObject) {
        self.drawingView.lineColor = UIColor.greenColor()
    }
    
    @IBAction func didTapBlue(sender: AnyObject) {
        self.drawingView.lineColor = UIColor.blueColor()
    }
    
    @IBAction func didTapPen(sender: AnyObject) {
        self.drawingView.drawTool = ACEDrawingToolTypePen
    }
    
    @IBAction func didTapEraser(sender: AnyObject) {
        self.drawingView.drawTool = ACEDrawingToolTypeEraser
    }
    
    @IBAction func didTapClear(sender: AnyObject) {
        for _ in 1 ... self.drawingView.undoSteps {
            self.drawingView.undoLatestStep()
        }
        // redo, undo stepsもリセットされるため、clearは使用しない
        //self.drawingView.clear()
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
    
    func didTapSaveBtn(){
        // MARK: カメラロールに保存
        //UIImageWriteToSavedPhotosAlbum(self.paintView.screenCapture(), nil, nil, nil)
        self.isBack = false
        self.delegate.paintDidFinish(self.paintView.screenCapture())
    }
    
    @IBAction func Save(sender: AnyObject) {
        
        self.delegate.paintDidFinish(self.drawingView.image!)
        //self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
