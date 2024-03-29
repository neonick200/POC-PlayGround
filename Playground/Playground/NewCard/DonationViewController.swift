//
//  DonationViewController.swift
//  Playground
//
//  Created by Tnk. on 6/12/2562 BE.
//  Copyright © 2562 Tnk. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textField: UITextField!
  
  var exampleModel: ExampleModel?
  var sectionArray: [[Foundation]] = []
  
  var nameofKey: (String,Int) -> String = {
    switch $0 {
    case "F":
      return "FOUNDATION (\($1))"
    case "H":
      return "HOSPITAL (\($1))"
    case "A":
      return "ACADEMY (\($1))"
    case "R":
      return "RECOMMEND FOUNDATIONS"
    default:
      return ""
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x6631AC)
    setupTableView()
    feed()
  }
  
  func setupTableView() {
    let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 0))
    customView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(UINib(nibName: "FoundationTableViewCell", bundle: nil), forCellReuseIdentifier: "FoundationTableViewCell")
  }
  
  func feed() {
    exampleModel = Utility.loadJsonFrom(filename: "data", for: ExampleModel.self)
    sectionArray = [filterArray(key: "R"),filterArray(key: "F"),filterArray(key: "H"),filterArray(key: "A")]
  }
  
  func filterArray(key: String) -> [Foundation] {
    return (exampleModel?.data.foundation.filter{ $0.key == key})!
  }
}

extension DonationViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

    let myLabel = UILabel()
    myLabel.frame = CGRect(x: 12, y: 16, width: 320, height: 14)
    myLabel.font = UIFont.systemFont(ofSize: 14)
    myLabel.textColor = .lightGray
    myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)

    let headerView = UIView()
    headerView.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
    headerView.addSubview(myLabel)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return .leastNormalMagnitude
  }
}

extension DonationViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionArray.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return nameofKey(sectionArray[section].first!.key, sectionArray[section].count)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionArray[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoundationTableViewCell") else {
      return UITableViewCell()
    }
    return cell
  }
}
