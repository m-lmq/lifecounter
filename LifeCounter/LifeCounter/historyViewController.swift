//
//  historyViewController.swift
//  LifeCounter
//
//  Created by Maggie Liang on 23/4/2024.
//

import UIKit

class historyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    static var historyList:[String] = []
    @IBOutlet weak var theTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        theTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyViewController.historyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell", for: indexPath) as! historyTableViewCell
        
        cell.recordLabel.text = historyViewController.historyList[indexPath.row]
        print(historyViewController.historyList[indexPath.row])
        return cell
    }
}
