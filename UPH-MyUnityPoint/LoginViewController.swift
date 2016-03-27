//
//  LoginViewController.swift
//  UPH-MyUnityPoint
//
//  Created by Aakash Sheth on 3/20/16.
//edited by George N 3/26/16
//  Copyright © 2016 Aakash Sheth. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate, GIDSignInDelegate{
   
    var btnSignIn : GIDSignInButton!
    var btnSignOut : UIButton!
    var btnDisconnect : UIButton!
    var label : UILabel!

    
   
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override
    func viewDidLoad() {
            super.viewDidLoad()
    
        //Facebook sign in
        
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("FB Not logged in..")
        }
        else
        {
            print("FB Logged in..")
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = CGPointMake(view.center.x,500)
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
        //Google sign in
        
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        btnSignIn = GIDSignInButton(frame: CGRectMake(0,10,200,30))
        
        btnSignIn.center = view.center
      
        btnSignIn.style = GIDSignInButtonStyle.Standard
        view.addSubview(btnSignIn)
        
        btnSignOut = UIButton(frame: CGRectMake(0,0,100,30))
        btnSignOut.center = CGPointMake(view.center.x, 100)
        btnSignOut.setTitle("Sign Out", forState: UIControlState.Normal)
        btnSignOut.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnSignOut.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
        btnSignOut.addTarget(self, action: Selector("btnSignOutPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnSignOut)
        
        btnDisconnect = UIButton(frame: CGRectMake(0,0,200,100))
        btnDisconnect.center = CGPointMake(view.center.x, 200)
        btnDisconnect.setTitle("Google Signed in!", forState: UIControlState.Normal)
        btnDisconnect.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        btnDisconnect.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Highlighted)
        btnDisconnect.addTarget(self, action: Selector("btnDisconnectPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnDisconnect)
        
        label = UILabel(frame: CGRectMake(0,0,200,100))
        label.center = CGPointMake(view.center.x, 400)
        label.numberOfLines = 1 //multi-lines
        label.text = "Please sign in. "
        label.textAlignment = NSTextAlignment.Center
        view.addSubview(label)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveToggleAuthUINotification:",
            name: "ToggleAuthUNotification", object: nil)
        toggleAuthUI()
     
    }
    
    func toggleAuthUI(){
        print("toggle")
         //performSegueWithIdentifier("showNewTab", sender: self)
        if(GIDSignIn.sharedInstance().hasAuthInKeychain()){
            //signed in
            dispatch_async(dispatch_get_main_queue(), {
               self.performSegueWithIdentifier("showNewTab", sender: self)
            })
            //performSegueWithIdentifier("showNewTab", sender: self)
            print("signed in inseide toggle")
            btnSignIn.hidden = true
            btnSignOut.hidden = false
            btnDisconnect.hidden = false
            
        } else{
            btnSignIn.hidden = false
            btnSignOut.hidden = true
            btnDisconnect.hidden = true
            
        }
    }
    
 
    
    
    func btnSignOutPressed(sender: UIButton){
        GIDSignIn.sharedInstance().disconnect()
        label.text = "Disconnecting"
        print("signout")
     
        
    }
    
    
    func btnDisconnectPressed(sender: UIButton){
          self.performSegueWithIdentifier("showNewTab", sender: self)
        
        label.text = "Signed Out"
        toggleAuthUI()
        print("disco")
        
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
    
    

    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        if(error == nil){
        print("completed log in")
       
        self.performSegueWithIdentifier("showNewTab", sender: self)
        }
        else
        {
            print("Error " ,error.localizedDescription)
        }
        
    }
    
    /*!
    @abstract Sent to the delegate when the button was used to logout.
    @param loginButton The button that was clicked.
    */
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("User logged out......")
        
}
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        print("Log in hshsh ")
        return true
        
    }
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
        withError error: NSError!) {
            // Perform any operations when the user disconnects from app here.
            // ...
           // NSNotificationCenter.defaultCenter().postNotificationName("ToggleAuthUINotification",
              //  object: nil, userInfo: ["statusText": "User disconnected"])
       
        
    }
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
        withError error: NSError!) {
            
            if (error == nil) {
                
                print("Google log in presented")
        
                performSegueWithIdentifier("showNewTab", sender: self)
                
                
            }
            else {
                print("\(error.localizedDescription)")
            }
    }
    
    
    }
