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
private let PTKBaseURL = "http://cfo-pet-adoption-server.eastus.cloudapp.azure.com/api/v2/"

private let PTKGetSpecies = "\(PTKBaseURL)species"
private let PTKGetPets = "\(PTKBaseURL)list"

public typealias PTKRequestSpeciesComplete = (species: [PTKSpecieType]?, error: NSError?) -> Void
public typealias PTKRequestPetsComplete = (pets: [PTKPet]?, error: NSError?) -> Void
public typealias PTKRequestImageComplete = (image: UIImage?, error: NSError?) -> Void

public class PTKRequestManager: NSObject {
    
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
    public func request(AllPetsWithcompletion complete: PTKRequestPetsComplete) {
        Alamofire.request(.GET, PTKGetPets).responseJSON { (response: Response<AnyObject, NSError>) in
            if response.result.isSuccess {
                guard let json = response.result.value as? [[String: AnyObject]] else {
                    let error = NSError(domain: "com.petadoption.petadoptiontransportkit.requestallpets", code: 1, userInfo: ["JSON":"Malformed JSON response"])
                    complete(pets: nil, error: error)
                    return
                }
                
                var pets = [PTKPet]()
                
                for entry in json {
                    pets.append(PTKPet(json: entry))
                }
                
                complete(pets: pets, error: nil)
                
            } else {
                complete(pets: nil, error: response.result.error)
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
    public func request(specieTypesWithCompletion complete: PTKRequestSpeciesComplete) {
        Alamofire.request(.GET, PTKGetSpecies).responseJSON { (response: Response<AnyObject, NSError>) in
            if let species = response.result.value as? [String] where response.result.isSuccess {
                let types = species.map { PTKSpecieType(type: $0) }
                complete(species: types, error: response.result.error)
            } else {
                complete(species: nil, error: response.result.error)
            }
        }
    }
    
    public func request(imageAtPath aPath: String, completion complete: PTKRequestImageComplete) -> Request {
        return Alamofire.request(.GET, aPath).responseImage { (response: Response<Image, NSError>) in
            if response.result.isSuccess {
                guard let image = response.result.value else {
                    let error = NSError(domain: "com.petadoption.petadoptiontransportkit.requestimage", code: 2, userInfo: ["Data":"response was a success, but data is missing", "url":aPath])
                    complete(image: nil, error: error)
                    return
                }
                
                complete(image: image, error: response.result.error)
            } else {
                complete(image: nil, error: response.result.error)
            }
        }
    }
    
}
