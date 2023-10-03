//
//  ViewController.swift
//  Movie List
//

import UIKit

class ViewController: UIViewController, CartSubscriber {
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var noItemView: UIView!
    @IBOutlet weak var notificationButton: UIButton!

    private var searchController = UISearchController()
    private var spinner = UIActivityIndicatorView()
    private var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        Log.info("viewDidLoad [+]")
        self.title = viewTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        NSLayoutConstraint.activate([
            notificationButton.widthAnchor.constraint(equalToConstant: 34),
            notificationButton.heightAnchor.constraint(equalToConstant: 44),
        ])

        self.setUpTableView()
        self.setUpSearchController()
        self.bindViewModelData()
        self.spinner = self.showLoader(view: self.view)
        self.viewModel.searchMovie(withQueryString: nil)

        notificationButton.setTitle("", for: .normal)
        CartManager.sharedInstance.add(subscriber: self)
    }

    let badgeSize: CGFloat = 20
    let badgeTag = 9830384

    func badgeLabel(withCount count: Int) -> UILabel {
        let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: badgeSize, height: badgeSize))
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.tag = badgeTag
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .systemRed
        badgeCount.text = String(count)
        return badgeCount
    }

    func accept(changed cartCount: Int) {
        showBadge(withCount: cartCount)
    }

    func showBadge(withCount count: Int) {
        let badge = badgeLabel(withCount: count)
        notificationButton.addSubview(badge)

        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: notificationButton.leftAnchor, constant: 14),
            badge.topAnchor.constraint(equalTo: notificationButton.topAnchor, constant: 4),
            badge.widthAnchor.constraint(equalToConstant: badgeSize),
            badge.heightAnchor.constraint(equalToConstant: badgeSize)
        ])

        badge.layer.zPosition = 1
    }

    func removeBadge() {
        if let badge = notificationButton.viewWithTag(badgeTag) {
            badge.removeFromSuperview()
        }
    }

    private func setUpTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.registerNibCell(MovieTableViewCell.self)
        movieTableView.registerNibCell(MovieCategoryTableViewCell.self)
    }

    private func setUpSearchController() {
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.searchBar.delegate = self
    }

    private func bindViewModelData() {
        viewModel.movieListFetchStatus.bindAndFire { [weak self] success in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                if success {
                    self.showTableView(flag: self.viewModel.movieList.value.count > 0)
                    self.movieTableView.reloadData()
                    self.searchController.searchBar.text = nil
                    self.searchController.searchBar.showsCancelButton = false
                }
                self.spinner.dismissLoader(view: self.view)
            }
        }
    }

    private func showTableView(flag: Bool) {
        self.movieTableView.isHidden = !flag
        self.noItemView.isHidden = flag
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.rowCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == viewModel.categoryCellInfo.cellIndex {
            return self.viewModel.categoryCellInfo.cellHeight
        }
        return self.viewModel.movieList.value[indexPath.row].cellHeight ?? defaultCellHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.categoryCellInfo.cellIndex {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieCategoryTableViewCell
            cell.configCell(vm: self.viewModel) { [weak self] index in
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "MovieThumbnailVC") as! MovieThumbnailVC
                vc.vm = self?.viewModel
                vc.queryString = self?.viewModel.getMovieCategoryName(from: index.row)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieTableViewCell

            cell.configCell(
                title: viewModel.movieList.value[indexPath.row].title,
                overview: viewModel.movieList.value[indexPath.row].overview,
                posterUrl: viewModel.movieList.value[indexPath.row].posterUrl)
            cell.selectionStyle = .none
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailsVC.instantiate()
        vc.movie = viewModel.getSelectedMovieInfo(using: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.spinner = self.showLoader(view: self.view)
        viewModel.searchMovie(withQueryString: searchBar.text)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}

extension ViewController: StoryboardBased {
    static var storyboardName: String {
        return "Main"
    }
}
