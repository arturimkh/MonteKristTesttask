//
//  UIImageView.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 08.08.2023.
//

import Foundation
import UIKit
import Kingfisher
extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}
