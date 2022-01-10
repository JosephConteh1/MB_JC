//
//  MovieCell.swift
//  MovieBrowser
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    static let identifier = "MovieCell"

    private var releaseDateLabel: UILabel = UILabel()
    private var titleLabel: UILabel = UILabel()
    private var voteAverageLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        let internalVStackView = UIStackView()
        internalVStackView.axis = .vertical
        internalVStackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        internalVStackView.addArrangedSubview(titleLabel)
        let bufferView1 = UIView()
        bufferView1.translatesAutoresizingMaskIntoConstraints = false
        bufferView1.setContentHuggingPriority(.defaultLow, for: .vertical)
        bufferView1.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        internalVStackView.addArrangedSubview(bufferView1)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        internalVStackView.addArrangedSubview(releaseDateLabel)
        
        let externalHStackView = UIStackView()
        externalHStackView.translatesAutoresizingMaskIntoConstraints = false
        externalHStackView.axis = .horizontal
        externalHStackView.addArrangedSubview(internalVStackView)
        let bufferView2 = UIView()
        bufferView2.translatesAutoresizingMaskIntoConstraints = false
        bufferView2.setContentHuggingPriority(.defaultLow, for: .horizontal)
        bufferView2.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        externalHStackView.addArrangedSubview(bufferView2)
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        voteAverageLabel.textAlignment = .left
        externalHStackView.addArrangedSubview(voteAverageLabel)
        
        externalHStackView.pin(contentView)
        
        accessoryType = .disclosureIndicator
        contentView.backgroundColor = .white
    }
    
    
    func configure(title: String?, releaseDate: String?, voteAverage: Double?) {
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        voteAverageLabel.text =  nil
        if let voteAverage = voteAverage {
            voteAverageLabel.text =  "\(voteAverage)"
            
        }
    }
    
}
