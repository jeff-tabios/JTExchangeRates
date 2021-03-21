//
//  BankExchangesListTableDelegate.swift
//  ExchangeRates
//
//  Created by Jeff Tabios on 3/21/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

extension BankExchangesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.bankExchanges.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.bankExchanges[section].bank
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bankExchanges[section].exchanges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExchangeCell", for: indexPath) as! BankExchangeCell
        
        cell.vm = viewModel
        cell.fromId = viewModel.bankExchanges[indexPath.section].exchanges[indexPath.row].fromId
        cell.toId = viewModel.bankExchanges[indexPath.section].exchanges[indexPath.row].toId
        cell.textLabel?.text = viewModel.bankExchanges[indexPath.section].exchanges[indexPath.row].label
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
}
