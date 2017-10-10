//
//  PTKRequestManager.swift
//  PetAdoption-iOS
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

private let PTKSharedInstance = PTKRequestManager()
private let PTKBaseURL = "https://pet-adoption-server.herokuapp.com/api/v2/"

private let PTKGetSpecies = "\(PTKBaseURL)species"
private let PTKGetPets = "\(PTKGetSpecies)/all/animals/list"

public typealias PTKRequestSpeciesComplete = (_ species: [PTKSpecieType]?, _ error: NSError?) -> Void
public typealias PTKRequestPetsComplete = (_ pets: [PTKPet]?, _ error: NSError?) -> Void
public typealias PTKRequestImageComplete = (_ image: UIImage?, _ error: NSError?) -> Void

public class PTKRequestManager: NSObject {

    let imageCache = AutoPurgingImageCache()
    
    public class func sharedInstance() -> PTKRequestManager {
        return PTKSharedInstance
    }
    
    //******************************************************************************************************************
    // MARK: - Public Functions
    
    /*
     JSON Example
     [
        [
            "species":"dog",
            "age":"10+ years"
            "latitude":[
                10.0000
            ]
             "longitude":[
                10.0000
             ]
        ]
     ]
     */
    public func request(AllPetsWithcompletion complete: @escaping PTKRequestPetsComplete) {
        Alamofire.request(PTKGetPets).responseJSON { (response) in
            if response.result.isSuccess {
                guard let json = response.result.value as? [[String: AnyObject]] else {
                    let error = NSError(domain: "com.petadoption.petadoptiontransportkit.requestallpets", code: 1, userInfo: ["JSON":"Malformed JSON response"])
                    complete(nil, error)
                    return
                }
                
                var pets = [PTKPet]()
                
                for entry in json {
                    pets.append(PTKPet(json: entry))
                }
                
                complete(pets, nil)
                
            } else {
                complete(nil, response.result.error as NSError?)
            }
        }
    }
    
    
    /*
     JSON Example
     [
        "dog",
        "cat"
     ]
     */
    public func request(specieTypesWithCompletion complete: @escaping PTKRequestSpeciesComplete) {
        Alamofire.request(PTKGetSpecies).responseJSON { (response) in
            if let species = response.result.value as? [String], response.result.isSuccess {
                let types = species.map { PTKSpecieType(type: $0) }
                complete(types, response.result.error as NSError?)
            } else {
                complete(nil, response.result.error as NSError?)
            }
        }
    }
    
    public func request(imageAtPath aPath: String, completion complete: @escaping PTKRequestImageComplete) -> Request? {
        
        if let cachedImage = self.imageCache.image(withIdentifier: aPath) {
            complete(cachedImage, nil)
            return nil
        } else {
            return Alamofire.request(aPath).responseImage { (response) in
                if response.result.isSuccess {
                    guard let image = response.result.value else {
                        let error = NSError(domain: "com.petadoption.petadoptiontransportkit.requestimage", code: 2, userInfo: ["Data":"response was a success, but data is missing", "url":aPath])
                        complete(nil, error)
                        return
                    }
                    
                    self.imageCache.add(image, withIdentifier: aPath)
                    complete(image, response.result.error as NSError?)
                } else {
                    complete(nil, response.result.error as NSError?)
                }
            }
            
        }
    }
}
