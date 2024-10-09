//
//  DetailsViewController.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/9/24.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate {
    private var country: Country

    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = Constants.tableViewIdentifier
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Constants.seperatorInsetSideMargin, bottom: 0, right: Constants.seperatorInsetSideMargin)
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: Constants.detailsTableViewCellIdentifier)
        tableView.backgroundColor = .navyBlueColor
        return tableView
    }()

    init(country: Country) {
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        view.backgroundColor = .navyBlueColor
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .white

        let textAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = country.name
        setupConstraints()
    }

    private func setupConstraints() {
        var customConstraints = [NSLayoutConstraint]()
        customConstraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        customConstraints.append(tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        customConstraints.append(tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        customConstraints.append(tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor))

        NSLayoutConstraint.activate(customConstraints)
    }
}

extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 8

        if country.currency.symbol == nil || country.language.code == nil {
            count -= 1
        }

        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.detailsTableViewCellIdentifier)  as! DetailsTableViewCell
        if indexPath.row == 0 {
            cell.configCellInfo(titleLabelText: Constants.regionTitle, detailLabelText: country.region)
        } else if indexPath.row == 6 {
            cell.configCellInfo(titleLabelText: Constants.capitalTitle, detailLabelText: country.capital)
        } else if indexPath.row == 1 {
            cell.configCellInfo(titleLabelText: Constants.codeTitle, detailLabelText: country.code)
        } else if indexPath.row == 2 {
            cell.configCellInfo(titleLabelText: Constants.currencyCodeTitle, detailLabelText: country.currency.code)
        } else if indexPath.row == 3 {
            cell.configCellInfo(titleLabelText: Constants.currencyNameTitle, detailLabelText: country.currency.name)
        } else if indexPath.row == 4 {
            cell.configCellInfo(titleLabelText: Constants.currencySymbolTitle, detailLabelText: country.currency.symbol ?? Constants.unavailableText)
        } else if indexPath.row == 5 {
            cell.configCellInfo(titleLabelText: Constants.flagTitle, detailLabelText: country.flag)
        } else if indexPath.row == 6 {
            cell.configCellInfo(titleLabelText: Constants.languageCodeTitle, detailLabelText: country.language.code ?? Constants.unavailableText)
        } else if indexPath.row == 7 {
            cell.configCellInfo(titleLabelText: Constants.languageNameTitle, detailLabelText: country.language.name)
        }
        return cell
    }
}

