//
//  OnboardingCollectionViewCell.swift
//  RestaurantAppOnboardingScreen
//
//  Created by Chingiz on 10.03.24.
//

import UIKit
import Lottie


class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    var actionButtonDidTap: (() -> Void)?
    
    private var uiView: LottieAnimationView = {
        let view = LottieAnimationView()
        view.backgroundColor = .systemBackground
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Food as tis best"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubviews(uiView, label, button)
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func didTapNext(){
        actionButtonDidTap?()
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            uiView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 50),
            uiView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            uiView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            uiView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            uiView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            label.topAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -65),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 65),
        ])
    }
    
    public func configure(with slide: Slide) {
        label.text = slide.title
        button.setTitle(slide.buttonTitle, for: .normal)
        button.backgroundColor = slide.buttonColor
        uiView.animation = LottieAnimation.named(slide.animationName)
        uiView.loopMode = .loop
        if !uiView.isAnimationPlaying {
            uiView.play()
        }
    }
    
    
}
