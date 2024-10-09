//
//  UIImageView+Extensions.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/10/24.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: URL, completion: ((Error?) -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?(nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion?(NSError(domain: "ImageViewErrorDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode image data"]))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion?(error)
                }
            }
        }
    }
}
