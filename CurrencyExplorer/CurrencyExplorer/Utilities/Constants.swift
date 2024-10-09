//
//  Constants.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/9/24.
//

import Foundation

struct Constants {

    // URLs
    static let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json")

    // Constraints spacing/padding & size
    static let cornerRadius: CGFloat = 10
    static let separatorInsetMargin: CGFloat = 16
    static let seperatorInsetSideMargin: CGFloat = 5
    static let stackViewMargin: CGFloat = 16
    static let imageSize: CGFloat = 30
    static let sectionHeaderHeight: CGFloat = 36

    // TableViewCell identifiers
    static let detailsTableViewCellIdentifier = "detailsTableViewCellIdentifier"
    static let tableViewCellIdentifier = "tableViewCellIdentifier"

    // Accessibility identifiers
    static let tableViewIdentifier = "tableView"
    static let searchBarIdentifier = "searchBar"
    static let titleLabelIdentifier = "titleLabel"
    static let errorLabelIdentifier = "errorLabel"
    static let countryTextLabelIdentifier = "countryLabel"
    static let regionTextLabelIdentifier = "regionLabel"
    static let capitalTextLabelIdentifier = "capitalLabel"
    static let codeTextLabelIdentifier = "codeLabel"
    static let detailLabelIdentifier = "detailLabel"
    static let stackViewIdentifier = "stackView"
    static let horizontalstackViewIdentifier = "horizontalStackView"
    static let imageViewIdentifier = "imageView"

    // Font
    static let extraSmallFontSize: CGFloat = 13
    static let smallFontSize: CGFloat = 15
    static let mediumFontSize: CGFloat = 20

    // Strings: ViewController texts
    static let title = NSLocalizedString("Currency Explorer", comment: "currency explorer title")
    static let placeholder = NSLocalizedString(" Search by name or currency", comment: "searchbar placeholder")
    static let sectionHeaderTitle = NSLocalizedString("Country Name", comment: "tableview section header title")
    static let errorText = NSLocalizedString("No countries found", comment: "error label text")
    static let errorTitle = NSLocalizedString("Error", comment: "error text")
    static let okTitle = NSLocalizedString("Ok", comment: "Ok")

    // Strings: DetailsViewController texts
    static let regionTitle = NSLocalizedString("Region", comment: "region title")
    static let capitalTitle = NSLocalizedString("Capital", comment: "capital title details")

    static let codeTitle = NSLocalizedString("Code", comment: "code title")
    static let currencyCodeTitle = NSLocalizedString("Currency Code", comment: "currency code title")
    static let currencyNameTitle = NSLocalizedString("Currency Name", comment: "currency name title")
    static let currencySymbolTitle = NSLocalizedString("Currency Symbol", comment: "currency symbol title")
    static let unavailableText = NSLocalizedString("Unavailable", comment: "unavailable text")
    static let flagTitle = NSLocalizedString("Flag", comment: "flag title")
    static let languageCodeTitle = NSLocalizedString("Language Code", comment: "language code title")
    static let languageNameTitle = NSLocalizedString("Language Name", comment: "language name title")
}
