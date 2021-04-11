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
    }
    
}

extension PictureOfDayDetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let url = URL(string: pictureOfDayModel.url ?? "")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        400
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PictureOfDayDetailCell.identifier, for: indexPath) as! PictureOfDayDetailCell
        cell.update(with: pictureOfDayModel)
        return cell
    }
}
