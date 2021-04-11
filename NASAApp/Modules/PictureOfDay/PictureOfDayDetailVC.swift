//
//  PictureOfDayDetailVC.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 11.04.2021.
//

import UIKit

class PictureOfDayDetailVC: UIViewController {
    private let scrollView = UIScrollView()
    private let scrollViewContentView = UIView()
    private var pictureOfDayModel: PictureOfDayModel!
    private let imageView = UIImageView()
    private let author = CustomLabel(color: .gray, font: UIFont.systemFont(ofSize: 15))
    private let titleLabel = CustomLabel(color: ThemeService.shared.textColor, font: UIFont.systemFont(ofSize: 20, weight: .bold))
    private let explanation = CustomLabel(color: ThemeService.shared.textColor, font: UIFont.systemFont(ofSize: 18, weight: .regular))

    init(pictureOfDayModel: PictureOfDayModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.pictureOfDayModel = pictureOfDayModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ThemeService.shared.viewColor
        setupScrollView()
        setupScrollContentView()
        print(pictureOfDayModel.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        
        scrollView.contentInsetAdjustmentBehavior = .never
//        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
//        scrollView.contentInset = .zero
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().priority(250)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(250)
//            $0.height.equalTo(1000)
        }
    }
    
    private func setupScrollContentView() {
        scrollViewContentView.addSubviews([imageView, author, titleLabel, explanation])
        
        let url = URL(string: pictureOfDayModel.url ?? "")
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        imageView.contentMode = .scaleAspectFill
        author.text = pictureOfDayModel.copyright
        titleLabel.text = pictureOfDayModel.title
        explanation.text = pictureOfDayModel.explanation
        
        imageView.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-130).priority(900)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-1000)
        }
        
        author.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.top.equalToSuperview().offset(300)
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

}
