//
//  FoundationTableViewCell.swift
//  Playground
//
//  Created by Tnk. on 7/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit

class FoundationTableViewCell: UITableViewCell {
  @IBOutlet weak var view: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = 7
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowOpacity = 0.25
    view.layer.shadowRadius = 1
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
