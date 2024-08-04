//
//  Airlines+TableView.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import Foundation
import UIKit
extension AirlinesVC: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getAirlinesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirlineCell.identifier, for: indexPath) as? AirlineCell else {
            return UITableViewCell()
        }
        
        presenter.configure(cell: cell as! AirlineCellView, for: indexPath.row)
                cell.favoriteAction = { [weak self] in
                    self?.presenter.markAsFavorite(at: indexPath.row)
                }
        
        return cell
    }
        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
}
