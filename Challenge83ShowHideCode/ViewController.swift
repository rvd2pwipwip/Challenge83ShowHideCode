//
//  ViewController.swift
//  Challenge83ShowHideCode
//
//  Created by Herve Desrosiers on 2020-03-11.
//  Copyright © 2020 Herve Desrosiers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private enum ViewMetrics {
        static let fontSize: CGFloat = 40
        static let spacing: CGFloat = 16
        static let code = "1A2BX3Z"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.title = NSLocalizedString("Show Code", comment: "Show Code")
    }
    
    private func setupView() {
        view.addSubview(rootStackView)
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            rootStackView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            rootStackView.topAnchor.constraint(equalTo: margin.topAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
        ])
    }

    private let codeOne = UILabel.customLabel(text: String(ViewMetrics.code.prefix(2)), backgroundColor: .yellow, font: .systemFont(ofSize: ViewMetrics.fontSize))
    private let blockTwo = ViewMetrics.code.index(ViewMetrics.code.startIndex, offsetBy: 2)..<ViewMetrics.code.index(ViewMetrics.code.endIndex, offsetBy: -2)
    private let codeTwo = UILabel.customLabel(
        text: String(ViewMetrics.code[ViewMetrics.code.index(ViewMetrics.code.startIndex, offsetBy: 2)..<ViewMetrics.code.index(ViewMetrics.code.endIndex, offsetBy: -2)]),
        backgroundColor: .yellow,
        font: .systemFont(ofSize: ViewMetrics.fontSize))
    private let codeThree = UILabel.customLabel(text: String(ViewMetrics.code.suffix(2)), backgroundColor: .yellow, font: .systemFont(ofSize: ViewMetrics.fontSize))
    
    private lazy var codeStackView: UIStackView = {
        let csv = UIStackView(arrangedSubviews: [codeOne, codeTwo, codeThree])
        csv.distribution = .equalSpacing
        csv.spacing = ViewMetrics.spacing
        return csv
    }()
    
    private let showSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        return sw
    }()
    
    private lazy var rootStackView: UIStackView = {
        let csv = UIStackView(arrangedSubviews: [showSwitch, codeStackView])
        csv.translatesAutoresizingMaskIntoConstraints = false
        csv.isLayoutMarginsRelativeArrangement = true
        csv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        csv.addBackground(color: .purple)
        csv.axis = .vertical
        csv.alignment = .center
        csv.spacing = ViewMetrics.spacing
        return csv
    }()

}

extension UILabel {
    static func customLabel(text: String, backgroundColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.backgroundColor = backgroundColor
        label.font = font
        label.numberOfLines = 0
        return label
    }
}
