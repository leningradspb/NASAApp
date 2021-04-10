//
//  PictureOfDayCell.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import UIKit
// подбока
final class PictureOfDayCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let gradientView = GradientView()
    private let restaurantName = CustomLabel(color: .white, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    private let gradientColor = UIColor(hex: "#000000")
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    private func setupCell() {
        layer.cornerRadius = 10
        addSubviews([imageView, gradientView])
        gradientView.addSubview(restaurantName)
        setupImageView()
        setupGradientView()
        setupRestaurantName()
    }
    
    private func setupImageView() {
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupGradientView() {
        gradientView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(bounds.height / 2.5)
        }
        
        gradientView.layer.cornerRadius = 10
        gradientView.startColor = gradientColor.withAlphaComponent(0)
        gradientView.endColor = gradientColor.withAlphaComponent(0.6)
    }
    
    private func setupRestaurantName() {
        restaurantName.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
        }
        
        restaurantName.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
