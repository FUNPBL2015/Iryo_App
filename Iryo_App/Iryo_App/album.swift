//
//  album.swift
//  Iryo_App
//
//  Created by member on 2015/10/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit
//import Parse


class album: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var picture:[AnyObject] = []
    
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var prevMonthButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    var numbar: Int?
    
    var currentYear: Int = 0
    var currentMonth: Int = 0
    var currentDay: Int = 0
    
    var now = NSDate() // 現在日時の取得
    var dateString:String = ""
    var dates:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()
        
        let dateFormatter:NSDateFormatter = NSDateFormatter();
        dateFormatter.locale = NSLocale(localeIdentifier: "ja")
        dateFormatter.dateFormat = "yyyy/MM";
        self.dateString = dateFormatter.stringFromDate(now);
        dates = dateString.componentsSeparatedByString("/")

        dateShow()
    }
    
    func loadData()  {
        let query: PFQuery = PFQuery(className: myChatsClassKey)
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error != nil){
                // エラー処理
                return
            }
            for row:PFObject in objects! {
                self.picture.append(row)
            }
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picture.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
//        cell.titleSample.text = title1[indexPath.row]
//        cell.imgSample.image = UIImage(named: picture[indexPath.row])
//        cell.backgroundColor = UIColor.whiteColor()
//        return cell
        
        let imageFile: PFFile? = self.picture[indexPath.row].objectForKey("graphicFile") as! PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if(error == nil) {
                cell.imgSample.image = UIImage(data: imageData!)!
            }
        })
        return cell
        
    }
    
    // Cell が選択された場合
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        numbar = indexPath.row
        if numbar != nil {
            performSegueWithIdentifier("Segues",sender: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "Segues") {
            let VC: picture2 = (segue.destinationViewController as? picture2)!
            VC.numbars = numbar
            VC.pictures = picture
        }
    }
    
    func dateShow(){
        
        currentYear  = Int(dates[0])!
        currentMonth = Int(dates[1])!
        timeLabel.text = (String(currentYear) + "年" + String(currentMonth) + "月")
        
        //翌月
        let next = self.getNextYearAndMonth()
        let nextYear = String(next.year)
        let nextMonth = String(next.month)
        let nextDate: String = (nextYear + "年" + nextMonth + "月")
        self.nextMonthButton.setTitle(nextDate, forState: .Normal)
        
        self.nextMonthButton.addTarget(self, action: Selector("showNextView"), forControlEvents: .TouchUpInside)
        
        //前月
        let prev = self.getPrevYearAndMonth()
        let prevYear = String(prev.year)
        let prevMonth = String(prev.month)
        let prevDate: String = (prevYear + "年" + prevMonth + "月")
        self.prevMonthButton.setTitle(prevDate, forState: .Normal)
        
        self.prevMonthButton.addTarget(self, action: Selector("showPrevView"), forControlEvents: .TouchUpInside)
    }
    
    func showNextView (){
        currentMonth++;
        if( currentMonth > 12 ){
            currentMonth = 1;
            currentYear++;
        }
        dates[0] = String(currentYear)
        dates[1] = String(currentMonth)
        dateShow()
    }
    
    func showPrevView () {
        currentMonth--
        if( currentMonth == 0 ){
            currentMonth = 12
            currentYear--
        }
        dates[0] = String(currentYear)
        dates[1] = String(currentMonth)
        dateShow()
    }
    
    func getNextYearAndMonth () -> (year:Int,month:Int){
        var next_year:Int = currentYear
        var next_month:Int = currentMonth + 1
        if next_month > 12 {
            next_month=1
            next_year++
        }
        return (next_year,next_month)
    }
    func getPrevYearAndMonth () -> (year:Int,month:Int){
        var prev_year:Int = currentYear
        var prev_month:Int = currentMonth - 1
        if prev_month == 0 {
            prev_month = 12
            prev_year--
        }
        return (prev_year,prev_month)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 5 - 3
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }

}
