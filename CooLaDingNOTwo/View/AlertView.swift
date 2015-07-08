//
//  AlertView.swift
//  CooLaDingNOTwo
//
//  Created by savvy on 15/6/16.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

import UIKit

//protocol AlertViewDelegate:NSObjectProtocol
//{
//func cancelAlert()//close alert
//}


///弹出警告框（coolading通用）
class AlertView: UIView {
    
    
//    var delegate:AlertViewDelegate?
    
    var alertTitleView:UIView?
    var alertContentView:UIView?
    var alertTitle:UILabel?
    var alertContent:UILabel?
    var alertCancel:UIButton?
    var alertSubmit:UIButton?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myCustomSetup()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
//        super.init(coder: aDecoder)
//        self.myCustomSetup()
    }
    

    func myCustomSetup(){
        //backageView
//        self.alertBackage=UIView()
//        self.alertBackage?.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.alertBackage?.backgroundColor=UIColor.blackColor()
//        self.alertBackage?.alpha=0.8
//        self.addSubview(self.alertBackage!)
//        //alertView
//        self.alertView=UIView()
//        self.alertView!.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.alertBackage!.addSubview(self.alertView!)
        
//         self.clipsToBounds = true;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = true;
        //alertTitleView
        self.backgroundColor=UIColor.greenColor()
        self.alertTitleView=UIView()
        self.alertTitleView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertTitleView!.backgroundColor=UIColor(red: 246/255, green: 171/255, blue: 0/255, alpha: 1)
        self.addSubview(self.alertTitleView!)
        //alertContentView
        self.alertContentView=UIView()
        self.alertContentView!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertContentView!.backgroundColor=UIColor.whiteColor()
        self.addSubview(self.alertContentView!)
        //alertTitle
        self.alertTitle=UILabel()
        self.alertTitle!.setTranslatesAutoresizingMaskIntoConstraints(false)
//        self.alertTitle?.text=self.title
        self.alertTitle!.textColor=UIColor.whiteColor()
        self.alertTitle!.textAlignment=NSTextAlignment.Center
        self.alertTitle!.font=UIFont.systemFontOfSize(22)
        self.alertTitleView!.addSubview(self.alertTitle!)
        //alertTitle
        self.alertContent=UILabel()
        self.alertContent!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertContent?.lineBreakMode=NSLineBreakMode.ByWordWrapping
        self.alertContent?.numberOfLines=0
//        self.alertContent!.text=self.content
        self.alertContent!.textColor=UIColor.blackColor()
        self.alertContent!.textAlignment=NSTextAlignment.Left
        self.alertContent!.font=UIFont.systemFontOfSize(14)
        self.alertContentView!.addSubview(self.alertContent!)
        
        //alertCancel
        self.alertCancel=UIButton()
        self.alertCancel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertCancel!.addTarget(self, action: "closeAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.alertCancel?.setImage(UIImage(named: "alert_cancel"), forState: UIControlState.Normal)
        self.addSubview(self.alertCancel!)
        //alertCancel
        self.alertSubmit=UIButton()
        self.alertSubmit!.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.alertSubmit!.addTarget(self, action: "closeAlert", forControlEvents: UIControlEvents.TouchUpInside)
        self.alertSubmit?.titleLabel?.font=UIFont.systemFontOfSize(14)
         self.alertSubmit?.setTitleColor(UIColor(red: 246/255, green: 171/255, blue: 0/255, alpha: 1), forState: UIControlState.Normal)
        self.alertSubmit?.clipsToBounds = true;
        self.alertSubmit?.layer.cornerRadius = 10;//half of the width
        self.alertSubmit?.layer.borderColor=UIColor(red: 246/255, green: 171/255, blue: 0/255, alpha: 1).CGColor
        self.alertSubmit?.layer.borderWidth=1.0
        self.alertSubmit?.setTitle("知道啦", forState: UIControlState.Normal)
        self.alertContentView!.addSubview(self.alertSubmit!)
        
        
        
        let allMap=["alertTitleView":self.alertTitleView!,"alertContentView":self.alertContentView!,"alertTitle":self.alertTitle!,
            "alertContent":self.alertContent!,"alertCancel":self.alertCancel!,"alertSubmit":self.alertSubmit!]
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[alertTitleView]-0-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[alertTitleView]",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.addConstraint(NSLayoutConstraint(item: self.alertTitleView!,
                                attribute: NSLayoutAttribute.Height,
                                relatedBy: .Equal,
                                toItem: self,
                                attribute: NSLayoutAttribute.Height,
                                multiplier: 0.3,
                                constant: 0.0))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[alertContentView]-0-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[alertContentView]-0-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        
        self.addConstraint(NSLayoutConstraint(item: self.alertContentView!,
            attribute: NSLayoutAttribute.Height,
            relatedBy: .Equal,
            toItem: self,
            attribute: NSLayoutAttribute.Height,
            multiplier: 0.7,
            constant: 0.0))
        
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-5-[alertCancel(==30)]",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-5-[alertCancel(==30)]",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        
        
        
//        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[alertSubmit(==40)]-10-|",
//            options: NSLayoutFormatOptions.AlignAllLeft,
//            metrics: nil,
//            views: allMap))
        
        
        self.alertTitleView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[alertTitle]-40-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.alertTitleView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[alertTitle]-10-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        
        self.alertContentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[alertContent]-40-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.alertContentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[alertContent]-5-[alertSubmit(==40)]-10-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))
        self.alertContentView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-40-[alertSubmit]-40-|",
            options: NSLayoutFormatOptions.AlignAllLeft,
            metrics: nil,
            views: allMap))

    }
    
    
    func setTitle(myTitle:String){
self.alertTitle!.text=myTitle
    }
    func setContent(myContent:String){
        self.alertContent!.text=myContent
    }
   
    func closeAlert(){
//    delegate?.cancelAlert()
        self.hidden=true;
    }
}
