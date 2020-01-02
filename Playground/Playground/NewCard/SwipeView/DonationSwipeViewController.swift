//
//  DonationSwipeViewController.swift
//  Playground
//
//  Created by Tnk. on 30/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit

class DonationSwipeViewController: SwipeViewController {
  
  let testText: [String] = ["Test1","Test2","Test3","Test4","Test5","Test6","Test7","Test8","Test9","Test10"]
  let testImage: [UIImage] = [UIImage(named: "1.png")!,UIImage(named: "2.jpeg")!,UIImage(named: "3.jpeg")!,UIImage(named: "4.jpg")!,UIImage(named: "5.jpg")!,UIImage(named: "6.jpg")!,UIImage(named: "7.jpg")!,UIImage(named: "8.jpg")!,UIImage(named: "9.jpg")!,UIImage(named: "10.jpeg")!]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    swipeView.delegate = self
    swipeView.dataSource = self
    pageControl.numberOfPages = testImage.count
  }
}

extension DonationSwipeViewController: SwipeViewDataSource {
  func numberOfItems(in swipeView: SwipeView!) -> Int {
    testImage.count
  }
  
  func swipeView(_ swipeView: SwipeView!, viewForItemAt index: Int, reusing view: UIView!) -> UIView! {
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
