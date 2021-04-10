//
//  PictureOfDayHeader.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import UIKit

final class PictureOfDayHeader: UICollectionReusableView {
    private let imageView = UIImageView(image: UIImage(named: "leclickImageTest"))
    private let gradientView = GradientView()
    private let titleLabel = CustomLabel(color: .white, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    private let gradientColor = UIColor(hex: "#000000")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubviews([imageView])
        imageView.addSubview(gradientView)
        gradientView.addSubview(titleLabel)
        imageView.backgroundColor = .black
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        setupGradientView()
        setupTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: PictureOfDayModel) {
        let url = URL(string: model.url ?? "")
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        titleLabel.text = model.title
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
    
    private func setupTitle() {
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
        }
        
        titleLabel.textAlignment = .center
    }
}
