//
//  Manual.swift
//  Iryo_App
//
//  Created by 伊藤恵研究室 on 2015/12/04.
//  Copyright © 2015年 b1013075 All rights reserved.
//

import UIKit
import WebKit
import AVFoundation

class ManualView: BaseArticleViewController, UIWebViewDelegate, WKNavigationDelegate{
    @IBOutlet weak var myWebView: UIWebView!
    
    // MARK: UIWebViewを使う場合
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        myWebView.delegate = self
//        if let targetURL = NSBundle.mainBundle().pathForResource("sample1", ofType: "html", inDirectory: "manualHTML"){
//            let data = try! String(contentsOfFile: targetURL, encoding: NSUTF8StringEncoding)
//            
//            self.speaktext = Regexp("<(\"[^\"]*\"|'[^']*'|[^'\">])*>").delMatches(data)
//            self.loadRequest(targetURL)
//        }
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func loadRequest(urlString: String) {
//        let queryUrl = NSURL(string: urlString)
//        let req = NSURLRequest(URL: queryUrl!)
//        //print(req)
//        myWebView.loadRequest(req)
//        
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//    }
//    
//    func webViewDidFinishLoad(webView: UIWebView) {
//        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//    }
    
    
    //  MARK: WKWebViewを使う場合
    var wkwv: WKWebView!
    
    deinit {
        wkwv.removeObserver(self, forKeyPath: "estimatedProgress")
        wkwv.removeObserver(self, forKeyPath: "title")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wkwv = WKWebView(frame: CGRectMake(0, navigationBarHeight(self)! + myStatusBarHeight, myScreenWidth, myScreenHeight - navigationBarHeight(self)! - myStatusBarHeight), configuration: WKWebViewConfiguration())
            
        wkwv.navigationDelegate = self
        self.view.addSubview(wkwv)
        
        // wkwebview バグ回避　~ iOS8
        let urlopt = NSBundle.mainBundle().URLForResource("sample0", withExtension: "html", subdirectory: "manualHTML")
        if let url = urlopt {
            
            let directory = url.URLByDeletingLastPathComponent!
            
            let fileManager = NSFileManager.defaultManager()
            let temporaryDirectoryPath = NSTemporaryDirectory()
            let temporaryDirectoryURL = NSURL(fileURLWithPath: temporaryDirectoryPath)
            
            do{
                try fileManager.createDirectoryAtURL(temporaryDirectoryURL,
                    withIntermediateDirectories: true,
                    attributes: nil)
                
                let targetURL = temporaryDirectoryURL.URLByAppendingPathComponent("www")
                let htmlURL = targetURL.URLByAppendingPathComponent("sample0.html")
                do{
                    let htmlopt = try NSString(contentsOfURL: htmlURL, encoding: NSUTF8StringEncoding)
                    
                    if let html: NSString = htmlopt {
                        let originalHTML = try! NSString(contentsOfURL: url, encoding: NSUTF8StringEncoding)
                        if html != originalHTML {
                            try! fileManager.removeItemAtURL(targetURL)
                            try! fileManager.copyItemAtURL(directory, toURL: targetURL)
                        }
                    }
                }catch{
                    try! fileManager.copyItemAtURL(directory, toURL: targetURL)
                }
                
                let request = NSURLRequest(URL: htmlURL)
                wkwv.loadRequest(request)
                
            }catch{
                print("error")
            }
        }
       
        wkwv.addObserver(self, forKeyPath:"estimatedProgress", options:.New, context:nil)
        wkwv.addObserver(self, forKeyPath:"title", options:.New, context:nil)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if let _k = keyPath{
            switch _k {
            case "estimatedProgress":
                if let progress = change?[NSKeyValueChangeNewKey] as? Double {
                    // MARK: ここで読込の進捗率を取得できます
                    // TODO: プログレスバーの表示
                    print(progress)
                }
            case "title":
                if let title = change?[NSKeyValueChangeNewKey] as? NSString {
                    self.navigationItem.title = title as String
                }
            default:
                break
            }
        }
    }
    
    // MARK: -WKWebViewDelegate
    
    func webView(webView: WKWebView,
        decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)){
            
            self.speakDelegate.speechSynthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
            animateActionButtonAppearance(false)
            
            decisionHandler(.Allow)
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        wkwv.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML") { (html, error) in
            if error == nil{
                // 正規表現を使ってHTMLタグと半角スペースを取り除く
                // 読み上げたくないテキストはここで制御する
                self.speaktext = Regexp("<(\"[^\"]*\"|'[^']*'|[^'\">])*>|&nbsp;").delMatches(String(html!))
            }
        }
    }
    
}
