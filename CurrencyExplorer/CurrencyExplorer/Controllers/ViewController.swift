//
//  ViewController.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/8/24.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {
    private var currentCountriesList: [Country]?
    private var filteredCountries = [Country]()
    private var totalCountries = [Country]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var countriesViewModel : CountriesViewModel!
    private var dataSource : CountriesTableViewDataSource<ViewTableViewCell, Country>!

    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.mediumFontSize, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.accessibilityIdentifier = Constants.errorLabelIdentifier
        label.isAccessibilityElement = true
        return label
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        return activityIndicator
    }()

    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = Constants.tableViewIdentifier
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.separatorInset = UIEdgeInsets(top: 0, left: Constants.seperatorInsetSideMargin, bottom: 0, right: Constants.seperatorInsetSideMargin)
        tableView.register(ViewTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = .navyBlueColor
        tableView.separatorColor = .white
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
        view.backgroundColor = .navyBlueColor

        addConstraints()
        makeSearchBarUI()
        updateNavigationTitle()
        callToViewModelForUIUpdate()
    }

    private func makeSearchBarUI() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.placeholder
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.backgroundColor = .clear
        searchController.searchBar.barTintColor = .navyBlueColor
        searchController.searchBar.tintColor = .navyBlueColor
        searchController.searchBar.layer.borderColor = UIColor.navyBlueColor.cgColor
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.searchTextField.backgroundColor = .systemBackground
        searchController.searchBar.accessibilityIdentifier = Constants.searchBarIdentifier
    }

    private func updateNavigationTitle() {
        title = Constants.title
        navigationItem.backButtonDisplayMode = .minimal
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:  UIColor.white]
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.backgroundColor = .navyBlueColor
        navigationController?.navigationBar.barTintColor = .navyBlueColor
    }

    func callToViewModelForUIUpdate(){
        activityIndicator.startAnimating()
        countriesViewModel = CountriesViewModel()
        countriesViewModel.bindCountriesViewModelToController = {
            if let error = self.countriesViewModel.error {
                self.activityIndicator.stopAnimating()
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: Constants.errorTitle, message: error.localizedDescription, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: Constants.okTitle, style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.updateDataSource()
            }
        }
    }

    func updateDataSource() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            totalCountries = countriesViewModel.countries
            currentCountriesList = searchController.isActive && searchController.searchBar.text != "" ? filteredCountries : countriesViewModel.countries
            
            dataSource = CountriesTableViewDataSource(cellIdentifier: Constants.tableViewCellIdentifier, items: currentCountriesList ?? totalCountries)
            activityIndicator.stopAnimating()
            tableView.dataSource = dataSource
            tableView.reloadData()
        }
    }

    private func addConstraints() {
        var customConstraints = [NSLayoutConstraint]()
        customConstraints.append(activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        customConstraints.append(activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        customConstraints.append(errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        customConstraints.append(errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        customConstraints.append(tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        customConstraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        customConstraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        customConstraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))

        NSLayoutConstraint.activate(customConstraints)
    }

    private func filterCountries(for searchText: String) {
        filteredCountries = totalCountries.filter { country in
            return country.name.lowercased().contains(searchText.lowercased()) || country.capital.lowercased().contains(searchText.lowercased())
        }

        if currentCountriesList?.count == 0 {
            print(Constants.errorText)
            errorLabel.text = Constants.errorText
        }

        updateDataSource()
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let countries = currentCountriesList else { return }
        let country: Country = searchController.isActive && searchController.searchBar.text != "" ? filteredCountries[indexPath.row] : countries[indexPath.row]

        let detailsViewController = DetailsViewController(country: country)
        searchController.isActive = false
        navigationController?.pushViewController(detailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.sectionHeaderHeight

    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = .white
    }
}

extension ViewController: UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterCountries(for: searchController.searchBar.text ?? "")
    }
}
