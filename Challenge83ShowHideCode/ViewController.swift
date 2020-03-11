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
            hideView.leadingAnchor.constraint(equalTo: codeStackView.leadingAnchor),
            hideView.topAnchor.constraint(equalTo: codeStackView.topAnchor),
            hideView.trailingAnchor.constraint(equalTo: codeStackView.trailingAnchor),
            hideView.bottomAnchor.constraint(equalTo: codeStackView.bottomAnchor)
        ])
    }
    
    @objc func showCode() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.25, delay: 0, options: [], animations: {
            self.hideView.alpha = self.codeSwitch.isOn ? 0 : 1
        }, completion: nil)
    }
    
    private let hideView: UIView = {
        let hv = UIView()
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.backgroundColor = .yellow
        return hv
    }()

    private let codeOne = UILabel.customLabel(text: String(ViewMetrics.code.prefix(2)), backgroundColor: .yellow, font: .systemFont(ofSize: ViewMetrics.fontSize))
    private let blockTwo = ViewMetrics.code.index(ViewMetrics.code.startIndex, offsetBy: 2)..<ViewMetrics.code.index(ViewMetrics.code.endIndex, offsetBy: -2)
    private let codeTwo = UILabel.customLabel(
        text: String(ViewMetrics.code[ViewMetrics.code.index(ViewMetrics.code.startIndex, offsetBy: 2)..<ViewMetrics.code.index(ViewMetrics.code.endIndex, offsetBy: -2)]),
        backgroundColor: .yellow,
        font: .systemFont(ofSize: ViewMetrics.fontSize))
    private let codeThree = UILabel.customLabel(text: String(ViewMetrics.code.suffix(2)), backgroundColor: .yellow, font: .systemFont(ofSize: ViewMetrics.fontSize))
    
    private lazy var codeStackView: UIStackView = {
        let csv = UIStackView(arrangedSubviews: [codeOne, codeTwo, codeThree])
        csv.distribution = .fillEqually
        csv.spacing = ViewMetrics.spacing
        csv.insertSubview(hideView, aboveSubview: codeThree)
        return csv
    }()
    
    private let codeSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.addTarget(self, action: #selector(showCode), for: .valueChanged)
        return sw
    }()
    
    private lazy var rootStackView: UIStackView = {
        let csv = UIStackView(arrangedSubviews: [codeSwitch, codeStackView])
        csv.translatesAutoresizingMaskIntoConstraints = false
        csv.isLayoutMarginsRelativeArrangement = true
        csv.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.spacing, leading: ViewMetrics.spacing, bottom: ViewMetrics.spacing, trailing: ViewMetrics.spacing)
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
