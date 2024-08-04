//
//  sd_webImage.swift
//  airlinesApp
//
//  Created by Ahmed Yasein on 01/08/2024.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(from urlString: String, placeholder: UIImage? = UIImage(named: "placeholder.png"), completion: ((UIImage?, Error?) -> Void)? = nil) {
        // Validate the URL
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion?(nil, NSError(domain: "InvalidURL", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL: \(urlString)"]))
            return
        }
        
        // Start loading the image with SDWebImage
        self.sd_setImage(with: url, placeholderImage: placeholder) { [weak self] image, error, _, _ in
            // Call the completion handler on the main thread
            DispatchQueue.main.async {
                if let error = error {
                    print("Image loading failed: \(error.localizedDescription)")
                    completion?(nil, error)
                } else {
                    completion?(image, nil)
                }
            }
        }
    }
}
