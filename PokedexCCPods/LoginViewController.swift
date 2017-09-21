//
//  LoginViewController.swift
//  PokedexCCPods
//
//  Created by Thomas Ganley on 9/19/17.
//  Copyright © 2017 Thomas Ganley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = usernameTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        FirebaseController.shared.loginUserWith(email: email, password: password) { (user, error) in
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
            let title = "User Login Successful"
            let message = "Tap OK to proceed"
            presentSimpleAlertWith(title: title, message: message, completion: { (_) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                guard let homeNavController = storyboard.instantiateViewController(withIdentifier: "HomeNavController") as? UINavigationController else { return }
                UIApplication.shared.keyWindow?.rootViewController = homeNavController
            })
        } else {
            let title = "User Login Unsuccessful"
            let message = error?.localizedDescription ?? "Unknown Error"
            presentSimpleAlertWith(title: title, message: message, completion: { (_) in })
        }
    }
}
