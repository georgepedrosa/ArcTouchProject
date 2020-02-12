//
//  ChallengeView.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class ChallengeView: UIView {
    
    fileprivate var timerViewBottomConstraint: NSLayoutConstraint?
    
    var questionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert Word"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
//        tableView.separatorStyle = .none
        return tableView
    }()
    
    var timerView: TimerView = {
        let view = TimerView()
        view.updateAnswers()
        return view
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
        self.backgroundColor = .white
        
        self.addSubview(questionLabel)
        self.addSubview(textField)
        self.addSubview(tableView)
        self.addSubview(timerView)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        questionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        questionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 10).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: timerView.topAnchor).isActive = true
        
        timerView.translatesAutoresizingMaskIntoConstraints = false
        timerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        timerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        timerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        timerViewBottomConstraint = timerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        timerViewBottomConstraint?.isActive = true
    }
    
    func updateConstraintsForKeyboard(height: CGFloat) {
        timerViewBottomConstraint?.constant = -height
        timerView.updateConstraints()
    }
}
