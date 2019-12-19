//
//  FoundationTableViewCell.swift
//  Playground
//
//  Created by Tnk. on 7/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit

struct FoundationTableViewCellModel {
  struct ViewModel {
    let image: UIImage
    let title: String
    let description: String
  }
}

class FoundationTableViewCell: UITableViewCell {
  
  @IBOutlet weak var view: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
//  @IBOutlet weak var heroImage: UIImageView!
//  @IBOutlet weak var heroView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    view.layer.masksToBounds = true
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = 7
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowOpacity = 0.25
    view.layer.shadowRadius = 1
//    heroImage.layer.shadowColor = UIColor.black.cgColor

    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func updateUI(viewModel: FoundationTableViewCellModel.ViewModel) {
    titleLabel.text = viewModel.title
    descriptionLabel.text = viewModel.description
//    heroImage.image = viewModel.image
  }
}


extension UIView {
   func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
     let mask = CAShapeLayer()
     mask.path = path.cgPath
     layer.mask = mask
   }
}
