//
//  ProfileViewController.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var current_user: User?
    //Profile Photo
    
    //Full Name
    
    //Email
    var email: String = ""
    
    //posts...
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        
        
        
        setUpSignOutButton()
        fetchUserData()
        
    }
    
    private func fetchUserData() {
        //Get the user email
        guard let currentUserEmail = UserDefaults.standard.string(forKey: "email") else{
            return;
        }
        email = currentUserEmail
        self.title = email
        
        //Fetch the user data from that email
        DatabaseManager.shared.getUser(email: email) { user in
            guard let user = user else{
                return
            }
            self.current_user = user
        }
    }
    
    private func setupEmail(){
        
    }
    
    private func setUpSignOutButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(didTapSignOut))
    }
    
    @objc private func didTapSignOut() {
        print("Did tap sign out...")
    }
    

}
