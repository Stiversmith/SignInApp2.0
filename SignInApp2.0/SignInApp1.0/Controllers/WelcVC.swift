//
//  WelcVC.swift
//  SignInApp1.0
//
//  Created by Aliaksandr Yashchuk on 8/28/23.
//

import UIKit

class WelcVC: BaseViewController {

    @IBOutlet weak var contBtn: UIButton!
    @IBOutlet weak var welcLbl: UILabel!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func contBtnAct(_ sender: UIButton) {
      
    }
    private func setupUI() {
        welcLbl.text = "back"
    }
}
