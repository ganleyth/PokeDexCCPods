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
            let password = passwordTextField.text, !password.isEmpty else {
                let title = "Invalid Entry"
                let message = "Please ensure you've entered a valid Email and password"
                presentSimpleAlertWith(title: title, message: message) { (_) in }
                return
        }
        
        FirebaseController.shared.createUserWith(email: username, password: password) { (user, error) in
            TrainerController.currentUser = user
            self.validateUserAndProceed(error: error)
        }
    }
    
    func presentSimpleAlertWith(title: String, message: String, completion: @escaping (UIAlertAction) -> Void) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: completion)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func validateUserAndProceed(error: Error?) {
        if TrainerController.currentUser != nil {
            let title = "New Trainer Creation Successful"
            let message = "Tap OK to proceed"
            self.presentSimpleAlertWith(title: title, message: message) { (_) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let homeNavController = storyboard.instantiateViewController(withIdentifier: "HomeNavController") as? UINavigationController else { return }
                UIApplication.shared.keyWindow?.rootViewController = homeNavController
            }
        } else {
            let title = "New Trainer Creation Unsuccessful"
            let message = error?.localizedDescription ?? "Unknown Error"
            self.presentSimpleAlertWith(title: title, message: message, completion: { (_) in })
        }
    }
}
