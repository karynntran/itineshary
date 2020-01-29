////
////  Styles.swift
////  itineshary
////
////  Created by Karynn Elio on 1/28/20.
////  Copyright © 2020 karynntran. All rights reserved.
////

import UIKit

class BackgroundGradient {
    func createGradient(view: UIView,backgroundView: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor(red: 198/255, green: 220/255, blue: 255/255, alpha: 1).cgColor, UIColor(red: 0/255, green: 68/255, blue: 196/255, alpha: 1).cgColor]
        gradientLayer.shouldRasterize = true
        backgroundView.layer.addSublayer(gradientLayer)
    }

}
