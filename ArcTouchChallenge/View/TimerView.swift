//
//  TimerView.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class TimerView: UIView {
    
    var numberOfAnswers: Int = 0 {
        didSet {
            updateAnswers()
        }
    }
    var numberOfCorrectAnswers: Int = 0 {
        didSet {
            updateAnswers()
        }
    }
        
    var correctAnswersLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    var resetButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Start", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.backgroundColor = .systemGray5
        self.addSubview(correctAnswersLabel)
        self.addSubview(elapsedTimeLabel)
        self.addSubview(resetButton)
        
        correctAnswersLabel.translatesAutoresizingMaskIntoConstraints = false
        correctAnswersLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        correctAnswersLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        elapsedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        elapsedTimeLabel.centerYAnchor.constraint(equalTo: correctAnswersLabel.centerYAnchor).isActive = true
        elapsedTimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        resetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        resetButton.topAnchor.constraint(equalTo: correctAnswersLabel.bottomAnchor, constant: 10).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
    
    func updateElapsedTime(time: (Int, Int)) {
        elapsedTimeLabel.text = String(format: "%02d", time.0) + ":" + String(format: "%02d", time.1)
    }
    
    func updateAnswers() {
        correctAnswersLabel.text = String(format: "%02d", numberOfCorrectAnswers) + "/" + String(numberOfAnswers)
    }
    
    func resetAnswers() {
        numberOfCorrectAnswers = 0
        elapsedTimeLabel.text = "00:00"
    }
}
