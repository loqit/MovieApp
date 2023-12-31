import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "SettingsCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupFrame()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        label.text = nil
        iconImageView.image = nil
        iconContainer.backgroundColor = nil
    }
    
    // MARK: - Public
    
    public func setup(with option: SettingsOption) {
        label.text = option.title
        iconImageView.image = option.icon
        iconContainer.backgroundColor = option.iconBackgroundColor
    }
    
    // MARK: - Private
    
    private func setupCellUI() {
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        
        accessoryType = .disclosureIndicator
    }
    
    private func setupFrame() {
        let containerSize = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15,
                                     y: 6,
                                     width: containerSize,
                                     height: containerSize)
        
        let imageSize = containerSize / 1.5
        iconImageView.frame = CGRect(x: (containerSize - imageSize) / 2,
                                     y: (containerSize - imageSize) / 2,
                                     width: imageSize,
                                     height: imageSize)
        
        let labelWidth = contentView.frame.size.width - 20 - iconContainer.frame.size.width
        let labelHeight = contentView.frame.size.height
        
        label.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: 0,
                             width: labelWidth,
                             height: labelHeight)
    }
}
