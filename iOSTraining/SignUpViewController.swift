//
//  SignUpViewController.swift
//  iOSTraining
//
//  Created by Admin on 30.05.20.
//  Copyright © 2020 Fjolle. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirmation: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var signUpBtn: UIButton!
    
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let size = CGSize(width: self.view.frame.width,height:         self.view.frame.height+200)
//        scrollView.contentSize = size
//        profileImageView.image = UIImage(named: "one.png")
        
        signUpBtn.layer.cornerRadius = 20
        addGestureRecognizerToImageView()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SignUpSegue"){
            
            if let homeVC = segue.destination as? HomeViewController{
                homeVC.username = txtUsername.text
                
            }
        }
    }
    
    func setUpImagePicker(){
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profileImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func addGestureRecognizerToImageView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(showImagePicker))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true
    }
    
    @objc func showImagePicker(){
        setUpImagePicker()
    }

    @IBAction func signUpBtnTap(_ sender: Any) {
        let username = txtUsername.text
        let userPassword = password.text
        let userPasswordConfirmation = passwordConfirmation.text
        
        if((username?.isEmpty)! || (userPassword?.isEmpty)! || (userPasswordConfirmation?.isEmpty)!){
        alertMsg(userMsg: "Empty fields!")
            return;
    }
        if (userPassword != userPasswordConfirmation){
        
            alertMsg(userMsg: "Passwords don't match!")
            return;
        }
    
        let myAlert = UIAlertController(title: "Alert", message: "Succesfully registered!", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)

        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
        
    }
        func alertMsg(userMsg:String){
            let myAlert = UIAlertController(title: "Alert", message: userMsg, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }
}
