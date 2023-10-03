//
//  Protocols.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 2/8/23.
//

import Foundation

import UIKit

protocol ReusableView {
    static var reuseID: String { get }
}

extension ReusableView {
    static var reuseID: String {
        return String(describing: Self.self)
    }
}

protocol ConfigurableTableViewCellData {
    static var reuseableIDForContainer: String { get }
}

extension ConfigurableTableViewCellData {
    static var reuseableIDForContainer: String {
        return "\(String(describing: self))Container"
    }
}

protocol ConfigurableTableViewCellDataContainer {
    associatedtype AccecptableViewModelType: ConfigurableTableViewCellData
    static var reuseableContainerID: String { get }
}

extension ConfigurableTableViewCellDataContainer {
    static var reuseableContainerID: String {
        return String(describing: AccecptableViewModelType.reuseableIDForContainer)
    }
}

protocol ConfigurableTableViewCell: UITableViewCell {
    func configure(viewModel: ConfigurableTableViewCellData)
}


protocol StoryboardBased {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
    static func instantiate() -> Self
}

extension StoryboardBased where Self: UIViewController {

    /// Name of the storyboard from which view controller will be instantiated
    /// Must override this property if storyboard name is different from view controller's name
    static var storyboardName: String {
        return "\(Self.self)"
    }

    /// Storyboard identifier for the view controller
    /// Must override this property if storyboard identifier is different from view controller's name
    static var storyboardIdentifier: String {
        return "\(Self.self)"
    }

    /// This method instantiate a UIViewController from UIStoryboard
    /// - Returns: UIViewController
    static func instantiate() -> Self  {
        let storyboard = UIStoryboard(name: storyboardName , bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Can't load view controller \(Self.self) from storyboard named \(storyboardName)")
        }
        return viewController
    }
}
