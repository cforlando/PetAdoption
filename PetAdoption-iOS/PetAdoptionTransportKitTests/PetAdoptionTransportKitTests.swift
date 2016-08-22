//
//  PetAdoptionTransportKitTests.swift
//  PetAdoptionTransportKitTests
//
//  Created by Tom Marks on 21/08/2016.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import XCTest
@testable import PetAdoptionTransportKit

class PetAdoptionTransportKitTests: XCTestCase {
    
    var expectationCount = 0 {
        didSet {
            if oldValue > 0 && expectationCount == 0 {
                self.expectation?.fulfill()
            }
        }
    }
    
    var expectation: XCTestExpectation? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.expectation = self.expectationWithDescription("PTK Tests")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPets() {
        self.expectationCount = self.expectationCount + 1
        PTKRequestManager.sharedInstance().request { (pets: [PTKPet]?, error: NSError?) in
            if error != nil {
                XCTFail("Failed to get pets: \(error!.localizedDescription)")
            }
            print("pets: \(pets?.count)")
            self.expectationCount = self.expectationCount - 1
        }
        
        self.waitForExpectationsWithTimeout(10.0) { (error: NSError?) in
            if error != nil {
                XCTFail("Failed to collect pets: \(error?.localizedDescription)")
            }
        }
    }
    
    func testGetPetImage() {
        self.expectationCount = self.expectationCount + 1
        PTKRequestManager.sharedInstance().request { (pets: [PTKPet]?, error: NSError?) in
            if error != nil {
                XCTFail("Failed to get pets: \(error!.localizedDescription)")
            }
            
            guard let firstPet = pets?.first else {
                XCTFail("Failed to get pet image. No pets returned!")
                return
            }
            
            guard let imagePath = firstPet.imageURLPaths.first else {
                XCTFail("Failed to get pet image. No image urls!")
                return
            }
            
            PTKRequestManager.sharedInstance().request(imageAtPath: imagePath, completion: { (image: UIImage?, error: NSError?) in
                
                if error != nil {
                    XCTFail("Failed to get pet image: \(error?.localizedDescription)")
                }
                
                print("image data: \(image)")
                self.expectationCount = self.expectationCount - 1
            })
            
            print("pets: \(pets?.count)")
        }
        
        self.waitForExpectationsWithTimeout(10.0) { (error: NSError?) in
            if error != nil {
                XCTFail("Failed to collect pets: \(error!.localizedDescription)")
            }
        }
    }
    
    func testGetSpecies() {
        self.expectationCount = self.expectationCount + 1
        PTKRequestManager.sharedInstance().request { (species: [PTKSpecieType]?, error: NSError?) in
            if error != nil {
                XCTFail("Failed to collect: \(error?.localizedDescription)")
            }
            
            print("species: \(species)")
            self.expectationCount = self.expectationCount - 1
        }
        
        self.waitForExpectationsWithTimeout(10.0) { (error: NSError?) in
            if error != nil {
                XCTFail("Failed to collect pets: \(error!.localizedDescription)")
            }
        }
    }
    
}
