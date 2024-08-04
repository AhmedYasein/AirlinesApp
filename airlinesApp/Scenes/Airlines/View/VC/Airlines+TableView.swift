//
//  Airlines+TableView.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import Foundation
import UIKit

// MARK: - AirlinesVC (UITableViewDelegate & UITableViewDataSource)

extension AirlinesVC: UITableViewDelegate, UITableViewDataSource {
    
    /// Configures the table view's delegate and data source.
    func setupTableView() {
        tableView.delegate = self // Sets the view controller as the delegate
        tableView.dataSource = self // Sets the view controller as the data source
    }
    
    /// Returns the number of rows in the table view section.
    /// - Parameter section: The section index (currently unused).
    /// - Returns: The number of rows in the section.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getAirlinesCount() // Provides the number of rows based on the presenter
    }
    
    /// Configures and returns the cell for a particular row.
    /// - Parameters:
    ///   - tableView: The table view requesting the cell.
    ///   - indexPath: The index path of the cell to return.
    /// - Returns: A configured `UITableViewCell` instance.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AirlineCell.identifier, for: indexPath) as? AirlineCell else {
            return UITableViewCell() // Fallback in case of cell dequeuing failure
        }
        
        presenter.configure(cell: cell as! AirlineCellView, for: indexPath.row) // Configures the cell using the presenter
        cell.favoriteAction = { [weak self] in
            self?.presenter.markAsFavorite(at: indexPath.row) // Marks the airline as favorite when the button is tapped
        }
        
        return cell // Returns the configured cell
    }
    
    /// Handles row selection in the table view.
    /// - Parameter indexPath: The index path of the selected row.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row) // Notifies the presenter of the row selection
    }
    
    /// Returns the height for the row at a particular index path.
    /// - Parameter indexPath: The index path of the row for which to return the height.
    /// - Returns: The height of the row.
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Sets a fixed height for rows
    }
}
