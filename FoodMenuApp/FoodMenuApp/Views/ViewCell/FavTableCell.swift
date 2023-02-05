//
//  FavTableCell.swift
//  FoodMenuApp
//
//

import Foundation
import Kingfisher

class FavTableCell: UITableViewCell {
    static let reuseableId:String = "FavTableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: FavTableCell.reuseableId)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
    let foodImage : UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerCurve = .continuous
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        lb.scaleFont()
        return lb
    }()
    
    let detailContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5.0
        sv.alignment = .leading
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .systemGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 14)
        lb.alpha = 0.8
        lb.scaleFont()
        return lb
    }()
    
    let retryContainer: UIView = {
       let rc = UIView()
        rc.backgroundColor = .white
        rc.translatesAutoresizingMaskIntoConstraints = false
        rc.layer.cornerRadius = 60/2
        return rc
    }()
    
    let retryIcon : UIImageView = {
        var iv = UIImageView()
        let img = UIImage(systemName: "multiply.circle.fill")?.withRenderingMode(.alwaysOriginal)
        iv.image = img
        iv.tintColor = .black
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    func setupViews() {
        [foodImage,detailContainer,retryContainer,descriptionLabel].forEach {
            contentView.addSubview($0)
        }
        [titleLabel].forEach { item in
            detailContainer.addArrangedSubview(item)
        }
        retryContainer.addSubview(retryIcon)
    }
    
    func setupConstraints(){
       
        NSLayoutConstraint.activate([
            
            foodImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            foodImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImage.widthAnchor.constraint(equalToConstant: 100),
            foodImage.heightAnchor.constraint(equalTo: foodImage.widthAnchor),
            
            
            detailContainer.centerYAnchor.constraint(equalTo: foodImage.centerYAnchor),
            detailContainer.leadingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: 10),
            detailContainer.trailingAnchor.constraint(equalTo: retryContainer.leadingAnchor, constant: -10),
            
            retryContainer.centerYAnchor.constraint(equalTo: foodImage.centerYAnchor),
            retryContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            retryContainer.widthAnchor.constraint(equalToConstant: 60),
            retryContainer.heightAnchor.constraint(equalTo: retryContainer.widthAnchor),

            retryIcon.centerYAnchor.constraint(equalTo: retryContainer.centerYAnchor),
            retryIcon.centerXAnchor.constraint(equalTo: retryContainer.centerXAnchor),
            retryIcon.widthAnchor.constraint(equalToConstant: 20),
            retryIcon.heightAnchor.constraint(equalTo: retryContainer.widthAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: 7),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

                        
        ])
    }
    
    func setData(for item: FoodModel){
        foodImage.kf.setImage(with: URL(string: item.imgURL))
        titleLabel.text = item.name
        descriptionLabel.text = item.description
    }
    

}
