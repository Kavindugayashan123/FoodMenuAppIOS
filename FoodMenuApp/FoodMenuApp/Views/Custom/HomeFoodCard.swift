//
//  HomeFoodCard.swift
//  FoodMenuApp
//
//

import Foundation
import UIKit

class HeaderView: UICollectionReusableView {
    
    static let reusableId = "HeaderView"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headingLabel: UILabel = {
        let lb = UILabel(frame: .zero)
        lb.font = UIFont.boldSystemFont(ofSize:19)
        lb.textColor = color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.scaleFont()
        return lb
    }()

    func setupViews(){
        addSubview(headingLabel)
    }

    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            headingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            
        ])
    }
}


class FoodDetailsView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let foodTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.scaleFont()
        lb.numberOfLines = 1
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let actualPriceLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.scaleFont()
        lb.font = UIFont.boldSystemFont(ofSize: 16)
        lb.textColor = color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let discountedContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.layer.cornerRadius = 25/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let discountPriceLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.scaleFont()
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let ratingContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    let ratingLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        lb.scaleFont()
        lb.font = UIFont.boldSystemFont(ofSize: 11)
        lb.textColor = color.black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let ratingIcon : UIImageView = {
        var iv = UIImageView(frame:.zero)
        let img = UIImage(systemName: "star.fill")
        iv.image = img
        iv.tintColor = .green
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    func setupViews(){
        [foodTitleLabel,ratingContainer,actualPriceLabel,discountedContainer].forEach {
            addSubview($0)
        }
        discountedContainer.addSubview(discountPriceLabel)
        ratingContainer.addArrangedSubview(ratingIcon)
        ratingContainer.addArrangedSubview(ratingLabel)
    }
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
        
            foodTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            foodTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodTitleLabel.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            
            actualPriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            actualPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            actualPriceLabel.centerYAnchor.constraint(equalTo: discountedContainer.centerYAnchor),
            
            discountedContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            discountedContainer.leadingAnchor.constraint(equalTo: actualPriceLabel.trailingAnchor, constant: 8),
            discountedContainer.heightAnchor.constraint(equalToConstant: 24),
            
            discountPriceLabel.centerYAnchor.constraint(equalTo: discountedContainer.centerYAnchor),
            discountPriceLabel.leadingAnchor.constraint(equalTo: discountedContainer.leadingAnchor, constant: 10),
            discountPriceLabel.trailingAnchor.constraint(equalTo: discountedContainer.trailingAnchor, constant: -10),
            
            ratingContainer.topAnchor.constraint(equalTo: topAnchor),
            ratingContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingContainer.heightAnchor.constraint(equalToConstant: 14),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: ratingContainer.trailingAnchor),

            ratingIcon.centerYAnchor.constraint(equalTo: ratingContainer.centerYAnchor),
            ratingIcon.leadingAnchor.constraint(equalTo: ratingContainer.leadingAnchor),
            
        ])
    }

}

class FoodImageView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: Properties: -
    let foodImage : UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let discountContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let discountPercentLabel: UILabel = {
        let lb = UILabel()
        lb.scaleFont()
        lb.font = UIFont.boldSystemFont(ofSize: 11)
        lb.textColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let durationContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius = 25/2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let durationLabel: UILabel = {
        let lb = UILabel()
        lb.scaleFont()
        lb.font = UIFont.boldSystemFont(ofSize: 12)
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let overlayView: UIView = {
        let v = UIView()
        v.isHidden = true
        v.alpha = 0
        v.backgroundColor = .systemGray6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let closedLabel: UILabel = {
        let lb = UILabel()
        lb.scaleFont()
        lb.isHidden = true
        lb.alpha = 0
        lb.font = UIFont.boldSystemFont(ofSize:14)
        lb.textColor = .white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    func setupViews(){
        addSubview(foodImage)
        [discountContainer,durationContainer,overlayView].forEach {
            foodImage.addSubview($0)
            
        }
        discountContainer.addSubview(discountPercentLabel)
        durationContainer.addSubview(durationLabel)
        overlayView.addSubview(closedLabel)
        
        overlayView.bringSubviewToFront(foodImage)
    }
    
    func setupConstraints(){

        NSLayoutConstraint.activate([
        
            foodImage.topAnchor.constraint(equalTo: topAnchor),
            foodImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodImage.heightAnchor.constraint(equalTo: heightAnchor),
  
            discountContainer.topAnchor.constraint(equalTo: foodImage.topAnchor, constant: 12),
            discountContainer.leadingAnchor.constraint(equalTo: foodImage.leadingAnchor, constant: 12),
            discountContainer.heightAnchor.constraint(equalToConstant: 25),
            
            discountPercentLabel.centerYAnchor.constraint(equalTo: discountContainer.centerYAnchor),
            discountPercentLabel.leadingAnchor.constraint(equalTo: discountContainer.leadingAnchor, constant: 10),
            discountPercentLabel.trailingAnchor.constraint(equalTo: discountContainer.trailingAnchor, constant: -10),
            
            durationContainer.bottomAnchor.constraint(equalTo: foodImage.bottomAnchor, constant: -12),
            durationContainer.trailingAnchor.constraint(equalTo: foodImage.trailingAnchor, constant: -12),
            durationContainer.heightAnchor.constraint(equalToConstant: 25),
            
            durationLabel.centerYAnchor.constraint(equalTo: durationContainer.centerYAnchor),
            durationLabel.leadingAnchor.constraint(equalTo: durationContainer.leadingAnchor, constant: 15),
            durationLabel.trailingAnchor.constraint(equalTo: durationContainer.trailingAnchor, constant: -15),
            
            overlayView.topAnchor.constraint(equalTo: topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlayView.heightAnchor.constraint(equalTo: heightAnchor),
            
            closedLabel.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            closedLabel.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
        ])
    }

}
