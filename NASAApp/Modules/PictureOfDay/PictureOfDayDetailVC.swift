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
        print(pictureOfDayModel.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().priority(250)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(250)
            $0.height.equalTo(1000)
        }
    }

}
