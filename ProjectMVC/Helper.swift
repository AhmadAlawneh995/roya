//
//  imageViewByURL.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
extension String {

       func stringToImage(_ handler: @escaping ((UIImage?)->())) {
           if let url = URL(string: self) {
               URLSession.shared.dataTask(with: url) { (data, response, error) in
                   if let data = data {
                       let image = UIImage(data: data)
                       handler(image)
                   }
               }.resume()
           }
       }
   }
extension UIViewController{

func showLoader() {
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

    let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
    loadingIndicator.hidesWhenStopped = true
    if #available(iOS 13.0, *) {
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
    } else {
        // Fallback on earlier versions
    }
    loadingIndicator.startAnimating();

    alert.view.addSubview(loadingIndicator)
    present(alert, animated: true, completion: nil)

}

func dismiss()  {
    dismiss(animated: false, completion: nil)
}


}
