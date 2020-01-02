//
//  ListOfDonationViewController.swift
//  Playground
//
//  Created by Tnk. on 18/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit

class ListOfDonationViewController: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableview.delegate = self
    tableview.dataSource = self
  }
}

extension ListOfDonationViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoundationTableViewCell") as? FoundationTableViewCell else {
      return UITableViewCell()
    }
    //    cell.updateUI(viewModel: FoundationTableViewCellModel.ViewModel(image: <#T##UIImage#>, title: <#T##String#>, description: <#T##String#>))
    return cell
  }
}
