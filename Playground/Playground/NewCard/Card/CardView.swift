//
//  CardView.swift
//  Playground
//
//  Created by Tnk. on 6/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit


struct CardviewModel {
  let text: String
  let image: UIImage
  
  init(text: String, image: UIImage) {
    self.text = text
    self.image = image
  }
}

class CardView: UIView {
  @IBOutlet private weak var textLabel: UILabel!
  @IBOutlet private weak var heroImageView: UIImageView!
  @IBOutlet weak var shadowView: UIView!
  @IBOutlet weak var heroView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
    shadowView.layer.shadowOpacity = 0.25
    shadowView.layer.shadowRadius = 1
//    shadowView.layer.cornerRadius = 7
//    shadowView.layer.masksToBounds = false
//    heroView.layer.cornerRadius = 7
//    heroView.layer.masksToBounds = true
  }
  
  func updateUI(with data: CardviewModel) {
    textLabel.text = data.text
    heroImageView.image = data.image
  }
}
