//
//  ViewController.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.04.2021.
//

import UIKit
import SnapKit

class PictureOfDayVC: UIViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    /// расстояние по бокам от collectionView
    private let inset: CGFloat = 16
    /// количество ячеек на ширину экрана (по 2)
    private let cellCountPerWidth: CGFloat = 2
    private let activity = UIActivityIndicatorView(style: .medium)
    private let apiService = ApiService()
    private var pictures: [PictureOfDayModel]?
    private var headerPicture: PictureOfDayModel?
    // MARK: - Computed Properties
    /// флаг для определения маленького экрана
    private var isIPhoneSE: Bool {
        view.bounds.width == 320
    }
    /// расстояние между ячейками
    private var cellPadding: CGFloat {
        isIPhoneSE ? 10 : 15
    }
    
    private var compilationCellWidthAndHeight: CGFloat {
        (view.bounds.width - cellPadding - (inset * 2)) / cellCountPerWidth
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ThemeService.shared.viewColor
        setupActivity()
        setupCollectionView()
        loadPicturesOfDay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupActivity() {
        view.addSubview(activity)
        
        activity.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor  = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        collectionView.register(PictureOfDayHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PictureOfDayHeader.identifier)
        collectionView.register(PictureOfDayCell.self, forCellWithReuseIdentifier: PictureOfDayCell.identifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func loadPicturesOfDay() {
        activity.startAnimating()
        apiService.requestGame { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
                self.activity.stopAnimating()
                return
            }
            
            if let pictures = result {
                DispatchQueue.main.async {
                    self.pictures = pictures.reversed()
                    self.headerPicture = self.pictures?[0]
                    self.pictures?.remove(at: 0)
                    self.activity.stopAnimating()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc private func headerTapped() {
        guard let pictureModel = headerPicture else { return }
        let vc = PictureOfDayDetailVC(pictureOfDayModel: pictureModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - CollectionView Setup (UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout)
extension PictureOfDayVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PictureOfDayHeader.identifier, for: indexPath) as! PictureOfDayHeader
        
        if header.gestureRecognizers == nil {
            setupTapRecognizer(for: header, action: #selector(headerTapped))
        }
        
        if let model = headerPicture {
            header.configure(with: model)
        }
    
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return headerPicture == nil ? .zero : CGSize(width: view.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureOfDayCell.identifier, for: indexPath) as? PictureOfDayCell else { return UICollectionViewCell() }
        
        if let pictures = self.pictures {
            cell.update(with: pictures[indexPath.row])
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let pictureModel = pictures?[indexPath.row] else { return }
        let vc = PictureOfDayDetailVC(pictureOfDayModel: pictureModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: compilationCellWidthAndHeight, height: compilationCellWidthAndHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellPadding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
}


extension UIViewController
{
    func setupTapRecognizer(for view: UIView, action: Selector?)
    {
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: action)
        
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(singleTapGestureRecognizer)
    }
}
