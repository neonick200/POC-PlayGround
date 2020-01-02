//
//  ViewController.swift
//  Playground
//
//  Created by Tnk. on 26/11/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
  
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var heroImage: UIImageView!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var buttomWebView: NSLayoutConstraint!
  @IBOutlet weak var constraint_WebViewHeight: NSLayoutConstraint!
  @IBOutlet weak var topWebView: NSLayoutConstraint!
  @IBOutlet weak var heroView: UIView!
  
  let myRequest = URLRequest(url: URL(string: "https://www.apple.com")!)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.scrollView.bounces = false
    webView.scrollView.isScrollEnabled = false
    self.webView.navigationDelegate = self
    webView.load(myRequest)
  }
  
  @IBAction func hideOnTapped(_ sender: Any) {
    heroView.isHidden = true
    topWebView.constant = 0
  }
  
  @IBAction func unhideOnTapped(_ sender: Any) {
    heroView.isHidden = false
    topWebView.constant = 129
  }
  
  
}

extension ViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    DispatchQueue.main.async {
      print(self.constraint_WebViewHeight.constant)
      self.constraint_WebViewHeight.constant = webView.scrollView.contentSize.height
      print(self.constraint_WebViewHeight.constant)
    }
  }
}


