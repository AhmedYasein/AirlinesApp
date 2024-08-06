import UIKit

// MARK: - Protocol

/// Defines actions that can be performed in the AirlineDetailVC.
protocol AirlineDetailActionHandler {
    func openWebsite()
    func callAirline()
    func toggleFavorite()
}

// MARK: - View Controller

/// Displays detailed information about an airline, including options to visit their website, call them, and mark them as a favorite.
class AirlineDetailVC: UIViewController, AirlineDetailView {

    var presenter: AirlineDetailActionHandler?
    var airline: Airline?
    
    // MARK: - UI Components
    
    /// Image view to display the airline's logo.
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 12
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowOpacity = 0.1
        imageView.layer.shadowRadius = 4
        return imageView
    }()
    
    /// Label to display the name of the airline.
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    /// Button to open the airline's website.
    private let websiteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.systemBlue
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.addTarget(self, action: #selector(websiteTapped), for: .touchUpInside)
        let title = NSMutableAttributedString(string: "Visit Website")
        title.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, title.length))
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    /// Button to initiate a call to the airline.
    private let phoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.systemGreen
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.addTarget(self, action: #selector(callAirline), for: .touchUpInside)
        return button
    }()
    
    /// Label shown when no phone number is available for the airline.
    private let noPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No phone number available"
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.isHidden = true
        return label
    }()
    
    /// Button to mark the airline as a favorite or remove it from favorites.
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor.systemGray5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 4
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupViews()
        setupConstraints()
        configureView()
        setupNavigationBar()
    }
    
    // MARK: - Setup Methods
    
    /// Adds UI components to the view hierarchy.
    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(websiteButton)
        view.addSubview(phoneButton)
        view.addSubview(noPhoneNumberLabel)
        view.addSubview(favoriteButton)
    }
    
    /// Configures Auto Layout constraints for UI components.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 140),
            logoImageView.heightAnchor.constraint(equalToConstant: 140),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 25),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            websiteButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 25),
            websiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            websiteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            phoneButton.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: 20),
            phoneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            noPhoneNumberLabel.topAnchor.constraint(equalTo: websiteButton.bottomAnchor, constant: 20),
            noPhoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            noPhoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            favoriteButton.topAnchor.constraint(equalTo: phoneButton.isHidden ? noPhoneNumberLabel.bottomAnchor : phoneButton.bottomAnchor, constant: 20),
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    /// Configures the view with data from the `airline` property.
    private func configureView() {
        guard let airline = airline else { return }
        logoImageView.loadImage(from: "https://www.kayak.com/" + (airline.logoURL ?? "No image") )
        nameLabel.text = airline.name
        websiteButton.setTitle(airline.site, for: .normal)

        if let phoneNumber = airline.phone, !phoneNumber.isEmpty {
            phoneButton.setTitle(phoneNumber, for: .normal)
            phoneButton.isHidden = false
            noPhoneNumberLabel.isHidden = true
        } else {
            phoneButton.isHidden = true
            noPhoneNumberLabel.isHidden = false
        }

        let favoriteImage = airline.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
    }
    
    // MARK: - Actions
    
    /// Handles the tap event for the website button.
    @objc private func websiteTapped() {
        presenter?.openWebsite()
    }
    
    /// Handles the tap event for the call button.
    @objc private func callAirline() {
        presenter?.callAirline()
    }
    
    /// Handles the tap event for the favorite button.
    @objc private func toggleFavorite() {
        presenter?.toggleFavorite()
        if let updatedAirline = airline {
            NotificationCenter.default.post(name: .airlineDidUpdate, object: updatedAirline)
        }
    }
    
    /// Configures the navigation bar with the title and appearance.
    private func setupNavigationBar() {
        navigationItem.title = "Airline Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    }

    /// Updates the appearance of the favorite button based on the `isFavorite` status.
    func updateFavoriteButton(isFavorite: Bool) {
        let favoriteImage = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: favoriteImage), for: .normal)
    }
}
