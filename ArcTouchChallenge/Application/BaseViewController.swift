//
//  BaseViewController.swift
//  ArcTouchChallenge
//
//  Created by George Pedrosa on 15/12/19.
//  Copyright © 2019 George Pedrosa. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private lazy var indicatorBackgroundView: UIView = {
       return createBackgroundIndicatorView()
    }()
    
    private lazy var loadingIndicatorView: UIActivityIndicatorView = {
        return createIndicatorView()
    }()

    func presentAlert(withTitle title:String?, andMessage message:String?, confirmTitle: String = "Ok", completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { action in
            completion?()
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func presentErrorAlert(message: String? = nil, completion: (() -> Void)? = nil) {
        self.presentAlert(withTitle: "Erro", andMessage: message ?? "Ocorre um erro",completion: completion)
    }
    
    private func createBackgroundIndicatorView() -> UIView{
        let indicatorBackgroundView = UIView()
        
        view.addSubview(indicatorBackgroundView)
        
        indicatorBackgroundView.isHidden = false
        indicatorBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        indicatorBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        indicatorBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        indicatorBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        indicatorBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        indicatorBackgroundView.backgroundColor = .gray
        indicatorBackgroundView.bringSubviewToFront(view)
        
        return indicatorBackgroundView
    }
    
    
    private func createIndicatorView() -> UIActivityIndicatorView{
    
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        
        indicatorBackgroundView.addSubview(indicator)
        
        indicator.isHidden = false
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        indicator.centerXAnchor.constraint(equalTo: indicatorBackgroundView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: indicatorBackgroundView.centerYAnchor).isActive = true
        indicator.leadingAnchor.constraint(equalTo: indicatorBackgroundView.leadingAnchor, constant: 100).isActive = true
        indicator.trailingAnchor.constraint(equalTo: indicatorBackgroundView.trailingAnchor, constant: -100).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 150).isActive = true

        indicator.backgroundColor = .darkGray
        indicator.layer.cornerRadius = 10
        
        let label = UILabel()
        label.text = "Loading..."
        label.textColor = .white
        
        indicatorBackgroundView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: indicator.centerXAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: indicator.bottomAnchor, constant: -15).isActive = true
        
        return indicator
    }
    
    func isIndicatorAnimationActivy() -> Bool{
        return loadingIndicatorView.isAnimating
    }
    
    func startIndicatorViewAnimation(){
        loadingIndicatorView.startAnimating()
        indicatorBackgroundView.isHidden = false
    }
    
    func stopIndicatorViewAnimation(){
        loadingIndicatorView.stopAnimating()
        indicatorBackgroundView.isHidden = true
    }
    
    func presentConnectionError() {
        self.stopIndicatorViewAnimation()
        self.presentErrorAlert(message: "Houve um problema com a conexão, verifique se o dispositivo está conectado a uma rede", completion: nil)
    }
}


