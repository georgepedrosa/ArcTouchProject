//
//  ViewController.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class ChallengeViewController: BaseViewController {
    
    var service = ChallengeService()
    var dataSource = ChallengeDataSource()
    var challenge: Challenge!
    
    var timer: Timer!
    var elapsedTime: Int = 0
    
    lazy var challengeView: ChallengeView = {
        let view = ChallengeView()
        view.tableView.delegate = dataSource
        view.tableView.dataSource = dataSource
        view.textField.addTarget(self, action: #selector(ChallengeViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = challengeView
        configInputNotifications()
        challengeView.timerView.resetButton.addTarget(self, action: #selector(resetChallenge), for: .touchUpInside)
        loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func configInputNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let height = notification.name == UIResponder.keyboardWillShowNotification ? keyboardFrame.height : 0
            
            challengeView.updateConstraintsForKeyboard(height: height)
            
            UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
            }
        }
    }
    
    func loadData() {
        startIndicatorViewAnimation()
        service.getChallenge { (challenge, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.challengeView.questionLabel.text = challenge!.question
                    self.challengeView.timerView.numberOfAnswers = challenge!.answers.count
                    self.challenge = challenge
                    self.challengeView.tableView.reloadData()
                } else {
                    print(error.debugDescription)
                }
                self.stopIndicatorViewAnimation()
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkWordHit(word: textField.text?.lowercased() ?? "")
    }
    
    func checkWordHit(word: String) {
        if challenge.answers.contains(word) && !dataSource.correctAnswers.contains(word.capitalizingFirstLetter()) {
            challengeView.textField.text = ""
            dataSource.correctAnswers.append(word.capitalizingFirstLetter())
            challengeView.timerView.numberOfCorrectAnswers = dataSource.correctAnswers.count
            challengeView.tableView.reloadData()
            checkChallengeFinished()
        }
    }
    
    @objc func fireTimer() {
        elapsedTime += 1
        challengeView.timerView.updateElapsedTime(time: secondsToMinutesSeconds(seconds: elapsedTime))
        if elapsedTime == 300 {
            timeFinished()
        }
    }
    
    func timeFinished() {
        elapsedTime = 0
        timer.invalidate()
        
        let message = "Sorry, time is up! You got " + String(dataSource.correctAnswers.count) + " out of " + String(challenge!.answers.count) + " answers."
        
        presentAlert(withTitle: "Time finished", andMessage: message, confirmTitle: "Try Again") {
            self.resetChallenge()
        }
    }
    
    
    func checkChallengeFinished() {
        if challengeView.timerView.numberOfCorrectAnswers == challenge.answers.count {
            elapsedTime = 0
            timer.invalidate()
            presentAlert(withTitle: "Congratulations", andMessage: "Good job! You found all the answers on time. Keep up with the great work.", confirmTitle: "Play Again") {
                self.resetChallenge()
            }
        }
    }
    
    @objc func resetChallenge() {
        
        if timer == nil {
            challengeView.timerView.resetButton.setTitle("Reset", for: .normal)
        } else {
            elapsedTime = 0
            timer.invalidate()
            dataSource.correctAnswers = []
            challengeView.timerView.resetAnswers()
            challengeView.tableView.reloadData()
        }
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
    }
    
    func secondsToMinutesSeconds (seconds : Int) -> (Int, Int) {
      return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
