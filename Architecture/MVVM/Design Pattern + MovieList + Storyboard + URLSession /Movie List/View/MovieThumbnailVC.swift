//
//  MovieThumbnelVC.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 3/8/23.
//

import UIKit

class MovieThumbnailVC: UIViewController {
    @IBOutlet weak var thumbnailCV: UICollectionView!
    var vm: MovieViewModel!
    var queryString: String!
    private var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbnailCV.registerNibCell(MovieThumbnailCV.self)
        thumbnailCV.dataSource = self
        thumbnailCV.delegate = self
        thumbnailCV.collectionViewLayout = UICollectionViewFlowLayout()

        bindViewModelData()
        self.spinner = self.showLoader(view: self.view)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.vm.searchMovie(withQueryString: self.queryString)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init(vm: MovieViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }

    private func bindViewModelData() {
        vm.movieListFetchStatus.bindAndFire { [weak self] success in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                if success {
                    print(success)
                    self.thumbnailCV.reloadData()
                }
                self.spinner.dismissLoader(view: self.view)
            }
        }
    }

    func showLoader(view: UIView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        spinner.backgroundColor = .black.withAlphaComponent(0.5)
        spinner.layer.cornerRadius = 5.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = .large
        spinner.color = .white
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        view.isUserInteractionEnabled = false
        return spinner
    }
}

extension MovieThumbnailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(vm.rowCount)
        return vm.rowCount - 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieThumbnailCV
        cell.configCell(posterUrl: vm.movieList.value[indexPath.row].posterUrl)
        return cell
    }
}

extension MovieThumbnailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)/2.0 - 2
        return CGSize(width: width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
