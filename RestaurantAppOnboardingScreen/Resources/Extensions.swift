//
//  Extensions.swift
//  RestaurantAppOnboardingScreen
//
//  Created by Chingiz on 10.03.24.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}
