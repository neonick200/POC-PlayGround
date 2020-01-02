//
//  SwipeViewController.swift
//  EasyViewsModule
//
//  Created by Tnk. on 26/12/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

public protocol iSwipeViewDelegate: class {
  func swipeView(_ swipeView: SwipeViewController, didSelectItemAt index: Int)
  func didReloadError(_ swipeView: SwipeViewController)
}

open class SwipeViewController: UIViewController {
  
  @IBOutlet open var swipeView: SwipeView!
  @IBOutlet open var pageControl: UIPageControl!
  weak open var delegate: iSwipeViewDelegate?
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    setupSwipeView()
  }
  
  private func setupSwipeView() {
    swipeView.alignment = .edge
    swipeView.isWrapEnabled = true
    swipeView.isAccessibilityElement = false
  }
}

extension SwipeViewController: SwipeViewDelegate {
  
  open func swipeViewCurrentItemIndexDidChange(_ swipeView: SwipeView!) {
    pageControl.currentPage = Int(swipeView.currentPage)
  }
  
  open func swipeView(_ swipeView: SwipeView!, didSelectItemAt index: Int) {
    if let view = swipeView.itemView(at: index) {
      if view.isUserInteractionEnabled == true {
        delegate?.swipeView(self, didSelectItemAt: index)
      }
    }
  }
}
