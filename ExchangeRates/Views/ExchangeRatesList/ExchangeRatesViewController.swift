//
//  ExchangeRatesViewController.swift
//  EchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class ExchangeRatesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var refreshControl = UIRefreshControl()
    var viewModel = ExchangeRatesViewModel()
    
    override func viewDidLoad() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        refreshRates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.isHidden = true
    }

    @objc func refresh(_ sender: AnyObject) {
       refreshRates()
    }
    
    fileprivate func refreshRates() {
        viewModel.refreshRates {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}
