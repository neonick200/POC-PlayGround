//
//  UINavigationController.swift
//  Playground
//
//  Created by Tnk. on 3/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit
import Foundation

public enum NavigationControllerBarStyle {
  case none
  case white
  case purple
  case clear
}
 
/* # NavigationControllerBarStyleProtocol for selecting the style of the navigation bar
 ** var navigationStyle of type NavigationControllerBarStyle

 #Styles:
  * none : Hidden navigation bar
  * white : White navigation bar
  * purple: Purple navigation bar
  * clear : Clear navigation bar with no image
 */
public protocol NavigationControllerBarStyleProtocol {
  var navigationStyle: NavigationControllerBarStyle { get }
}

/* # NavigationControllerBarStyleProtocol for customizing the style of the navigation bar
 **func customizeNavigationBar()
 */
public protocol NavigationControllerBarCustomizedProtocol {
  func customizeNavigationBar()
}

open class CustomNavigationController: UINavigationController {
  
  private let barView = UIView()
  
  open override var preferredStatusBarStyle: UIStatusBarStyle {
    if let topVc = topViewController as? NavigationControllerBarStyleProtocol {
      switch topVc.navigationStyle {
      case .purple:
        return .lightContent
      case .white:
        return .default
      case .none, .clear:
        break
      }
    }
    
    if let overriddenStyle = BarStylePlaceholder.overriddenStatusBarStyle {
      return overriddenStyle
    } else if let topVCPreferredStyle = topViewController?.preferredStatusBarStyle {
      return topVCPreferredStyle
    } else {
      return .default
    }
  }
  
  override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)
    if let destinationViewController = viewControllers.last {
      configureStyle(for: destinationViewController)
    }
  }
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    
    // Line under navigationBar
    barView.frame = CGRect(x: 0, y: UINavigationController().navigationBar.frame.height, width: view.frame.width, height: 1.0)
    barView.backgroundColor = #colorLiteral(red: 0.788235, green: 0.776471, blue: 0.803922, alpha: 1.000000)
    navigationBar.addSubview(barView)

//    setupBackButton()
//    setupAccessibility()
  }
  
  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let viewController = topViewController {
      configureStyle(for: viewController)
    }
  }
  
  override open func popViewController(animated: Bool) -> UIViewController? {
    let poppedViewController = super.popViewController(animated: animated)
    if let destinationViewController = topViewController {
      configureStyle(for: destinationViewController)
    }
    return poppedViewController
  }
  
  override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
    super.pushViewController(viewController, animated: animated)
    configureStyle(for: viewController)
  }
  
  override open func popToRootViewController(animated: Bool) -> [UIViewController]? {
    let poppedViewControllers = super.popToRootViewController(animated: animated)
    if let destinationViewController = self.viewControllers.first {
      configureStyle(for: destinationViewController)
    }
    return poppedViewControllers
  }
  
  override open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
    let poppedViewControllers = super.popToViewController(viewController, animated: animated)
    if let destinationViewController = topViewController {
      configureStyle(for: destinationViewController)
    }
    return poppedViewControllers
  }
  
  public func setBottomBarViewHidden(_ hidden: Bool) {
    barView.isHidden = hidden
  }
  
  fileprivate func configureStyle(for viewController: UIViewController) {
    if let givenViewController = viewController as? NavigationControllerBarStyleProtocol {
      let style = givenViewController.navigationStyle
      switch style {
      case .none:
        viewController.navigationController?.setNavigationBarHidden(true, animated: true)
        viewController.automaticallyAdjustsScrollViewInsets = false
      case .purple:
        viewController.navigationController?.purpleNavigationBar()
      case .white:
        viewController.navigationController?.whiteNavigationBar()
      case .clear:
        viewController.navigationController?.clearNavigationBar()
      }
    }
    if let customizedVC = viewController as? NavigationControllerBarCustomizedProtocol {
      customizedVC.customizeNavigationBar()
    }
  }
}

extension CustomNavigationController: UINavigationControllerDelegate {
  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    configureStyle(for: viewController)
  }
}

public extension UINavigationController {
  fileprivate struct BarStylePlaceholder {
    static var overriddenStatusBarStyle: UIStatusBarStyle?
  }
  
