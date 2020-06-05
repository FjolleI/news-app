//
//  NewsCell.swift
//  iOSTraining
//
//  Created by Admin on 31.05.20.
//  Copyright © 2020 Fjolle. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    
    func configureCell( newsTitle: String, newsSource: String) {
     
        self.newsTitle.text = newsTitle
        self.newsSource.text = newsSource
    }
}
