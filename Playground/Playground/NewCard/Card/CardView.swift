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
  
  func updateUI(with data: CardviewModel) {
    heroImageView.layer.cornerRadius = 7
    textLabel.text = data.text
    heroImageView.image = data.image
  }
}
