//
//  ViewController.swift
//  LifeCounter
//
//  Created by Maggie Liang on 4/17/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateLifeTotals()
        status.isHidden = true
    }
    
    @IBOutlet var p1LifeCount: UILabel!
    @IBOutlet var p2LifeCount: UILabel!
    @IBOutlet var status: UILabel!

    var p1Life = 20
    var p2Life = 20
    
    // Player 1 Actions
    @IBAction func p1Inc1(_ sender: UIButton) {
        p1Life += 1
        updateLifeTotals()
        checkForLoser()
    }

    @IBAction func p1Dec1(_ sender: UIButton) {
        p1Life -= 1
        updateLifeTotals()
        checkForLoser()
    }

    @IBAction func p1Inc5(_ sender: UIButton) {
        p1Life += 5
        updateLifeTotals()
        checkForLoser()
    }

    @IBAction func p1Dec5(_ sender: UIButton) {
        p1Life -= 5
        updateLifeTotals()
        checkForLoser()
    }

    // Player 2 Actions
    @IBAction func p2Inc1(_ sender: UIButton) {
        p2Life += 1
        updateLifeTotals()
        checkForLoser()
    }

    @IBAction func p2Dec1(_ sender: UIButton) {
        p2Life -= 1
        updateLifeTotals()
        checkForLoser()
    }

    @IBAction func p2Inc5(_ sender: UIButton) {
        p2Life += 5
        updateLifeTotals()
        checkForLoser()
    }

    @IBAction func p2Dec5(_ sender: UIButton) {
        p2Life -= 5
        updateLifeTotals()
        checkForLoser()
    }
    
    func updateLifeTotals() {
        p1LifeCount.text = "\(p1Life)"
        p2LifeCount.text = "\(p2Life)"
    }
    
    func checkForLoser() {
        if p1Life <= 0 {
            status.text = "Player 1 LOSES!"
            status.isHidden = false
        } else if p2Life <= 0 {
            status.text = "Player 2 LOSES!"
            status.isHidden = false
        } else {
            status.isHidden = true
        }
    }

}

