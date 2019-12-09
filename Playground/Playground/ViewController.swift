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
  var appleTap = false
  var chooseURL : URL {
    if appleTap {
      return URL(string: "https://www.apple.com")!
    } else {
      return URL(string:"http://192.168.1.125:8888/untitled/TestUniversalLink.php#")!
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func appleTaped(_ sender: Any) {
    appleTap = true
    let myRequest = URLRequest(url: chooseURL)
    webView.load(myRequest)
  }
  
  @IBAction func mySiteTapped(_ sender: Any) {
    appleTap = false
    let myRequest = URLRequest(url: chooseURL)
    webView.load(myRequest)
  }
  
  @IBAction func goNavigation(_ sender: Any) {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "NewPage", bundle: bundle)
    navigationController?.pushViewController(storyboard.instantiateInitialViewController()!, animated: true)
  }
}