  func purpleNavigationBar() {
    BarStylePlaceholder.overriddenStatusBarStyle = .lightContent
    setNavigationBarHidden(false, animated: true)
    navigationBar.barTintColor = #colorLiteral(red: 0.462745098, green: 0.1921568627, blue: 0.7568627451, alpha: 1)
    navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    navigationBar.shadowImage = nil
    navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    navigationBar.isTranslucent = false
    navigationBar.titleTextAttributes = [
//      NSAttributedString.Key.font: FontFamily.DBHeavent.med.font(size: 26),
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    ]
//    setupBackButton()
//    setupAccessibility()
    setNeedsStatusBarAppearanceUpdate()
  }
  
  func whiteNavigationBar() {
    BarStylePlaceholder.overriddenStatusBarStyle = .default
    setNavigationBarHidden(false, animated: true)
    navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    navigationBar.tintColor = #colorLiteral(red: 0.462745098, green: 0.1921568627, blue: 0.7568627451, alpha: 1)
    navigationBar.shadowImage = nil
    navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
    navigationBar.isTranslucent = false
    navigationBar.titleTextAttributes = [
//      NSAttributedString.Key.font: FontFamily.DBHeavent.med.font(size: 26),
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.462745098, green: 0.1921568627, blue: 0.7568627451, alpha: 1)
    ]
//    setupBackButton()
//    setupAccessibility()
    setNeedsStatusBarAppearanceUpdate()
  }
  
  func clearNavigationBar() {
    BarStylePlaceholder.overriddenStatusBarStyle = .lightContent
    setNavigationBarHidden(false, animated: true)
    navigationBar.barTintColor = #colorLiteral(red: 0.462745098, green: 0.1921568627, blue: 0.7568627451, alpha: 1)
    navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    navigationBar.titleTextAttributes = [
//      NSAttributedString.Key.font: FontFamily.DBHeavent.med.font(size: 26),
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    ]
//    setupAccessibility()
    setNeedsStatusBarAppearanceUpdate()
  }
  
//  func setupBackButton() {
//    let bundle = Bundle.main
//    let iconImg = UIImage(named: "Icons_Actions_back", in: bundle, compatibleWith: nil)
//    var backImage = unwrapped(iconImg, with: UIImage())
//
//    let leftPadding: CGFloat = 8
//    let adjustSizeForBetterHorizontalAlignment: CGSize = CGSize(width: backImage.size.width + leftPadding, height: backImage.size.height + 4)
//
//    UIGraphicsBeginImageContextWithOptions(adjustSizeForBetterHorizontalAlignment, false, 0)
//    backImage.draw(at: CGPoint(x: leftPadding, y: 0))
//    backImage = unwrapped(UIGraphicsGetImageFromCurrentImageContext(), with: backImage)
//    UIGraphicsEndImageContext()
//
//    navigationBar.backIndicatorImage = backImage
//    navigationBar.backIndicatorTransitionMaskImage = backImage
//
//    UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 8, vertical: 0), for: .default) // Adjust title
//  }
//
//  func setupAccessibility() {
//    navigationBar.accessibilityIdentifier = "view_navigation_bar"
//    navigationBar.backItem?.accessibilityLabel = "btn_navigation_back"
//
//    for item in navigationBar.subviews {
//      if let navItem = item.subviews.first(where: { unwrapped(($0 as? UILabel)?.text, with: "") == unwrapped(navigationBar.topItem?.title, with: "") }) as? UILabel {
//        navItem.setAccessibilityId(identifier: "txt_navigation_bar_title")
//        return
//      }
//    }
//
//  }
//
//  func setBackButtonTitle(with title: String? = "") {
//    let backButton = UIBarButtonItem()
//    backButton.title = title
//    navigationBar.topItem?.backBarButtonItem = backButton
//  }
//
//  @discardableResult func popToViewController<T: UIViewController>(withType: T.Type, animated: Bool) -> [UIViewController]? {
//    guard let viewController = viewControllers.reversed().first(where: { $0 is T }) else {
//      return nil
//    }
//    return popToViewController(viewController, animated: animated)
//  }
//}
//
}
