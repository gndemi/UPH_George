//
//  LoginViewController.swift
//  UPH-MyUnityPoint
//
//  Created by Aakash Sheth on 3/20/16.
//  Copyright © 2016 Aakash Sheth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate{
   
    var btnSignIn : GIDSignInButton!
    var btnSignOut : UIButton!
    var btnDisconnect : UIButton!
    var label : UILabel!

    // MARK: Properties
    //Facebook setting up the log in button
   let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
   
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override
    func viewDidLoad() {
            super.viewDidLoad()
    
         view.addSubview(loginButton)

        loginButton.center = CGPointMake(view.center.x, 500)
        
        view.addSubview(loginButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    
        btnSignIn = GIDSignInButton(frame: CGRectMake(0,10,200,30))
        btnSignIn.center = view.center

        btnSignIn.style = GIDSignInButtonStyle.Standard
        btnSignIn.addTarget(self, action: Selector("btnSignInPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSignIn)
        
        btnSignOut = UIButton(frame: CGRectMake(0,0,100,30))
        btnSignOut.center = CGPointMake(view.center.x, 100)
        btnSignOut.setTitle("Sign Out", forState: UIControlState.Normal)
        btnSignOut.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnSignOut.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
        btnSignOut.addTarget(self, action: Selector("btnSignOutPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSignOut)
        
        btnDisconnect = UIButton(frame: CGRectMake(0,0,100,30))
        btnDisconnect.center = CGPointMake(view.center.x, 200)
        btnDisconnect.setTitle("Disconnect", forState: UIControlState.Normal)
        btnDisconnect.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnDisconnect.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
        btnDisconnect.addTarget(self, action: Selector("btnDisconnectPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnDisconnect)
        
        label = UILabel(frame: CGRectMake(0,0,200,100))
        label.center = CGPointMake(view.center.x, 400)
        label.numberOfLines = 0 //multi-lines
        label.text = "Please sign in. "
        label.textAlignment = NSTextAlignment.Center
        view.addSubview(label)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveToggleAuthUINotification:",
            name: "ToggleAuthUNotification", object: nil)
        toggleAuthUI()
     
    }
    func toggleAuthUI(){
        if(GIDSignIn.sharedInstance().hasAuthInKeychain()){
            //signed in
            btnSignIn.hidden = true
            btnSignOut.hidden = false
            btnDisconnect.hidden = false
            print("Signed auth")
        } else{
            btnSignIn.hidden = false
            btnSignOut.hidden = true
            btnDisconnect.hidden = true
            print("Signed out auth")
        }
    }
    
    func btnSignOutPressed(sender: UIButton){
        GIDSignIn.sharedInstance().disconnect()
        label.text = "Disconnecting"
     
        
    }
    func btnSignInPressed(sender: UIButton){
        view.addSubview(btnSignIn)
    }
    
    
    
    func btnDisconnectPressed(sender: UIButton){
        
        label.text = "Signed Out"
        toggleAuthUI()
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: "ToggleAuthUINotification", object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(notification: NSNotification){
        if(notification.name == "ToggleAuthUINotification"){
            self.toggleAuthUI()
            if(notification.userInfo != nil){
                let userInfo: Dictionary<String, String!> =
                notification.userInfo as! Dictionary<String, String!>
                self.label.text = userInfo["statusText"]
            }
        }
    }
    
    
//    @IBAction func didTapSignOut(sender: AnyObject) {
//        GIDSignIn.sharedInstance().signOut()
//    }
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        if(error == nil){
        print("completed log in")
        self.performSegueWithIdentifier("UITabBarController", sender: nil)
        }
        else
        {
            print(error.localizedDescription)
        }
        
    }
    
    /*!
    @abstract Sent to the delegate when the button was used to logout.
    @param loginButton The button that was clicked.
    */
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        //let loginManager = FBSDKLoginManager()
        //loginManager.logOut()
    //FBSession.activeSession().closeAndClearTokenInformation()  
    print("user logged out!")}
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
        
   // func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
     //   print("Google Signed in ")
   // }
    //func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
    //    print("Google sign out")
   // }
    
    }
