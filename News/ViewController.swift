//
//  ViewController.swift
//  News
//
//  Created by 李超逸 on 2018/02/23.
//  Copyright © 2018 李超逸. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

class ViewController: UITableViewController {
    
    var articles = [Article]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ニュース"
        
        requestNews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushToDetail" {
            guard let destination = segue.destination as? DetailViewController else { return }
            guard let article = sender as? Article else { return }
            
            destination.urlString = article.url
        }
    }
    
    private func requestNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines")!
        
        let parameters: Parameters = [
            "country": "us",
            "apiKey": "a32fccf9076e41b1ae21b28e40e749fc",
        ]
        Alamofire
            .request(url,
                     method: .get,
                     parameters: parameters)
            .responseData(completionHandler: { [weak self] responseData in
                let decoder = JSONDecoder()
                if let data = responseData.data {
                    do {
                        let result = try decoder.decode(NewsResponse.self, from: data)
                        self?.articles = result.articles
                    } catch {
                        // json decode error
                    }
                    
                } else {
                    // no data response
                }
            })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath) as! ArticleCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.contentLabel.text = article.description
        
        if let urlToImage = article.urlToImage,
            let url = URL(string: urlToImage) {
            cell.myImageView.af_setImage(withURL: url,
                                         placeholderImage: #imageLiteral(resourceName: "placeholder"))
        } else {
            cell.myImageView.image = nil
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        performSegue(withIdentifier: "pushToDetail", sender: article)
    }
}

