//
//  BankExchangesViewController.swift
//  EchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class BankExchangesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = BankExchangesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ExchangeRatesSegue" {
            if let s = sender as? BankExchangeCell {
                if let ratesVC = segue.destination as? ExchangeRatesViewController {
                    
                    ratesVC.viewModel.fromId = s.fromId
                    ratesVC.viewModel.toId = s.toId
                    ratesVC.viewModel.bankMap = s.bankMap
                    ratesVC.viewModel.currencyCodeMap = s.currencyCodeMap
                }
            }
        }
    }
    
    fileprivate func reloadData() {
        self.tableView.isHidden = true
        viewModel.getAllData {
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        }
    }
}
