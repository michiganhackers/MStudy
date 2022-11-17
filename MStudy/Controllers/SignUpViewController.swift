//
//  SignInViewController.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //Header field...
    @IBOutlet weak var emailTextField: UITextField!
    
    // Name field
    private let nameField: UITextField = {
        let field = UITextField()
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        field.placeholder = "Name"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.masksToBounds = true
        return field
    }()
    
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
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = true
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up the view...
        title = "Sign Up"
        view.backgroundColor = .systemBackground
        self.view.backgroundColor = .systemBackground
        view.addSubview(nameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)

        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 100, width: self.view.frame.size.width-40, height: 50)
        emailField.frame = CGRect(x: 20, y: nameField.frame.maxY + 10, width: self.view.frame.size.width-40, height: 50)
        passwordField.frame = CGRect(x: 20, y: emailField.frame.maxY+10, width: self.view.frame.size.width-40, height: 50)
        signUpButton.frame = CGRect(x: 20, y: passwordField.frame.maxY+10, width: self.view.frame.size.width-40, height: 50)
    }
    
    @objc func didTapSignUp() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let name = nameField.text, !name.isEmpty else {
            return;
        }


        AuthManager.shared.signUp(email: email, password: password) {[weak self] success in
            if success {
                //Update the database with a new UserID
                let newUser = User(name: name, email: email)
                DatabaseManager.shared.insertUser(user: newUser) { inserted in
                    guard inserted else{
                        return
                    }
                    
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(name, forKey: "name")

                    DispatchQueue.main.async {
                        self?.performSegue(withIdentifier: "signUpSegue", sender: self)
                    }

                }
            }
        }
    }

}
