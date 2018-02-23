//
//  ViewController.swift
//  News
//
//  Created by 李超逸 on 2018/02/23.
//  Copyright © 2018 李超逸. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UITableViewController {
    
    var articles = [Article]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func requestNews() {
        let url = URL(string: "https://newsapi.org/v2/top-headlines")!
        
        let parameters: Parameters = [
            "country": "jp",
            "apiKey": "a32fccf9076e41b1ae21b28e40e749fc",
            "pageSize": "20",
            "page": "1"
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
        return cell
    }
}

