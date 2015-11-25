//
//  album.swift
//  Iryo_App
//
//  Created by member on 2015/10/21.
//  Copyright © 2015年 伊藤恵研究室メンバ. All rights reserved.
//

import UIKit

class album: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextMonthButton: UIButton!
    @IBOutlet weak var prevMonthButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var currentYear: Int = 0
    var currentMonth: Int = 0
    var pictureYear: Int = 0
    var pictureMonth: Int = 0
    
    var now = NSDate()
    var dateString:String = ""
    var dates:[String] = []
    var pictureDateString:String = ""
    var pictureDates:[String] = []
    let dateFormatter:NSDateFormatter = NSDateFormatter();
    
    var picture:[AnyObject] = []
    var pictureDate: [AnyObject] = []
    var pictures:[AnyObject] = []
    var mealPicture:[AnyObject] = []
    var familyPicture:[AnyObject] = []
    var hobbyPicture:[AnyObject] = []
    var otherPicture:[AnyObject] = []
    
    var numbar: Int?
    var tagNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateFormatter.locale = NSLocale(localeIdentifier: "ja")
        self.dateFormatter.dateFormat = "yyyy/MM";
        self.dateString = self.dateFormatter.stringFromDate(now);
        dates = dateString.componentsSeparatedByString("/")

        dateShow()
        loadData()
        
        var myToolbar: UIToolbar!
        myToolbar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.width, 40.0))
        myToolbar.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height-20)
        myToolbar.tintColor = UIColor.grayColor()
        
        let mealButton = UIBarButtonItem(title: "食事", style: .Plain, target: self, action: "selectTag:")
        let familyButton = UIBarButtonItem(title: "家族", style: .Plain, target: self, action: "selectTag:")
        let hobbyButton = UIBarButtonItem(title: "趣味", style: .Plain, target: self, action: "selectTag:")
        let otherButton = UIBarButtonItem(title: "その他", style: .Plain, target: self, action: "selectTag:")
        let Blank: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        mealButton.tag = 0
        familyButton.tag = 1
        hobbyButton.tag = 2
        otherButton.tag = 3
        
        myToolbar.items = [Blank, mealButton, Blank, familyButton, Blank, hobbyButton, Blank, otherButton, Blank]
        self.view.addSubview(myToolbar)
    }
    
/* cellについて　*/
    func loadData()  {
        var i: Int = 0
        let query: PFQuery = PFQuery(className: myChatsClassKey)
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if (error != nil){
                // エラー処理
                return
            }
            for row:PFObject in objects! {
                self.picture.append(row)
                self.pictureDate.append(objects![i])
                i++
            }
            self.dateSet()
        }
    }
    
    func dateSet() {
        self.pictures = []
        self.mealPicture = []
        self.familyPicture = []
        self.hobbyPicture = []
        self.otherPicture = []
        var k: [NSDate] = []
        
        for (var i = 0; i < self.pictureDate.count; i++) {
            if let string = self.pictureDate[i].createdAt as NSDate! {
                k.append(string)
                        
                self.pictureDateString = self.dateFormatter.stringFromDate(k[i]);
                self.pictureDates = self.pictureDateString.componentsSeparatedByString("/")
                self.pictureYear  = Int(self.pictureDates[0])!
                self.pictureMonth = Int(self.pictureDates[1])!
                        
                if (self.pictureMonth == self.currentMonth && self.pictureYear == self.currentYear){
                    
                    let imageTag: Int = (self.picture[i].objectForKey("tag") as? Int)!
                    print(imageTag)
                    switch imageTag {
                    case 0:
                        self.mealPicture.append(self.picture[i])
                    case 1:
                        self.familyPicture.append(self.picture[i])
                    case 2:
                        self.hobbyPicture.append(self.picture[i])
                    case 3:
                        self.otherPicture.append(self.picture[i])
                    case -1:
                        break
                    default:
                        break
                    }
                    self.pictures.append(self.picture[i])
                    tagKeep(tagNumber)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func selectTag(sender: UIButton) {
        switch(sender.tag) {
        case 0:
            self.pictures = self.mealPicture
            self.collectionView.reloadData()
            tagNumber = 1
        case 1:
            self.pictures = self.familyPicture
            self.collectionView.reloadData()
            tagNumber = 2
        case 2:
            self.pictures = self.hobbyPicture
            self.collectionView.reloadData()
            tagNumber = 3
        case 3:
            self.pictures = self.otherPicture
            self.collectionView.reloadData()
            tagNumber = 4
        default:
            break
        }
    }
    
    func tagKeep(number: Int) {
        switch(number) {
        case 0:
            break
        case 1:
            self.pictures = self.mealPicture
        case 2:
            self.pictures = self.familyPicture
        case 3:
            self.pictures = self.hobbyPicture
        case 4:
            self.pictures = self.otherPicture
        default:
            break
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell

        let imageFile: PFFile? = self.pictures[indexPath.row].objectForKey("graphicFile") as! PFFile?
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
            VC.pictures = pictures
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = view.frame.width / 5 - 3
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    
/* 日付について */
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
        dateSet()
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
        dateSet()
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
}
