//
//  ViewTableViewCell.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/10/24.
//

import Foundation
import UIKit

class ViewTableViewCell: UITableViewCell {
    private var customConstraints = [NSLayoutConstraint]()

    private lazy var countryTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: Constants.smallFontSize, weight: .bold)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.countryTextLabelIdentifier
        return label
    }()

    private lazy var regionTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.extraSmallFontSize, weight: .regular)
        label.textColor = .lightGray
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.regionTextLabelIdentifier
        return label
    }()

    private lazy var capitalTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .mustardYellowColor
        label.font = UIFont.systemFont(ofSize: Constants.smallFontSize, weight: .regular)
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.accessibilityIdentifier = Constants.capitalTextLabelIdentifier
        return label
    }()

    private lazy var codeTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: Constants.extraSmallFontSize, weight: .regular)
        label.textColor = .lightGray
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.accessibilityIdentifier = Constants.codeTextLabelIdentifier
        return label
    }()

    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [countryTextLabel, regionTextLabel, codeTextLabel])
        view.accessibilityIdentifier = Constants.horizontalstackViewIdentifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [horizontalStackView, capitalTextLabel])
        view.accessibilityIdentifier = Constants.stackViewIdentifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 5
        view.alignment = .leading
        view.distribution = .fill
        return view
    }()

    convenience init() {
        self.init(style: .default, reuseIdentifier: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .navyBlueColor

        contentView.addSubview(stackView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override func updateConstraints() {
        defer { super.updateConstraints() }
        guard customConstraints.isEmpty else { return }

        let views = [
            "stackView": stackView
        ]

        let metrics = [
            "stackViewMargin": Constants.stackViewMargin
        ]

        customConstraints.append(codeTextLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(stackViewMargin)-[stackView]-(stackViewMargin)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(stackViewMargin)-[stackView]-(stackViewMargin)-|", metrics: metrics, views: views))

        NSLayoutConstraint.activate(customConstraints)
    }

    func configCellInfo(country: Country) {
        countryTextLabel.text = country.name + ", "
        regionTextLabel.text = country.region
        capitalTextLabel.text = country.capital
        codeTextLabel.text = country.code
    }
}
