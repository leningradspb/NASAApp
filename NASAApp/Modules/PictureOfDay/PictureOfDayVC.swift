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
        
        setupCollectionView()
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
}
// MARK: - CollectionView Setup (UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout)
extension PictureOfDayVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PictureOfDayHeader.identifier, for: indexPath) as! PictureOfDayHeader
        
        //TODO:
        header.configure()
        //
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: view.bounds.width, height: 156)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureOfDayCell.identifier, for: indexPath) as? PictureOfDayCell else { return UICollectionViewCell() }
        cell.backgroundColor = .green
        return cell
        
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
