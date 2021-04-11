//
//  PictureOfDayDetailCell.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 11.04.2021.
//

import UIKit

class PictureOfDayDetailCell: UITableViewCell {
    private let author = CustomLabel(color: .gray, font: UIFont.systemFont(ofSize: 15))
    private let titleLabel = CustomLabel(color: ThemeService.shared.textColor, font: UIFont.systemFont(ofSize: 20, weight: .bold))
    private let explanation = CustomLabel(color: ThemeService.shared.textColor, font: UIFont.systemFont(ofSize: 18, weight: .regular))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([author, titleLabel, explanation])
        selectionStyle = .none
//        let url = URL(string: pictureOfDayModel.url ?? "")
//
//        imageView.kf.indicatorType = .activity
//        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
//        imageView.contentMode = .scaleAspectFill
//
//
//        imageView.snp.makeConstraints {
////            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-130).priority(900)
////            $0.top.equalToSuperview()
//            $0.top.equalTo(view.snp.top)
//            $0.leading.equalToSuperview()
//            $0.trailing.equalToSuperview()
//            $0.height.equalTo(400)
////            $0.bottom.equalToSuperview().offset(-1000)
//        }
        author.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(author.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        explanation.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func update(with pictureModel: PictureOfDayModel) {
        author.text = pictureModel.copyright
        titleLabel.text = pictureModel.title
        explanation.text = pictureModel.explanation
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
