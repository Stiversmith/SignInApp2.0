//
//  VerVC.swift
//  SignInApp1.0
//
//  Created by Aliaksandr Yashchuk on 8/28/23.
//

import UIKit

class VerVC: BaseViewController {

    var userModel: UserModel?
    let randomInt = Int.random(in: 100000 ... 999999)
    var sleepTime = 3
    
    
    @IBOutlet weak var infLbl: UILabel!
    @IBOutlet weak var codeTf: UITextField!
    @IBOutlet weak var errLbl: UILabel!
    @IBOutlet weak var centerConstr: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setupUI()
        startKeybObserv()
        hideKeybWhenTappedAround()
    }
    
    @IBAction func codeTfAct(_ sender: UITextField) {
        errLbl.isHidden = true
        guard let text = sender.text, !text.isEmpty, text == randomInt.description
        else {
            errLbl.isHidden = false
            sender.isUserInteractionEnabled = false
            errLbl.text = "error code. Please wait \(sleepTime) seconds"
            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispatchAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errLbl.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        performSegue(withIdentifier: "goToWelcome", sender: nil)
    }
    
    
    
    private func startKeybObserv() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue
        else {return}
        centerConstr.constant -= keyboardSize.height / 2
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                                  as? NSValue)?.cgRectValue
        else {return}
        centerConstr.constant += keyboardSize.height / 2
    }
    
    
    private func setupUI() {
        infLbl.text = "Please enter your code '\(randomInt)' from \(userModel?.email ?? "")"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcVC else { return }
        destVC.userModel = userModel
    }

}
