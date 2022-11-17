//
//  ExploreViewController.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/3/22.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Create a post button
    private let composeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemOrange
        button.tintColor = .white
        button.setImage(UIImage(systemName: "square.and.pencil",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),
                        for: .normal)
        button.layer.cornerRadius = 30
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Explore"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true;
        
        composeButton.addTarget(self, action: #selector(didTapComposeButton), for: .touchUpInside)
        self.view.addSubview(composeButton)
        
        //Setup the TableView
        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "myCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        composeButton.frame = CGRect(x: self.view.frame.width - 70, y: self.view.frame.height - self.view.safeAreaInsets.bottom - 70, width: 60, height: 60)
    }
    
    @objc func didTapComposeButton() {
        performSegue(withIdentifier: "composeSegue", sender: self)
    }

}




extension ExploreViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! CustomTableViewCell
        cell.groupImage.image = UIImage(named: "group")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
