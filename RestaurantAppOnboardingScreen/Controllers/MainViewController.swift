//
//  MainViewController.swift
//  RestaurantAppOnboardingScreen
//
//  Created by Chingiz on 10.03.24.
//

import UIKit

class MainViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = "Welcome"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(label)
        addConstraints()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.rightAnchor.constraint(equalTo: view.rightAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    



}
