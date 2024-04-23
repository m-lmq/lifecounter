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
    @IBOutlet var p1Input: UITextField!
    @IBOutlet var p2Input: UITextField!
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

    @IBAction func p1Inc(_ sender: UIButton) {
        if let amount = Int(p1Input.text ?? "0") {
            p1Life += amount
            updateLifeTotals()
            checkForLoser()
        }
    }

    @IBAction func p1Dec(_ sender: UIButton) {
        if let amount = Int(p1Input.text ?? "0") {
            p1Life -= amount
            updateLifeTotals()
            checkForLoser()
        }
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

    @IBAction func p2Inc(_ sender: UIButton) {
        if let amount = Int(p2Input.text ?? "0") {
            p2Life += amount
            updateLifeTotals()
            checkForLoser()
        }
    }

    @IBAction func p2Dec(_ sender: UIButton) {
        if let amount = Int(p2Input.text ?? "0") {
            p2Life -= amount
            updateLifeTotals()
            checkForLoser()
        }
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
