//
//  FilterViewController.swift
//  PetAdoption-iOS
//
//  Created by Amir Fleminger on 4/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController {
    var delegate: FilterSelectorDelegate?
    enum RowIndex:Int {
        case all = 0, dogs, cats, birds, smallFurry, horses, barnYard, reptiles, rabbits
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
        selectedAnimalTypes = FilterViewController.loadAnimalTypesSelected()
        setAnimalTypeCheckmarks()
    }
    
    class func loadAnimalTypesSelected() -> Set<String>{
        let defaults = UserDefaults.standard
        
        guard let data:Data = defaults.object(forKey: "selectedAnimalTypes") as? Data else {
            print("Couldnt load animal type preferences! Default to all animal types")
            return ["all"]
        }
        // convert the Data object to a Set<String>
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! Set<String>
    }
    
    class func saveAnimalTypesSelected(_ selectedAnimalTypes_: Set<String>){
        let defaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: selectedAnimalTypes_)
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
                cell?.accessoryType = (indexPath.row == RowIndex.all.rawValue) ? .checkmark : .none
            } else {
                switch indexPath.row{
                case RowIndex.dogs.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Dog") ? .checkmark : .none
                case RowIndex.cats.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Cat") ? .checkmark : .none
                case RowIndex.birds.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Bird") ? .checkmark : .none
                case RowIndex.smallFurry.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Small&Furry") ? .checkmark : .none
                case RowIndex.horses.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Horse") ? .checkmark : .none
                case RowIndex.barnYard.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("BarnYard") ? .checkmark : .none
                case RowIndex.reptiles.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Reptile") ? .checkmark : .none
                case RowIndex.rabbits.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Rabbit") ? .checkmark : .none
                default:
                    cell?.accessoryType = .none
                }
                
            }
        }
    }
    
    func resetSelectedAnimalTypes(){
        selectedAnimalTypes = ["all"]
    }
    
    func toggleSelectedAnimalType(_ animalType:String){
        if animalType == "all" {
            resetSelectedAnimalTypes()
            return
        } else {
            selectedAnimalTypes.remove("all")
            if selectedAnimalTypes.contains(animalType) {
                selectedAnimalTypes.remove(animalType)
            } else {
                selectedAnimalTypes.insert(animalType)
            }
        }
        if selectedAnimalTypes.count == 0 {
            resetSelectedAnimalTypes()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case RowIndex.all.rawValue:
            toggleSelectedAnimalType("all")
        case RowIndex.dogs.rawValue:
            toggleSelectedAnimalType("Dog")
        case RowIndex.cats.rawValue:
            toggleSelectedAnimalType("Cat")
        case RowIndex.birds.rawValue:
            toggleSelectedAnimalType("Bird")
        case RowIndex.smallFurry.rawValue:
            toggleSelectedAnimalType("Small&Furry")
        case RowIndex.horses.rawValue:
            toggleSelectedAnimalType("Horse")
        case RowIndex.barnYard.rawValue:
            toggleSelectedAnimalType("BarnYard")
        case RowIndex.reptiles.rawValue:
            toggleSelectedAnimalType("Reptile")
        case RowIndex.rabbits.rawValue:
            toggleSelectedAnimalType("Rabbit")
        default:
            print("no action")
        }
        setAnimalTypeCheckmarks()
        tableView.deselectRow(at: indexPath, animated: true)
        FilterViewController.saveAnimalTypesSelected(selectedAnimalTypes)
        delegate?.didChangeAnimalTypeSelections()
    }
}


protocol FilterSelectorDelegate {
    func didChangeAnimalTypeSelections()
}
