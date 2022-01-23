//
//  UIView + Constraints.swift.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit

extension UIView {
    
    func bindSubviewsToBoundsView(_ views: [UIView], insets: UIEdgeInsets = .zero) {
        views.forEach {
        $0.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
          $0.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
          $0.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
          $0.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
          $0.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        ])
      }
    }
    
    func bindSubviewsToBoundsView(_ views: UIView..., insets: UIEdgeInsets = .zero) {
        bindSubviewsToBoundsView(views, insets: insets)
    }
    
    func addSubviewsForAutoLayout(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }

    func addSubviewsForAutoLayout(_ views: UIView...) {
        addSubviewsForAutoLayout(views)
    }

}
