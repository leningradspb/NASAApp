//
//  PictureOfDayDetailVC.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 11.04.2021.
//

import UIKit

class PictureOfDayDetailVC: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let imageView = UIImageView()
    private var pictureOfDayModel: PictureOfDayModel!
    private var isInitialLoad = true
    private let navigationBarBackgroundView = UIView()
    private let pointOfAppearance: CGFloat = -70
    
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
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .white
        addNavigationBarBackgroundView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = ThemeService.shared.viewColor
        tableView.register(PictureOfDayDetailCell.self, forCellReuseIdentifier: PictureOfDayDetailCell.identifier)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let url = URL(string: pictureOfDayModel.url ?? "")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        imageView.contentMode = .scaleAspectFill
        
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 300)
        imageView.clipsToBounds = true
        view.addSubview(imageView)
        tableView.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
    }
    
    private func addNavigationBarBackgroundView() {
        navigationBarBackgroundView.backgroundColor = .black
        navigationBarBackgroundView.alpha = 0
        self.view.addSubview(navigationBarBackgroundView)
        let guide = self.view.safeAreaLayoutGuide
        navigationBarBackgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(guide.snp.top)
        }
//        navigationBarBackgroundView.isHidden = tableView.contentOffset.y > 245 ? false : true
    }
}

extension PictureOfDayDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureOfDayDetailCell.identifier, for: indexPath) as! PictureOfDayDetailCell
        cell.update(with: pictureOfDayModel)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        if isInitialLoad {
            isInitialLoad = false
            return
        }
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: -offset)
        
        if offset > pointOfAppearance {
//            navigationBarBackgroundView.isHidden = false
            
            if navigationItem.title != "\(pictureOfDayModel.title ?? "")" {
                navigationItem.title = "\(pictureOfDayModel.title ?? "")"
            }
            navigationBarBackgroundView.alpha = 1
        } else {
//            navigationBarBackgroundView.isHidden = true
            if navigationItem.title != "" {
                navigationItem.title = ""
            }
            navigationBarBackgroundView.alpha = (1 - (offset / -300))
        }
    }
}
