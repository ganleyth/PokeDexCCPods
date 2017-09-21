//
//  SignupViewController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/19/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { presentInvalidEntryAlert(); return }
        
        FirebaseController.shared.createUserWith(email: username, password: password) { (user) in
            TrainerController.currentUser = user
        }
    }
    
    func presentInvalidEntryAlert() {
        let title = "Invalid Entry"
        let message = "Please ensure you've entered a valid Email and password"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
