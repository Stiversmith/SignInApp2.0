//
//  SignUpVC.swift
//  SignInApp1.0
//
//  Created by Aliaksandr Yashchuk on 8/26/23.
//

import UIKit

class SignUpVC: BaseViewController {
  //1
    @IBOutlet weak var email2Tf: UITextField!
    @IBOutlet weak var error2Lbl: UILabel!{
        didSet {error2Lbl.isHidden = true}
    }
  //2
    @IBOutlet weak var name2Tf: UITextField!
  //3
    @IBOutlet weak var passw2Tf: UITextField!
    @IBOutlet weak var error3Lbl: UILabel!{
        didSet {error3Lbl.isHidden = true}
    }
  //4
    @IBOutlet var warningViews: [UIView]!
  //5
    @IBOutlet weak var confTf: UITextField!
    @IBOutlet weak var confLbl: UILabel!{
        didSet {confLbl.isHidden = true}
    }
  //6
    @IBOutlet weak var nextBtn: UIButton!
  //7
    @IBOutlet weak var scrollV: UIScrollView!
    
    //
    
    private var isValidEmail = false { didSet {updateNextBtn()}}
    private var isConfPass = false { didSet {updateNextBtn()}}
    private var passStrong: PassStrong = .veryWeak { didSet {updateNextBtn()}}
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningViews.forEach {view in view.alpha = 0.1}
        startKeybObserv()
        hideKeybWhenTappedAround()
    }
    
    // 1
    
    @IBAction func emailAct(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerifServ.isValidEmail(email: email)
        {
            isValidEmail = true
            print("isValidEmail = true")
        } else {
            isValidEmail = false
            print("isValidEmail = false")
        }
        error2Lbl.isHidden = isValidEmail
    }
    
    //2
    
    @IBAction func passwTfAct(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
            passStrong = VerifServ.isValidPass(pass: passText)
        } else {
            passStrong = .veryWeak
        }
        error3Lbl.isHidden = passStrong != .veryWeak
        
        setupStrongIndViews()
        
    }
    
    //3
    
    @IBAction func confPassTfAct(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passw2Tf = passw2Tf.text,
           !passw2Tf.isEmpty {
            isConfPass = VerifServ.isPassConf(pass1: passw2Tf, pass2: confPassText)
        } else {
            isConfPass = false
        }
        confLbl.isHidden = isConfPass
    }
    
    //4
    
    @IBAction func nextBtnAct() {
        if let email = email2Tf.text,
           let passw = passw2Tf.text {
            let userModel = UserModel(email: email, pass: passw)
            performSegue(withIdentifier: "goToVer", sender: userModel)
        }
    }
    
    @IBAction func signInAct() {
        navigationController?.popViewController(animated: true)
    }
    
    //1
    
    private func setupStrongIndViews() {
        for (index, view) in warningViews.enumerated() {
            if index <= (passStrong.rawValue - 1){
                view.alpha = 1
            } else {
                view.alpha = 0.1
            }
        }
    }
    
    //2
    
    private func updateNextBtn() {
        nextBtn.isEnabled = isValidEmail && isConfPass && passStrong != .veryWeak
    }
    
    //3
    
    private func startKeybObserv() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //1
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue
        else {
            return
        }
        let contentInsests = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollV.contentInset = contentInsests
        scrollV.scrollIndicatorInsets = contentInsests
    }
    
    //2
    
    @objc private func keyboardWillHide() {
        let contentInsests = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollV.contentInset = contentInsests
        scrollV.scrollIndicatorInsets = contentInsests
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
    
}
