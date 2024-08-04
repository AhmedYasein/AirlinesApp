import UIKit

// MARK: - AirlinesVC

/// ViewController to display a list of airlines with the option to filter by favorites.
class AirlinesVC: UIViewController, AirlinesView {
    
    // MARK: - Properties
    
    /// The presenter responsible for handling the business logic for this view.
    var presenter: AirlinesPresenter!
    
    // MARK: - UI Components
    
    /// Table view to display the list of airlines.
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AirlineCell.self, forCellReuseIdentifier: AirlineCell.identifier)
        return tableView
    }()
    
    /// Segmented control to toggle between all airlines and favorite airlines.
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All Airlines", "Favorites"])
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.layer.cornerRadius = 10
        control.layer.borderColor = UIColor.systemBlue.cgColor
        control.layer.borderWidth = 2
        control.backgroundColor = .systemGray6
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ], for: .normal)
        control.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ], for: .selected)
        
        // Customize appearance for selected segment
        control.selectedSegmentTintColor = .systemBlue
        control.layer.borderColor = UIColor.clear.cgColor
        control.layer.borderWidth = 0
        
        control.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return control
    }()
    
    // MARK: - Initializers
    
    /// Sets up the constraints for the UI components.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40), // Set the height to make it look more professional
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    
    /// Handles changes in the segmented control selection.
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        presenter.toggleAirlineList(isFavorites: sender.selectedSegmentIndex == 1)
    }
    
    // MARK: - View Lifecycle
    
    /// Called after the view has been loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        setupConstraints()
        setupTableView() // Sets up the table view (implementation assumed to be in the class)
        presenter = AirlinesPresenter(view: self) // Initializes the presenter
        presenter.viewDidLoad() // Triggers data loading
        NotificationCenter.default.addObserver(self, selector: #selector(handleAirlineUpdate(_:)), name: .airlineDidUpdate, object: nil) // Observes for airline update notifications
    }
    
    /// Handles updates to the airline data received via notifications.
    @objc private func handleAirlineUpdate(_ notification: Notification) {
        guard let updatedAirline = notification.object as? Airline else { return }
        presenter.updateAirline(updatedAirline) // Update the airline in the presenter
    }
    
    // MARK: - AirlinesView
    
    /// Updates the cell at the specified index in the table view.
    func updateCell(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic) // Reload the specific row
        DispatchQueue.main.async {
            self.tableView.reloadData() // Reload the entire table view
        }
    }
}
