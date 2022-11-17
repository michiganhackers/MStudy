//
//  SignInViewController.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    //Header field...
    @IBOutlet weak var emailTextField: UITextField!
    
    // Email field
    private let emailField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Email Address"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()

    // Password field
    private let passwordField: UITextField = {
        let field = UITextField()
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()

    // Sign In button
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        return button
    }()

    // Create Account
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the view...
        title = "Sign In"
        view.backgroundColor = .systemBackground
        self.view.backgroundColor = .systemBackground
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(createAccountButton)

        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccount), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        emailField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: self.view.frame.size.width-40, height: 50)
        
        print(emailField.frame.minX)
        passwordField.frame = CGRect(x: 20, y: emailField.frame.maxY+10, width: self.view.frame.size.width-40, height: 50)
        signInButton.frame = CGRect(x: 20, y: passwordField.frame.maxY+10, width: self.view.frame.size.width-40, height: 50)
        createAccountButton.frame = CGRect(x: 20, y: signInButton.frame.maxY+30, width: self.view.frame.size.width-40, height: 50)
    }
    
    @objc func didTapSignIn() {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            return
        }
        UserDefaults.standard.set(email, forKey: "email")
        
        AuthManager.shared.signIn(email: email, password: password) { success in
            if (success){
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "signinSegue", sender: self)
                }
            }
        }
    }

    @objc func didTapCreateAccount() {
        performSegue(withIdentifier: "toSignupScreenSegue", sender: self)
    }
}
