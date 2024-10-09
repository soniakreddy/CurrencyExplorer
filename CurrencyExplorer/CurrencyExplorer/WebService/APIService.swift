//
//  APIService.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/10/24.
//

import Foundation

class APIService : NSObject {
    func fetchData(completion: @escaping ([Country]?, Error?) -> Void) {
        guard let url = Constants.url else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }

            do {
                let results = try JSONDecoder().decode([Country].self, from: data)
                completion(results, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
