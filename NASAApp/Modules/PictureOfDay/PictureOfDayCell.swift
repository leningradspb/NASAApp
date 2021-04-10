//
//  PictureOfDayCell.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import UIKit
import Kingfisher
// подбока
final class PictureOfDayCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let gradientView = GradientView()
    private let titleLabel = CustomLabel(color: .white, font: UIFont.systemFont(ofSize: 14, weight: .bold))
    private let gradientColor = UIColor(hex: "#000000")
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func update(with model: PictureOfDayModel) {
        
        imageView.kf.indicatorType = .activity
        let url = URL(string: model.url ?? "")
        backgroundColor = .black
        imageView.kf.indicatorType = .activity
//        imageView.kf.setImage(with: url)
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
//        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
//                     |> RoundCornerImageProcessor(cornerRadius: 20)
//        imageView.kf.setImage(
//            with: url,
//            placeholder: UIImage(named: "placeholderImage"),
//            options: [
//                .processor(processor),
//                .scaleFactor(UIScreen.main.scale),
//                .transition(.fade(1)),
//                .cacheOriginalImage
//            ])
//        imageView.kf.setImage(with: URL(string: model.url ?? ""))
        titleLabel.text = model.title
    }
    
    private func setupCell() {
        layer.cornerRadius = 10
        imageView.layer.cornerRadius = 10
//        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        addSubviews([imageView, gradientView])
        gradientView.addSubview(titleLabel)
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
        titleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
        }
        
        titleLabel.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
