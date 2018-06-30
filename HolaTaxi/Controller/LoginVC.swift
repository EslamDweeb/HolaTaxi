//
//  LoginVC.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 5/6/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate, Alertable {
    
    @IBOutlet weak var authBtn: RoundedShadowButton!
    @IBOutlet weak var passwordField: RoundedCornerTextField!
    @IBOutlet weak var emailField: RoundedCornerTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self
        
        view.bindtoKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handelScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    @objc func handelScreenTap(sender: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func authBtnWasPressed(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            authBtn.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                            if self.segmentedControl.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.providerID] as [String: Any]
                                DataService.instance.createDBUser(uid: user.uid, userData: userData, isDriver: false)
                            } else {
                                let userData = ["provider": user.providerID, "UserIsDriver": true, "AccountPickUpModeEnabled": false, "DriverIsOnTrip": false] as [String: Any]
                                DataService.instance.createDBUser(uid: user.uid, userData: userData, isDriver: true)
                            }
                        }
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        if let errorCode = AuthErrorCode(rawValue: error!._code) {
                            switch errorCode {
                            case .wrongPassword:
                                self.showAlert("WrongPasssword please write correct one!")
                            default:
                                self.showAlert("An Unexpected Error Please Try Again")
                            }
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errorCode {
                                    case .invalidEmail:
                                        self.showAlert("Invalid Email Try Valid one PLease!")
                                    default:
                                        self.showAlert("An Unexpected Error Please Try Again")
                                    }
                                }
                            } else {
                                if let user = user {
                                    if self.segmentedControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider": user.providerID] as [String: Any]
                                        DataService.instance.createDBUser(uid: user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider": user.providerID, "UserIsDriver": true, "ccountPickUpModeEnabled": false, "DriverIsOnTrip": false] as [String: Any]
                                        DataService.instance.createDBUser(uid: user.uid, userData: userData, isDriver: true)
                                    }
                                }
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
}
