//
//  SearchViewController.swift
//  PetAdoption-iOS
//
//  Created by Marco Ledesma on 2/13/16.
//  Copyright © 2016 Code For Orlando. All rights reserved.
//

import UIKit

import XLForm
import MBProgressHUD

class SearchViewController: XLFormViewController {
/*
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let clearButton = UIBarButtonItem(title: "Clear", style: .Plain, target: self, action: #selector(SearchViewController.clearSearch))
        clearButton.tintColor = UIColor.whiteColor()
		self.navigationItem.leftBarButtonItem = clearButton
		
		let searchButton = UIBarButtonItem(title: "Search", style: .Plain, target: self, action: #selector(SearchViewController.searchPets))
        searchButton.tintColor = UIColor.whiteColor()
		self.navigationItem.rightBarButtonItem = searchButton
		
		let searchForm = buildSearchForm()
		self.form = searchForm;
	}
	
	func clearSearch() {
		// cheap and dirty clear - just create a new form
		let searchForm = buildSearchForm()
		self.form = searchForm;
	}
	
	func searchPets() {
		_ = self.form.formValues()
		self.navigationItem.leftBarButtonItem!.enabled = false
		self.navigationItem.rightBarButtonItem!.enabled = false
		let progressHud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
		progressHud.mode = .Indeterminate;
		progressHud.labelText = "Searching for pets";
		
		let searchService = SearchForPetService();
		let request = SearchForPetRequest();
		
		searchService.executeWithRequest(request) { (result) -> Void in
			if (result.code == .Success) {
				
			}
			else {
				//TODO: Handle error result
			}
		}
	}
	
	func successFindingPets(findPetsResult: FindPetsResult) {
		if findPetsResult.petsFound.isEmpty {
			self.presentNoResults()
		} else {
			let storyboard = UIStoryboard(name: "PetListings", bundle: nil)
			let petListingViewController = storyboard.instantiateViewControllerWithIdentifier("PetListingViewController") as! PetListingViewController
			//petListingViewController.petData = findPetsResult.petsFound
			let plural = (findPetsResult.petsFound.count != 1 ? "s" : "")
			petListingViewController.viewControllerTitle = "\(findPetsResult.petsFound.count) pet\(plural)"
			self.navigationController?.pushViewController(petListingViewController, animated: true)
		}
	}
	
	func errorFindingPets() {
		let alert = UIAlertController(title: "Error searching pets", message: "Error details go here", preferredStyle: .Alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	func presentNoResults() {
		let alert = UIAlertController(title: "No pets found", message: nil, preferredStyle: .Alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	func buildSearchForm() -> XLFormDescriptor {
		var form : XLFormDescriptor
		var section : XLFormSectionDescriptor
		var row : XLFormRowDescriptor
		
		form = XLFormDescriptor(title: "Search") as XLFormDescriptor
		
		section = XLFormSectionDescriptor.formSectionWithTitle("Choose search fields") as XLFormSectionDescriptor
		form.addFormSection(section)
		
		row = XLFormRowDescriptor(tag: Pet.Tag.petSpecies, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl, title:"Species")
		row.selectorOptions = PetFilters.species
        row.cellConfigAtConfigure["backgroundColor"] = UIColor.clearColor()
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
        row.cellConfig["segmentedControl.tintColor"] = UIColor.whiteColor()
		section.addFormRow(row)
		
		row = XLFormRowDescriptor(tag: Pet.Tag.petBreed, rowType: XLFormRowDescriptorTypeText, title: "Breed")
        row.cellConfigAtConfigure["backgroundColor"] = UIColor.clearColor()
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
		section.addFormRow(row)
		
		row = XLFormRowDescriptor(tag: Pet.Tag.petSize, rowType: XLFormRowDescriptorTypeSelectorSegmentedControl, title: "Size")
		row.selectorOptions = PetFilters.sizes
        row.cellConfigAtConfigure["backgroundColor"] = UIColor.clearColor()
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
        row.cellConfig["segmentedControl.tintColor"] = UIColor.whiteColor()
		section.addFormRow(row)
		
		row = XLFormRowDescriptor(tag: Pet.Tag.petDateOfArrival, rowType: XLFormRowDescriptorTypeDateTimeInline, title: "Arrival")
        row.cellConfigAtConfigure["backgroundColor"] = UIColor.clearColor()
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
		section.addFormRow(row)
		
		row = XLFormRowDescriptor(tag: Pet.Tag.distanceFromShelter, rowType: XLFormRowDescriptorTypeDecimal, title: "Max distance")
        row.cellConfigAtConfigure["backgroundColor"] = UIColor.clearColor()
        row.cellConfig["textLabel.textColor"] = UIColor.whiteColor()
		section.addFormRow(row)
		
		return form
	}
	
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
*/	
}

