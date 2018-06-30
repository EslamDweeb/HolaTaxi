//
//  LeftSidePanelVC.swift
//  HolaTaxi
//
//  Created by eslam dweeb on 4/17/18.
//  Copyright © 2018 eslam dweeb. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {
    
    let currentUserId = Auth.auth().currentUser?.uid
    let appDeleget = AppDelegate.getappDeleget()
    
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userAccountType: UILabel!
    @IBOutlet weak var userImageView: RoundIageView!
    @IBOutlet weak var pickupModeLbl: UILabel!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var logInOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModeLbl.isHidden = true
        
        observePassengerAndDriver()
        
        if Auth.auth().currentUser == nil{
            userEmailLbl.text = ""
            userAccountType.text = ""
            userImageView.isHidden = true
            logInOutBtn.setTitle("Sign Up / Login", for: .normal)
            
        }else{
            userEmailLbl.text = Auth.auth().currentUser?.email
            userImageView.isHidden = false
            userAccountType.text = ""
            logInOutBtn.setTitle("Logout", for: .normal)
        }
    }
    
    func observePassengerAndDriver(){
        DataService.instance.REF_USERS.observeSingleEvent(of: .value,with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.userAccountType.text = "PASSANGER"
                    }
                }
            }
        })
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value,with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid{
                        self.userAccountType.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        let switchStatus = snap.childSnapshot(forPath: "ccountPickUpModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModeLbl.isHidden = false
                    }
                }
            }
        })
    }
    
    @IBAction func switchWasToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModeLbl.text = "PICKUP MODE ENABLED"
            appDeleget.MenuContainerVC.toggleLeftPanel()
            
DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["ccountPickUpModeEnabled": true])
        }else{
            pickupModeLbl.text = "PICKUP MODE DISABLED"
            appDeleget.MenuContainerVC.toggleLeftPanel()
    DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["ccountPickUpModeEnabled": false])
        }
    }
    
    @IBAction func signupLoginBtnWasPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil{
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        }else{
            do{
                try Auth.auth().signOut()
                userEmailLbl.text = ""
                userAccountType.text = ""
                pickupModeLbl.text = ""
                userImageView.isHidden = true
                pickupModeSwitch.isHidden = true
                logInOutBtn.setTitle("Sign Up / Login", for: .normal)
            }catch (let error){
                print(error)
            }
        }
    }
}
