//
//  UITableview+Extension.swift
//  Movie List
//
//  Created by Muhammad Ariful Islam on 2/8/23.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: T.reuseID)
    }

    func registerConfigurableCellDataContainer<T: UITableViewCell>(_ cellClass: T.Type) where T: ConfigurableTableViewCellDataContainer {
        register(cellClass, forCellReuseIdentifier: T.reuseableContainerID)
    }

    func registerNibConfigurableCellDataContainer<T: UITableViewCell>(_ cellClass: T.Type, nibName: String = T.reuseID)  where T: ConfigurableTableViewCellDataContainer {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: T.reuseableContainerID)
    }

    func registerNibCell<T: UITableViewCell>(_ cellClass: T.Type, nibName: String = T.reuseID) {
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: T.reuseID)
    }

    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: T.reuseID)
    }

    func registerNibHeaderFooter<T: UITableViewHeaderFooterView>(_ viewClass: T.Type, nibName: String = T.reuseID) {
        register(UINib(nibName: nibName, bundle: nil), forHeaderFooterViewReuseIdentifier: T.reuseID)
    }

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("fatalError: Could not dequeue cell with identifier: \(T.reuseID) for cell at \(indexPath)")
        }
        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: T.reuseID) as? T else {
            fatalError("fatalError: Could not dequeue header/footer view with identifier: \(T.reuseID)")
        }
        return view
    }
}
