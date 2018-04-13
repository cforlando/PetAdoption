//
//  filterViewControlelr.swift
//  PetAdoption-iOS
//
//  Created by Amir Fleminger on 4/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import UIKit
class filterViewController: UITableViewController {
    var delegate: FilterSelectorDelegate?
    
    enum RowIndex:Int {
        case All = 0, Dogs, Cats, Birds, SmallFurry, Horses, BarnYard, Reptiles
    }
    
    var selectedAnimalTypes: Set<String> = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Adding a footer removes redundant cell dividers from the tableview
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadAnimalTypesSelected()
        setAnimalTypeCheckmarks()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveAnimalTypesSelected()
    }
    
    func loadAnimalTypesSelected(){
        let defaults = UserDefaults.standard
        
        selectedAnimalTypes = defaults.object(forKey: "selectedAnimalTypes") as? Set<String> ?? ["all"]
        
        guard let data:Data = defaults.object(forKey: "selectedAnimalTypes") as? Data else {
            print("Couldnt load animal type preferences!")
            return
        }
        selectedAnimalTypes = NSKeyedUnarchiver.unarchiveObject(with: data) as! Set<String>
    }
    
    func saveAnimalTypesSelected(){
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: selectedAnimalTypes)
        defaults.set(encodedData, forKey: "selectedAnimalTypes")
        defaults.synchronize()
    }
    
    func setAnimalTypeCheckmarks() {
        let section = 0
        for row in 0...self.tableView.numberOfRows(inSection: section) - 1{
            let indexPath = IndexPath(row: row, section: section)
            let cell =  tableView.cellForRow(at: indexPath)
            
            if selectedAnimalTypes.contains("all"){
                // put a checkmark only on the 'All' cell
                cell?.accessoryType = (indexPath.row == RowIndex.All.rawValue) ? .checkmark : .none
            } else {
                switch indexPath.row{
                case RowIndex.Dogs.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("dogs") ? .checkmark : .none
                case RowIndex.Cats.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("cats") ? .checkmark : .none
                case RowIndex.Birds.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("birds") ? .checkmark : .none
                case RowIndex.SmallFurry.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("smallFurry") ? .checkmark : .none
                case RowIndex.SmallFurry.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("smallFurry") ? .checkmark : .none
                case RowIndex.Horses.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("horses") ? .checkmark : .none
                case RowIndex.BarnYard.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("barnYard") ? .checkmark : .none
                case RowIndex.Reptiles.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("reptiles") ? .checkmark : .none
                default:
                    cell?.accessoryType = .none
                }
                
            }
        }
    }
    
    func toggleSelectedAnimalType(_ animalType:String){
        if animalType == "all" {
            selectedAnimalTypes = ["all"]
            return
        } else {
            selectedAnimalTypes.remove("all")
            if selectedAnimalTypes.contains(animalType) {
                selectedAnimalTypes.remove(animalType)
            } else {
                selectedAnimalTypes.insert(animalType)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case RowIndex.All.rawValue:
            toggleSelectedAnimalType("all")
        case RowIndex.Dogs.rawValue:
            toggleSelectedAnimalType("dogs")
        case RowIndex.Cats.rawValue:
            toggleSelectedAnimalType("cats")
        case RowIndex.Birds.rawValue:
            toggleSelectedAnimalType("birds")
        case RowIndex.SmallFurry.rawValue:
            toggleSelectedAnimalType("smallFurry")
        case RowIndex.Horses.rawValue:
            toggleSelectedAnimalType("horses")
        case RowIndex.BarnYard.rawValue:
            toggleSelectedAnimalType("barnYard")
        case RowIndex.Reptiles.rawValue:
            toggleSelectedAnimalType("reptiles")
        default:
            print("no action")
        }
        setAnimalTypeCheckmarks()
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didChangeAnimalTypeSelections()
    }
}


protocol FilterSelectorDelegate {
    func didChangeAnimalTypeSelections()
}
