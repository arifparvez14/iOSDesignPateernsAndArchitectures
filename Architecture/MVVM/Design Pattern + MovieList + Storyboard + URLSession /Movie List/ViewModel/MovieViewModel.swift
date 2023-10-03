//
//  MovieViewModel.swift
//  Movie List
//

import Foundation
import UIKit

protocol MovieViewModelProtocol {
    var movieList: Bindable<[MovieResult]> { get }
    var movieListFetchStatus: Bindable<Bool> { get }
    func searchMovie(withQueryString query: String?)
    var categoryCellInfo: (cellIndex: Int, cellHeight: CGFloat) { get }
    var rowCount: Int { get }
    var movieCategoriesCount: Int { get }
    func getCategoryName(using index: Int) -> String
    func getSelectedMovieInfo(using index: Int) -> MovieResult
    func getMovieCategoryName(from index: Int) -> String
}

class MovieViewModel: NSObject, MovieViewModelProtocol {
    var movieListFetchStatus: Bindable<Bool> = Bindable(false)
    var movieList: Bindable<[MovieResult]> = Bindable([])
    private var clientService: ClientService
    private var _movieCategories = [String]()

    var movieCategoriesCount: Int {
        return _movieCategories.count
    }

    var categoryCellInfo: (cellIndex: Int, cellHeight: CGFloat) {
        return (0, 200)
    }

    var rowCount: Int {
        return movieList.value.count + 1
    }

    override init() {
        self.clientService = ClientService()
        _movieCategories = ["Marvel", "Action", "Sci-fi", "Horror", "Fantasy", "Love"]
        super.init()
    }

    func getSelectedMovieInfo(using index: Int) -> MovieResult {
        return movieList.value[index]
    }

    func getMovieCategoryName(from index: Int) -> String {
        return _movieCategories[index]
    }

    func searchMovie(withQueryString query: String?) {
        Log.info("Search movie with query string - \(String(describing: query))")
        self.clientService.searchMovie(query: query) { [weak self] movieList in
            guard let `self` = self else { return }
            switch movieList {
            case .success(let list):
                self.movieList.value = list.results.map({ (movie) -> MovieResult in
                    var returnMovie = movie
                    returnMovie.cellHeight = self.calculateCellHeight(forItem: movie)
                    returnMovie.posterUrl = URL(string: baseImageUrl + (returnMovie.posterPath ?? "")) ?? nil
                    return returnMovie
                })
                self.movieListFetchStatus.value = true

            case .failure(let error):
                self.movieListFetchStatus.value = false
                Log.info(error.localizedDescription)
            }
        }
    }

    func getCategoryName(using index: Int) -> String {
        return _movieCategories[index]
    }

    private func calculateCellHeight(forItem item: MovieResult) -> CGFloat {
        let labelWidth = UIScreen.main.bounds.width - posterImageWidth - 68     //68 = 3*16 (item gap) + 20 (safe area)
        let overViewLabelFont = UIFont.systemFont(ofSize: labelFontSize)
        let titleLabelFont = UIFont.boldSystemFont(ofSize: labelFontSize)
        let overViewLabelHeight = item.overview?.height(withConstrainedWidth: labelWidth, font: overViewLabelFont)
        let titleLabelHeight = item.title?.height(withConstrainedWidth: labelWidth, font: titleLabelFont)
        let totalHeight = titleLabelHeight! + overViewLabelHeight! + 40     //40 = 3*10 (item gap) + 10 padding
        return totalHeight > defaultCellHeight ? totalHeight : defaultCellHeight
    }

    //MARK: - Cart functionalities
    
}
