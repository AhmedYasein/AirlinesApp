import UIKit

class AirlineCell: UITableViewCell, AirlineCellView {
    
    func displayName(name: String) {
        customLabel.text = name
    }
    
    func displaylogo(logo: String) {
        customImageView.loadImage(from: logo)
    }
    
    func setFavorite(isFavorite: Bool) {
        DispatchQueue.main.async {
            let favoriteImage = UIImage(systemName: isFavorite ? "heart.fill" : "heart")
            self.favoriteButton.setImage(favoriteImage, for: .normal)
            self.favoriteButton.tintColor = isFavorite ? .systemPink : .systemGray
        }
    }
    
    static let identifier = "AirlineCell"
    
    private let customLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var favoriteAction: (() -> Void)?
    
    @objc private func favoriteButtonTapped() {
        favoriteAction?()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
