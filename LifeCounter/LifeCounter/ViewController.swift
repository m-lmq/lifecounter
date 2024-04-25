//
//  ViewController.swift
//  LifeCounter
//
//  Created by Maggie Liang on 4/17/24.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var initialUser:Int = 4
    var maximumUser:Int = 8
    var isStart:Bool = false
    @IBOutlet weak var startstopgameLabel: UIBarButtonItem!
    var count = 0
    @IBOutlet weak var theTable: UITableView!
    static var scoreArray:[Int] = [20,20,20,20]
    static var playerName:[String] = ["Player 1","Player 2","Player 3","Player 4"]
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    
    @IBAction func removeUserTapped(_ sender: Any) {
        if isStart {
            let alertController = UIAlertController(title: "Game Already Started", message: "You cannot change players once the game has started.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {

            if initialUser > 2 {
                initialUser -= 1
                ViewController.scoreArray.removeLast()
                ViewController.playerName.removeLast()
                theTable.reloadData()
            }else{
                let alertController = UIAlertController(title: "Reach Minimum 2 Players Limit", message: "You cannot delete more players.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func newUserTapped(_ sender: Any) {
        if isStart {
            let alertController = UIAlertController(title: "Game Already Started", message: "You cannot change players once the game has started.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            if initialUser < maximumUser {
                initialUser += 1
                ViewController.scoreArray.append(20)
                ViewController.playerName.append("Player \(initialUser)")
                theTable.reloadData()
            } else {
                let alertController = UIAlertController(title: "Reach Maximum 8 Players Limit", message: "You cannot add more players.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(okAction)
                present(alertController, animated: true, completion: nil)
            }
        }
    }

    
    @IBAction func startorstopgame(_ sender: Any) {
           count += 1
           if count % 2 == 0 {
               // print("execute stop game action...")
               isStart = false
               startstopgameLabel.title = "Start Game"
               historyViewController.historyList.append("Game Stopped")
               stopTimer()
           } else {
               // print("execute start game action...")
               theTable.reloadData()
               isStart = true
               startstopgameLabel.title = "Stop Game"
               historyViewController.historyList.append("Game Started")
               startTimer()
           }
       }
       
       func startTimer() {
           timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkGameEnd), userInfo: nil, repeats: true)
       }
       
       func stopTimer() {
           timer?.invalidate()
           timer = nil
       }
    
    
    // EXTRA CREDIT: Game Over and Reset
    @objc func checkGameEnd() {
        let positiveScores = ViewController.scoreArray.filter { $0 > 0 }.count
        if positiveScores == 1 {
            // print("Game over!")
            stopTimer()
            if ViewController.scoreArray.firstIndex(where: { $0 > 0 }) != nil {
                let alert = UIAlertController(title: "GAME OVER", message: "All but one still has life", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                resetGame()
                historyViewController.historyList.append("Game Over System Reset")
            }
        }
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return initialUser
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiftCounterTableViewCell", for: indexPath) as! LiftCounterTableViewCell
        cell.playerName.text = ViewController.playerName[indexPath.row]
        // print("ccc\(ViewController.playerName.description)")
        cell.currentValue = 0
        cell.decreaseButton.addTarget(self, action: #selector(decreaseTapped(_:)), for: .touchUpInside)
        cell.increaseButton.addTarget(self, action: #selector(increaseTapped(_:)), for: .touchUpInside)
        cell.numberInput.text = ""
        cell.scoreLabel.text = String(ViewController.scoreArray[indexPath.row])
        return cell
    }

    @objc func decreaseTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? LiftCounterTableViewCell else { return }
        cell.currentValue -= 1
    }

    @objc func increaseTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? LiftCounterTableViewCell else { return }
        cell.currentValue += 1
    }
   
    // EXTRA CREDIT: Game Reset
    @IBAction func resetGame(_ sender: Any) {
       resetGame()
       historyViewController.historyList.append("Life Counter System Reset")
    }
    
    func resetGame(){
        count = 0
        initialUser = 4
        isStart = false
        ViewController.scoreArray = [20,20,20,20]
        ViewController.playerName = ["Player 1","Player 2","Player 3","Player 4"]
        theTable.reloadData()
        startstopgameLabel.title = "Start Game"
    }
}
