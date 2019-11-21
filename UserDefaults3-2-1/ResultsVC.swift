//
//  ResultsVC.swift
//  UserDefaults3-2-1
//
//  Created by  on 11/21/19.
//  Copyright © 2019 DocsApps. All rights reserved.
//

import UIKit

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    var scores: [Double] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadScoresFromUserDefaults()
        myTableView.reloadData()
    }
    
    // MARK: UserDefaults Methods
    func loadScoresFromUserDefaults()
    {
        let defaults = UserDefaults.standard
        scores = defaults.array(forKey: "scores") as? [Double] ?? [Double]()
    }

    // MARK: TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let score = scores[indexPath.row]
        cell.textLabel?.text = String(format: "%.02f", score)
        
        return cell
    }

}
