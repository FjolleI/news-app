//
//  LoginViewController.swift
//  iOSTraining
//
//  Created by Admin on 29.05.20.
//  Copyright © 2020 Fjolle. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 20
        signUpBtn.layer.cornerRadius = 20
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "LoginSegue"){
            
            if let homeVC = segue.destination as? HomeViewController{
            homeVC.username = txtUsername.text
            }
        }
    }
}
