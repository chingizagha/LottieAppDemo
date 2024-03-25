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
    
    var nextButtonDidTap: (() -> Void)?
    var skipButtonDidTap: (() -> Void)?
    
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(nextButton)
        stackView.addArrangedSubview(skipButton)
        contentView.addSubviews(uiView, label, stackView)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc
    private func didTapNext(){
        nextButtonDidTap?()
    }
    
    @objc
    private func didTapSkip(){
        skipButtonDidTap?()
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
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    public func configure(with slide: Slide) {
        label.text = slide.title
        nextButton.setTitle(slide.buttonTitle, for: .normal)
        nextButton.backgroundColor = slide.buttonColor
        uiView.animation = LottieAnimation.named(slide.animationName)
        uiView.loopMode = .loop
        if !uiView.isAnimationPlaying {
            uiView.play()
        }
    }
    
    
}
