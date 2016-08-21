//
//  UIImage+Placeholder.swift
//  PetAdoption-iOS
//
//  Created by Keli'i Martin on 8/20/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImage
{
    class func getPlaceholderImage(width width: Int, height: Int, completion: (UIImage? -> Void)) -> Request
    {
        let urlString = "http://placehold.it/\(width)x\(height)"
        return getImage(from: urlString, completion: completion)
    }

    ////////////////////////////////////////////////////////////

    class func getImage(from url: String, completion: (UIImage? -> Void)) -> Request
    {
        return Alamofire.request(.GET, url).responseImage
        { response in
            guard let image = response.result.value else
            {
                return
            }

            completion(image)
        }
    }
}