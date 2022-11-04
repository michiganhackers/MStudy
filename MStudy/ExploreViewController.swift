//
//  ExploreViewController.swift
//  MStudy
//
//  Created by Drew Scheffer on 11/3/22.
//

import UIKit

class ExploreViewController: UIViewController {
    
    @IBOutlet weak var test: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        test.image = UIImage(named: "group")
        
        //Setup the TableView
        let cellNib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "myCell")
        tableView.delegate = self
        tableView.dataSource = self
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
