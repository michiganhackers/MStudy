//
//  ProfileViewController.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/10/22.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Profile"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(didTapSignOut))
        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapSignOut() {
        
    }
    

}
