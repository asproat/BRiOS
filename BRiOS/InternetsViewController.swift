//
//  InternetsViewController.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation
import UIKit
import WebKit

class InternetsViewController : UIViewController {
    
    // MARK: - Properties
    
    private let buttonBar = UIView()
    private let backButton = UIButton(type: .custom)
    private let refreshButton = UIButton()
    private let forwardButton = UIButton()
    private let webView = WKWebView()

    // MARK: - Lifecycle
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        setUpButtonBar()
        setUpWebView()
    }
    
    // MARK: - Private
    
    private func setUpButtonBar() {
        guard let myView = view else { return }
        
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        myView.addSubview(buttonBar)
        buttonBar.backgroundColor = UIColor(red: 134.0 / 255.0, green: 231.0 / 255.0 , blue: 169.0 / 255.0, alpha: 1.0)
        buttonBar.autoresizesSubviews = true
        buttonBar.autoresizingMask = .flexibleWidth
        NSLayoutConstraint(item: buttonBar,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: myView,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: buttonBar,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: myView,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: buttonBar,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: myView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: buttonBar,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1.0,
                           constant: 120.0).isActive = true
        setUpBackButton()
        setUpRefreshButton()
        setUpForwardButton()
    }
    
    private func setUpBackButton() {
        
        backButton.setImage(UIImage(named: "ic_webBack"), for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.addSubview(backButton)
        NSLayoutConstraint(item: backButton,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: buttonBar,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -20.0).isActive = true
        NSLayoutConstraint(item: backButton,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: buttonBar,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 20.0).isActive = true
        NSLayoutConstraint(item: backButton,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1.0,
                           constant: 50.0).isActive = true
        NSLayoutConstraint(item: backButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .width,
                           multiplier: 1.0,
                           constant: 50.0).isActive = true
        backButton.addTarget(self, action: #selector(self.backTapped), for: .touchUpInside)
    }
    
    @objc
    private func backTapped(sender: UIButton) {
        webView.goBack()
    }

    private func setUpRefreshButton() {
        
        refreshButton.setImage(UIImage(named: "ic_webRefresh"), for: .normal)
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.addSubview(refreshButton)
        NSLayoutConstraint(item: refreshButton,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: backButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: refreshButton,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: backButton,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 20.0).isActive = true
        NSLayoutConstraint(item: refreshButton,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1.0,
                           constant: 50.0).isActive = true
        NSLayoutConstraint(item: refreshButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .width,
                           multiplier: 1.0,
                           constant: 50.0).isActive = true
        refreshButton.addTarget(self, action: #selector(self.refreshTapped), for: .touchUpInside)
    }
    
    @objc
    private func refreshTapped(sender: UIButton) {
        webView.reloadFromOrigin()
    }

    private func setUpForwardButton() {
        
        forwardButton.setImage(UIImage(named: "ic_webForward"), for: .normal)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.addSubview(forwardButton)
        NSLayoutConstraint(item: forwardButton,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: backButton,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: forwardButton,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: refreshButton,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 20.0).isActive = true
        NSLayoutConstraint(item: forwardButton,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .height,
                           multiplier: 1.0,
                           constant: 50.0).isActive = true
        NSLayoutConstraint(item: forwardButton,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .width,
                           multiplier: 1.0,
                           constant: 50.0).isActive = true
        forwardButton.addTarget(self, action: #selector(self.forwardTapped), for: .touchUpInside)
    }
    
    @objc
    private func forwardTapped(sender: UIButton) {
        webView.goForward()
    }

    private func setUpWebView() {
        guard let myView = view else { return }
        webView.translatesAutoresizingMaskIntoConstraints = false
        myView.addSubview(webView)
        buttonBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        NSLayoutConstraint(item: webView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: buttonBar,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: webView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: myView,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: webView,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: myView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: webView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: myView,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true

        guard let brURL = URL(string: "https://www.bottlerocketstudios.com") else { return }
        webView.load(URLRequest(url: brURL))
    }
}
