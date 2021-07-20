//
//  UIImageViewExtension.swift
//  ClientVK
//
//  Created by Denis Molkov on 04.07.2021.
//

import UIKit

extension UIImageView {
    
    func loadImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            return
        }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let imageData = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageData)
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data,
                      let response = response else { return }
                
                let cacheResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cacheResponse, for: request)
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
