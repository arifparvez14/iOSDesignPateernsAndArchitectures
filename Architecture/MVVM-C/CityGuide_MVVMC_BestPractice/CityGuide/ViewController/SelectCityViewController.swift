//
//  SelectCityViewController.swift
//  CityGuide
//
//  Created by Muhammad Ariful islam on 2/10/23.
//

import UIKit

class SelectCityViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var cityTableView: UITableView!
    var viewModel: SelectCityViewModeling?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTableView.delegate = self
        cityTableView.dataSource = self
        viewModel?.dataDelegate = self
        viewModel?.loadCityListData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent || isBeingDismissed {
            viewModel?.isMovingToRoot()
        }
    }
}

extension SelectCityViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.source.count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemCell")
        }
        cell!.textLabel?.text = viewModel?.source[indexPath.row]
        return cell!
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//    {
//        viewModel?.selectRow(row: indexPath.row)
//    }
}

extension SelectCityViewController: SelectCityModelDataDelegate {
    func itemDidChange() {
        cityTableView.reloadData()
    }
}
