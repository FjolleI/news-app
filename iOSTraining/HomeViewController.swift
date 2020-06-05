//
//  HomeViewController.swift
//  iOSTraining
//
//  Created by Admin on 30.05.20.
//  Copyright © 2020 Fjolle. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeViewController: UIViewController {

    var username: String?
    
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    
    var titleArray = [String]()
    var newsSourceArray = [String]()
    var imageURLArray = [String]()
    var newsStoryUrlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        lab.textAlignment = .center
//        lab.textColor = .red
        lab.text = "Don't miss these news \(username!)!"
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        self.newsTableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNewsData { (success) in
            if success {
                print("Success")
                self.newsTableView.reloadData()
            } else {
                print("Error")
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return imageURLArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        var titles = String()
        var sources = String()
        
        if titleArray.count > 0 {
            titles = titleArray[indexPath.row ]
        } else {
            titles = ""
        }
        
        if newsSourceArray.count > 0 {
            sources = newsSourceArray[indexPath.row]
        } else {
            sources = ""
        }
        
        if imageURLArray.count > 0 {
            
            cell.newsImage.sd_setImage(with: URL(string: imageURLArray[indexPath.row])) { (image, error, cache, urls) in
                if (error != nil) {
                    cell.newsImage.image = UIImage(named: "newsPlaceholder")
                } else {
                    cell.newsImage.image = image
                }
            }
            
        } else {
            cell.newsImage.image = UIImage(named: "newsPlaceholder")!
        }
        
        cell.newsImage.layer.cornerRadius = 10
        
        cell.configureCell(newsTitle: titles, newsSource: sources)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let urls = newsStoryUrlArray[(indexPath?.row)!]

        let vc = storyboard?.instantiateViewController(withIdentifier: "productDetailsViewContoller")as?ProductDetailsViewController
        vc?.newsUrl = urls
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension HomeViewController {
    
    func getNewsData(complete: @escaping (_ status: Bool) -> ()) {
        
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=a1776fea9f5e4906b290bd5f54dca817", method: .get).responseJSON { (response) in
            
            guard let value = response.result.value else { return }
            
            let json = JSON(value)
            
            for item in json["articles"].arrayValue {
                
                self.titleArray.append(item["title"].stringValue)
                self.newsSourceArray.append(item["source"]["name"].stringValue)
                self.imageURLArray.append(item["urlToImage"].stringValue)
                self.newsStoryUrlArray.append(item["url"].stringValue)
                
            }
            complete(true)
        }
    }
}
