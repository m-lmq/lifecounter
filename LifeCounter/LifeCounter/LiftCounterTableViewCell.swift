//
//  LiftCounterTableViewCell.swift
//  LifeCounter
//
//  Created by Maggie Liang on 23/4/2024.
//

import UIKit

class LiftCounterTableViewCell: UITableViewCell {
    @IBOutlet weak var decreaseButton:UIButton!
    @IBOutlet weak var increaseButton:UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var playerName: UILabel!
  
    var currentValue: Int = 0 {
        didSet {
            numberInput.text = "\(currentValue)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nameGesture = UITapGestureRecognizer(target: self, action: #selector(playerNameTapped))
        playerName.isUserInteractionEnabled = true
        playerName.addGestureRecognizer(nameGesture)
    }
    
    
    //EXTRA CREDIT: Change Player Name
    @objc func playerNameTapped() {
        let alertController = UIAlertController(title: "Enter Player Name", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter player name"
        }
        let confirmAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            guard let textField = alertController.textFields?.first, let playerName = textField.text else { return }
           
            if(playerName == ""){
                self.playerName.text = "N/A"
                if let indexPath = getParentTableView()?.indexPath(for: self) {
                    ViewController.playerName[indexPath.row] = "N/A"
                }
            } else {
                self.playerName.text = playerName
                if let indexPath = getParentTableView()?.indexPath(for: self) {
                    ViewController.playerName[indexPath.row] = playerName
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    var decreaseClickCount: Int = 0
    var currentScore: Int = 20
    @IBAction func decreaseTapped(_ sender: Any) {
        guard let inputText = numberInput.text, !inputText.isEmpty else { return }
        guard let inputValue = Int(inputText) else { return }
        
        if let indexPath = getParentTableView()?.indexPath(for: self) {
            print("Increase button tapped in row: \(indexPath.row)")
            let currentScore = ViewController.scoreArray[indexPath.row]
            let newScore = currentScore - inputValue
            ViewController.scoreArray[indexPath.row] = newScore
            print("result is \(newScore)")
            scoreLabel.text = "\(newScore)"
            numberInput.text = ""
            historyViewController.historyList.append("\(String(playerName.text!)) lost \(inputValue) life ")
        }
    }

    
    var increaseClickCount: Int = 0
    @IBAction func increaseTapped(_ sender: Any) {
        guard let inputText = numberInput.text, !inputText.isEmpty else { return }
      
        if let indexPath = getParentTableView()?.indexPath(for: self) {
            print("Increase button tapped in row: \(indexPath.row)")
            let a = ViewController.scoreArray[indexPath.row]
            let b = Int(numberInput.text!)!
            let c = a + b
            ViewController.scoreArray[indexPath.row] = c
            print("result is\(c)")
            scoreLabel.text = "\(c)"
            numberInput.text = ""
            historyViewController.historyList.append("\(String(playerName.text!)) gain \(b) life")
        }
    }
    
    
    func getParentTableView() -> UITableView? {
        var view = superview
        while view != nil {
            if let tableView = view as? UITableView {
                return tableView
            }
            view = view?.superview
        }
        return nil
    }
}
