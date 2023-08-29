//
//  SignInVC.swift
//  SignInApp1.0
//
//  Created by Aliaksandr Yashchuk on 8/25/23.
//

import UIKit

class SignInVC: BaseViewController {
    
    @IBOutlet weak var emailTf1: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var errorLbl: UILabel!{
        didSet {errorLbl.isHidden = true}
    }
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
setupUI()
    }
    
    private func setupUI() {
        signInBtn.isEnabled = false
    }
}
