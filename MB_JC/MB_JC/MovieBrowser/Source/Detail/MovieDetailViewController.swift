//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Joseph Conteh on 1/4/22.
//  Copyright © 2021 Ebay. All rights reserved.

import UIKit

class MovieDetailViewController: UIViewController {
    
    private(set) var searchViewModel: SearchViewModel?
    
    private var titleLabel: UILabel = UILabel()
    private var overviewLabel: UILabel = UILabel()
    private var imageView: UIImageView = UIImageView()
    private var releaseDateLabel: UILabel = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        configure()
    }
    
    private func setUpUI() {
        let internalHStackView = UIStackView()
        internalHStackView.translatesAutoresizingMaskIntoConstraints = false
        internalHStackView.axis = .horizontal
        internalHStackView.distribution = .fillEqually
        internalHStackView.spacing = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFit
        internalHStackView.addArrangedSubview(imageView)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.numberOfLines = 0
        internalHStackView.addArrangedSubview(overviewLabel)
        
        let externalVStackView = UIStackView()
        externalVStackView.translatesAutoresizingMaskIntoConstraints = false
        externalVStackView.axis = .vertical
        externalVStackView.spacing = 15
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        externalVStackView.addArrangedSubview(titleLabel)
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.font = UIFont.systemFont(ofSize: 16)
        releaseDateLabel.textColor = .lightGray
        externalVStackView.addArrangedSubview(releaseDateLabel)
        externalVStackView.addArrangedSubview(internalHStackView)
        
        externalVStackView.pin(view)
        view.backgroundColor = .white
    }
    
    private func configure() {
        titleLabel.text = searchViewModel?.movieSelected?.originalTitle
        overviewLabel.text = searchViewModel?.movieSelected?.overview
        releaseDateLabel.text = searchViewModel?.movieSelected?.releaseDateMediumStyle
        
        self.imageView.image = nil
        let posterPath = searchViewModel?.movieSelected?.posterPath
        searchViewModel?.download(posterPath: posterPath) { data in
            if let data = data {
                OperationQueue.main.addOperation {  [weak self]  in
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func setSearchViewModel(_ searchViewModel: SearchViewModel) {
        self.searchViewModel = searchViewModel
    }
}
