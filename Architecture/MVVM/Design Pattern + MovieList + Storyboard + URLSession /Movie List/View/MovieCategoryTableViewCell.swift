//
//  MovieCategoryTableViewCell.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 2/8/23.
//

import UIKit

class MovieCategoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var categoryCV: UICollectionView!
    private var vm: MovieViewModel!
    private var callbackClosure: ((IndexPath) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        configCV()
    }

    func configCell(vm: MovieViewModel, callbackClosure: ((_ cellIndexPath: IndexPath) -> Void)?) {
        self.vm = vm
        self.callbackClosure = callbackClosure
    }

    private func configCV() {
        categoryCV.registerNibCell(CategoryCollectionViewCell.self)
        categoryCV.dataSource = self
        categoryCV.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MovieCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.movieCategoriesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as CategoryCollectionViewCell
        cell.configCell(categoryName: vm.getCategoryName(using: indexPath.row))
        return cell
    }
}

extension MovieCategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        callbackClosure?(indexPath)
    }
}




