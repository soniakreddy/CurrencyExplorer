//
//  DetailsTableViewCell.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/9/24.
//

import Foundation
import UIKit

class DetailsTableViewCell: UITableViewCell {
    private var customConstraints = [NSLayoutConstraint]()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .mustardYellowColor
        label.font = UIFont.systemFont(ofSize: Constants.extraSmallFontSize, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityIdentifier = Constants.titleLabelIdentifier
        return label
    }()

    private lazy var detailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textColor = .white
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.accessibilityIdentifier = Constants.detailLabelIdentifier
        return label
    }()

    private lazy var flagImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "flag.slash"))
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .brightRedColor
        imageView.accessibilityIdentifier = Constants.imageViewIdentifier
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .vertical)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [detailLabel, flagImageView])
        view.accessibilityIdentifier = Constants.horizontalstackViewIdentifier
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, horizontalStackView])
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

        customConstraints.append(flagImageView.widthAnchor.constraint(equalToConstant: Constants.imageSize))
        customConstraints.append(flagImageView.heightAnchor.constraint(equalToConstant: Constants.imageSize))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|-(stackViewMargin)-[stackView]-(stackViewMargin)-|", metrics: metrics, views: views))
        customConstraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|-(stackViewMargin)-[stackView]-(stackViewMargin)-|", metrics: metrics, views: views))

        NSLayoutConstraint.activate(customConstraints)
    }

    func configCellInfo(titleLabelText: String, detailLabelText: String) {
        titleLabel.text = titleLabelText
        detailLabel.text = detailLabelText

        if !detailLabelText.isEmpty && titleLabelText == Constants.flagTitle {
            guard let imageUrl = URL(string: detailLabelText) else { return }
            flagImageView.isHidden = false
            detailLabel.isHidden = true
            flagImageView.load(url: imageUrl)
        }
    }
}
