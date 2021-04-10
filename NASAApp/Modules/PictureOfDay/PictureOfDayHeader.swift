//
//  PictureOfDayHeader.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 10.04.2021.
//

import UIKit

final class PictureOfDayHeader: UICollectionReusableView {
    private let imageView = UIImageView(image: UIImage(named: "leclickImageTest"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
        }
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        
    }
}
