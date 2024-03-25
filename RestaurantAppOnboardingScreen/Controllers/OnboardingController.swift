//
//  ViewController.swift
//  RestaurantAppOnboardingScreen
//
//  Created by Chingiz on 10.03.24.
//

import UIKit

struct Slide {
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String
    
    static let collection: [Slide] = [
        .init(title: "Get your favourite food delivered to you under 30 minutes anytime", animationName: "res02", buttonColor: .systemYellow, buttonTitle: "Next"),
        .init(title: "We serve only from choiced restaurants in your area", animationName: "res01", buttonColor: .systemGreen, buttonTitle: "Order Now"),
        ]
}

class OnboardingController: UIViewController {
    
    private let slides: [Slide] = Slide.collection
    
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .darkGray
        control.currentPageIndicatorTintColor = .lightGray
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SS"
        view.backgroundColor = .systemBackground
        view.addSubviews(collectionView, pageControl)
        collectionView.delegate = self
        collectionView.dataSource = self
        addConstraints()
        setUpPageControl()
    }
    
    private func setUpPageControl(){
        pageControl.numberOfPages = slides.count
        let angle = CGFloat.pi
        pageControl.transform = CGAffineTransform(rotationAngle: angle)
    }
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -115),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor),
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    private func handleNextButtonTap(at indexPath: IndexPath) {
        if indexPath.item == slides.count - 1 {
            let vc = MainViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            //navigationController?.pushViewController(vc, animated: true)
        } else {
            let nextItem = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextItem, section: 0)
            collectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
            pageControl.currentPage = nextItem
        }
    }
    
    private func handleSkipButtonTap(){
        /// UserDefault make isFirstTime = false
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(collectionView.contentOffset.y / scrollView.frame.size.height)
        pageControl.currentPage = index
        
    }
}

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else {fatalError()}
        cell.backgroundColor = .systemBackground
        let slide = slides[indexPath.row]
        cell.configure(with: slide)
        cell.nextButtonDidTap = { [weak self] in
            self?.handleNextButtonTap(at: indexPath)
        }
        cell.skipButtonDidTap = { [weak self] in
            self?.handleSkipButtonTap()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

