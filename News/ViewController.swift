//
//  ViewController.swift
//  News
//
//  Created by 李超逸 on 2018/02/23.
//  Copyright © 2018 李超逸. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    
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
            .responseData(completionHandler: { responseData in
                let decoder = JSONDecoder()
                if let data = responseData.data {
                    do {
                        let result = try decoder.decode(NewsResponse.self, from: data)
                    } catch {
                        // json decode error
                    }
                    
                } else {
                    // no data response
                }
            })
    }
}

