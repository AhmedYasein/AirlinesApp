import UIKit

// MARK: - AirlineCell

/// A table view cell used to display an airline's information.
class AirlineCell: UITableViewCell, AirlineCellView {

    // MARK: - Properties

    /// Closure to handle the favorite button tap action.
    var favoriteAction: (() -> Void)?
    
    // MARK: - Static Properties

    /// Reuse identifier for the cell.
    static let identifier = "AirlineCell"

    // MARK: - UI Components

    /// Label to display the airline name.
    private let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    /// Image view to display the airline logo.
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()

    /// Button to toggle the favorite status of the airline.
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers

    /// Initializes the cell with the specified style and reuse identifier.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews() // Set up the views
        setupAppearance() // Apply appearance settings
    }

    /// Required initializer for decoding from a storyboard or XIB.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    /// Configures the cell to display the airline's name.
    func displayName(name: String) {
        customLabel.text = name
    }

    /// Configures the cell to display the airline's logo.
    func displaylogo(logo: String) {
        customImageView.loadImage(from: logo)
    }

    /// Updates the favorite button's appearance based on the favorite status.
    func setFavorite(isFavorite: Bool) {
        DispatchQueue.main.async {
            let favoriteImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
            self.favoriteButton.setImage(favoriteImage, for: .normal)
            self.favoriteButton.tintColor = isFavorite ? .systemPink : .systemGray
        }
    }

    /// Action method triggered when the favorite button is tapped.
    @objc private func favoriteButtonTapped() {
        favoriteAction?() // Invoke the favorite action closure
    }

    // MARK: - Private Methods

    /// Sets up the views and their constraints.
    private func setupViews() {
        contentView.addSubview(customImageView)
        contentView.addSubview(customLabel)
        contentView.addSubview(favoriteButton)

        NSLayoutConstraint.activate([
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            customImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customImageView.widthAnchor.constraint(equalToConstant: 70),
            customImageView.heightAnchor.constraint(equalToConstant: 70),
            
            customLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 15),
            customLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    /// Applies appearance settings to the cell.
    private func setupAppearance() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4
        contentView.layer.masksToBounds = false
    }


}
