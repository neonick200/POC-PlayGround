//
//  iCarouselViewController.swift
//  Playground
//
//  Created by Tnk. on 6/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit
import Foundation

class iCarouselViewController: UIViewController {
  
  @IBOutlet open var carousel: iCarousel!
  @IBOutlet open var pageControl: UIPageControl!
  
  let testText: [String] = ["Test1","Test2","Test3","Test4","Test5","Test6","Test7","Test8","Test9","Test10"]
  let testImage: [UIImage] = [UIImage(named: "1.png")!,UIImage(named: "2.jpeg")!,UIImage(named: "3.jpeg")!,UIImage(named: "4.jpg")!,UIImage(named: "5.jpg")!,UIImage(named: "6.jpg")!,UIImage(named: "7.jpg")!,UIImage(named: "8.jpg")!,UIImage(named: "9.jpg")!,UIImage(named: "10.jpeg")!]
  var timer: Timer?
  
  override open func viewDidLoad() {
    super.viewDidLoad()
    setupCarousel()
    startTimer()
  }
  
  func setupCarousel() {
    carousel.type = .linear
    carousel.delegate = self
    carousel.dataSource = self
    carousel.isAccessibilityElement = false
    if testImage.count > 10 {
      pageControl.isHidden = true
    } else {
      pageControl.numberOfPages = testImage.count
    }
    carousel.scrollToItem(at: 0, animated: false)
  }
  
  @objc fileprivate func startTimer() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
  }
  
  @objc fileprivate func fireTimer() {
    carousel.scroll(byNumberOfItems: 1, duration: 1.0)
  }
}

extension iCarouselViewController: iCarouselDelegate {
  
  func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
    pageControl.currentPage = Int(carousel.currentItemIndex)
  }
  
  func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
    let alert = UIAlertController(title: testText[index], message: "😔", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }
}

extension iCarouselViewController: iCarouselDataSource {
  
  func numberOfItems(in carousel: iCarousel) -> Int {
    return testImage.count
  }
  
  func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
    switch option {
    case .spacing:
      return value * 1.045
    case .wrap:
      return 1
    default :
      return value
    }
  }
  
  func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
    let nib = UINib(nibName: "Card", bundle: nil)
    let view = nib.instantiate(withOwner: nil, options: nil).first as! CardView
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = 7
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowOpacity = 0.25
    view.layer.shadowRadius = 1
    view.updateUI(with: CardviewModel(text: testText[index], image: testImage[index]))
    return view
  }
}
