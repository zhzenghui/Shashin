//
//  LoginViewController.swift
//  CooLaDingNOTwo
//
//  Created by bejoy on 15/6/8.
//  Copyright (c) 2015年 coolading. All rights reserved.
//

import UIKit

///登陆页面
class LoginViewController: BaseViewController,UITextFieldDelegate {
    
    var backageView:UIView?
    var backButton:UIButton?
    
    var topLogoImage:UIImageView?
    var accountView:UIView?
    var accountImageView:UIImageView?
    var accountLineView:UIView?
    var accountTextField:UITextField?
    
    var passwordView:UIView?
    var passwordImageView:UIImageView?
    var passwordLineView:UIView?
    var passwordTextField:UITextField?
    
    var currentTextFiled:UITextField?
    
    var loginButton:UIButton?
    var bottomLogoImage:UIImageView?
    var registerButton:UIButton?
    var findButton:UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden=true
        
        let KDeviceWidth = UIScreen.mainScreen().bounds.size.width
        let KDeviceHeight = UIScreen.mainScreen().bounds.size.height
        
        self.backButton = UIButton(frame: CGRectMake(10, 20, 44, 44));
        self.backButton?.setImage(UIImage(named: "返回"), forState: UIControlState.Normal)
        self.backButton?.addTarget(self, action: "goBackPage", forControlEvents: UIControlEvents.TouchUpInside)
        self.navBarView.addSubview(self.backButton!)
        
        
        self.backageView=UIView()
        self.backageView?.backgroundColor=UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        self.view.addSubview(self.backageView!)
        self.backageView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.top.equalTo()(0)
            make.left.equalTo()(0)
            make.bottom.equalTo()(0)
            make.right.equalTo()(0)
        })
        
        self.bottomLogoImage=UIImageView()
        self.bottomLogoImage!.setTranslatesAutoresizingMaskIntoConstraints(false)
        let bottomLogo=UIImage(named: "loginBottomLogo")
        self.bottomLogoImage?.image=bottomLogo
        self.bottomLogoImage?.contentMode=UIViewContentMode.ScaleAspectFit
        self.view.addSubview(self.bottomLogoImage!)
        self.bottomLogoImage!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(0)
            make.bottom.equalTo()(0)
            make.right.equalTo()(0)
            make.height.equalTo()(200)
        })
        let allMap=["bottomLogoImage":self.bottomLogoImage!]
        
        //The all area
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bottomLogoImage]-0-|",
            options: NSLayoutFormatOptions.AlignAllBaseline,
            metrics: nil,
            views: allMap))
        self.view.addConstraint(NSLayoutConstraint(item: self.bottomLogoImage!,
                                attribute: NSLayoutAttribute.Bottom,
                                relatedBy: .Equal,
                                toItem: self.view,
                                attribute: NSLayoutAttribute.Bottom,
                                multiplier: 1.0,
                                constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: self.bottomLogoImage!,
            attribute: NSLayoutAttribute.Height,
            relatedBy: .Equal,
            toItem: self.bottomLogoImage!,
            attribute: NSLayoutAttribute.Width,
            multiplier: 697/750,
            constant: 0.0))
        
        
        
        
        self.topLogoImage=UIImageView()
        let topLogo=UIImage(named: "loginTopLogo")
        self.topLogoImage?.image=topLogo
        self.topLogoImage?.contentMode=UIViewContentMode.ScaleAspectFit
        self.view.addSubview(self.topLogoImage!)
        self.topLogoImage!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(40)
            make.height.equalTo()(100)
            make.right.equalTo()(-40)
            make.top.equalTo()(KDeviceHeight*0.14)
        })
        
        self.accountView=UIView();
        //        self.accountView?.backgroundColor=UIColor.redColor()
        self.accountView?.layer.borderWidth=1
        self.accountView?.layer.borderColor=UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1).CGColor
        self.view.addSubview(self.accountView!)
        self.accountView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.top.equalTo()(KDeviceHeight*0.35)
            make.left.equalTo()(40)
            make.height.equalTo()(40)
            make.right.equalTo()(-40)
        })
        
        self.accountImageView=UIImageView()
        let loginAcountIcon=UIImage(named: "loginAcountIcon")
        self.accountImageView?.image=loginAcountIcon
        self.accountImageView?.contentMode=UIViewContentMode.ScaleAspectFit
        self.accountView?.addSubview(self.accountImageView!)
        self.accountImageView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(7)
            make.height.equalTo()(26)
            make.width.equalTo()(26)
            make.top.equalTo()(7)
        })
        
        self.accountLineView=UIView()
        self.accountLineView?.backgroundColor=UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        self.accountView?.addSubview(self.accountLineView!)
        self.accountLineView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(40)
            make.height.equalTo()(20)
            make.width.equalTo()(1)
            make.top.equalTo()(10)
        })
        
        
        self.accountTextField=UITextField()
        var placeholder = NSAttributedString(string: "请输入您的账号", attributes: [NSForegroundColorAttributeName : UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)])
        self.accountTextField?.attributedPlaceholder=placeholder
        self.accountTextField?.keyboardType=UIKeyboardType.PhonePad
        self.accountTextField?.returnKeyType=UIReturnKeyType.Next
        self.accountTextField?.delegate=self
        self.accountView?.addSubview(self.accountTextField!)
        self.accountTextField!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(50)
            make.height.equalTo()(40)
            make.right.equalTo()(0)
            make.top.equalTo()(0)
        })
        
        
        
        
        self.passwordView=UIView();
        //        self.passwordView?.backgroundColor=UIColor.redColor()
        self.passwordView?.layer.borderWidth=1
        self.passwordView?.layer.borderColor=UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1).CGColor
        self.view.addSubview(self.passwordView!)
        self.passwordView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.top.equalTo()(KDeviceHeight*0.35+60)
            make.left.equalTo()(40)
            make.height.equalTo()(40)
            make.right.equalTo()(-40)
        })
        
        
        self.passwordImageView=UIImageView()
        let loginPasswordIcon=UIImage(named: "loginPasswordIcon")
        self.passwordImageView?.image=loginPasswordIcon
        self.passwordImageView?.contentMode=UIViewContentMode.ScaleAspectFit
        self.passwordView?.addSubview(self.passwordImageView!)
        self.passwordImageView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(7)
            make.height.equalTo()(26)
            make.width.equalTo()(26)
            make.top.equalTo()(7)
        })
        
        self.passwordLineView=UIView()
        self.passwordLineView?.backgroundColor=UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)
        self.passwordView?.addSubview(self.passwordLineView!)
        self.passwordLineView!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(40)
            make.height.equalTo()(20)
            make.width.equalTo()(1)
            make.top.equalTo()(10)
        })
        
        
        self.passwordTextField=UITextField()
        var placeholder2 = NSAttributedString(string: "请输入您的密码", attributes: [NSForegroundColorAttributeName : UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1)])
        self.passwordTextField?.attributedPlaceholder=placeholder2
        self.accountTextField?.keyboardType=UIKeyboardType.ASCIICapable
        self.passwordTextField?.secureTextEntry=true
        self.passwordTextField?.returnKeyType=UIReturnKeyType.Done
        self.passwordTextField?.delegate=self
        self.passwordView?.addSubview(self.passwordTextField!)
        self.passwordTextField!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.left.equalTo()(50)
            make.height.equalTo()(40)
            make.right.equalTo()(0)
            make.top.equalTo()(0)
        })
        
        self.loginButton=UIButton()
        self.loginButton?.backgroundColor=UIColor(red: 246/255, green: 171/255, blue: 0/255, alpha: 1)
        self.loginButton?.setTitle("登录", forState: UIControlState.Normal)
        self.loginButton!.addTarget(self, action: "goUserCenter", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.loginButton!)
        self.loginButton!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.bottom.equalTo()(-120)
            make.left.equalTo()(40)
            make.height.equalTo()(50)
            make.right.equalTo()(-40)
        })
        
        
        
        self.registerButton=UIButton()
        self.registerButton?.setTitle("注册coolading账户", forState: UIControlState.Normal)
        self.registerButton?.setTitleColor(UIColor(red: 246/255, green: 171/255, blue: 0/255, alpha: 1), forState: UIControlState.Normal)
        self.registerButton?.addTarget(self, action: "registerAccount", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.registerButton!)
        self.registerButton!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.bottom.equalTo()(-60)
            make.left.equalTo()(20)
            make.height.equalTo()(40)
            make.right.equalTo()(-20)
        })
        
        
        
        
        
        self.findButton=UIButton()
        self.findButton?.setTitle("找回密码", forState: UIControlState.Normal)
        self.findButton?.titleLabel?.font=UIFont.systemFontOfSize(12)
        self.findButton?.setTitleColor(UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 1), forState: UIControlState.Normal)
        self.findButton!.addTarget(self, action: "findPassword", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.findButton!)
        self.findButton!.mas_makeConstraints({(make:MASConstraintMaker!) -> Void in
            make.top.equalTo()(KDeviceHeight*0.35+100)
            make.width.equalTo()(80)
            make.height.equalTo()(40)
            make.right.equalTo()(-20)
        })
        
        let tap = UITapGestureRecognizer(target: self, action: "closeKeyboard")
        
        self.view.addGestureRecognizer(tap)
        
        #if DEBUG
            
            self.accountTextField?.text = "13124773661"
            
        #endif
        
        
        //        13888888888
        //        1
    }
    
    func closeKeyboard() {
        currentTextFiled?.resignFirstResponder()
    }
    //go to register
    func registerAccount() {
        
        let registerViewController=RegisterFirstViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
    }
    
    //go to findPassword
    func findPassword() {
        
        let findPasswordOneViewController=FindPasswordOneViewController()
        self.navigationController?.pushViewController(findPasswordOneViewController, animated: true)
        
    }
    
    //go to back page
    func goBackPage() {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    //go to goUserCenter
    func goUserCenter() {
        
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.None)
        print("信息为：\(accountTextField?.text)和\(passwordTextField?.text)")
        
        NSLog("信息为：%@和%@", accountTextField!.text,passwordTextField!.text)
        
        
        let iBJUser=IBJUser()
        iBJUser.phoneNumber=accountTextField!.text
        iBJUser.pwd=passwordTextField!.text
        iBJUser.type="1"
        iBJUser.device="iOS"
        
        let uuid=UIDevice.currentDevice().identifierForVendor.UUIDString
        
        
        Connetion.shared().login(iBJUser, uuid: uuid) { resultData, error in
            //             SVProgressHUD.dismiss()
            if(error==nil&&(!(resultData==nil))){
            print("登陆接口返回数据为：%@",resultData)
            
            let status=resultData["status"] as! Int
            
            if  status == 1 {
                let userInfo=resultData["result"] as! NSDictionary
                Cookie.setCookie("userInfo", value: userInfo)
                Cookie.setCookie("rcToken", value: nil)

                // 保存用户数据到本地
                iBJUser.setUserDict(userInfo as [NSObject : AnyObject])
                CooladingManager .sharedCooladingManager().user = iBJUser
                
                
                NSNotificationCenter .defaultCenter().postNotificationName(KchangeCooladingManagerNotifition, object: nil)
                
                SVProgressHUD.showSuccessWithStatus("登录成功")
                let userCenterViewController=UserCenterViewController()
                self.navigationController?.popViewControllerAnimated(true)
                //                self.navigationController?.pushViewController(userCenterViewController, animated: true)
                
                
                NSNotificationCenter .defaultCenter().postNotificationName(KKloadRCIM, object: nil)
                
                
                
                
                
                
            }else{
                SVProgressHUD.showSuccessWithStatus("登录失败，请重试！")
                
            }
            }else{
                SVProgressHUD.showSuccessWithStatus("服务器异常，请重试！")
            }
            
        }
        
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        currentTextFiled = textField;
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        currentTextFiled = nil;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
