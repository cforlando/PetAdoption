//
//  filterViewControlelr.swift
//  PetAdoption-iOS
//
//  Created by Amir Fleminger on 4/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import UIKit

class FilterViewController: UITableViewController {
    var delegate: FilterSelectorDelegate?
    enum RowIndex:Int {
        case All = 0, Dogs, Cats, Birds, SmallFurry, Horses, BarnYard, Reptiles, Rabbits
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
                cell?.accessoryType = (indexPath.row == RowIndex.All.rawValue) ? .checkmark : .none
            } else {
                switch indexPath.row{
                case RowIndex.Dogs.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Dog") ? .checkmark : .none
                case RowIndex.Cats.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Cat") ? .checkmark : .none
                case RowIndex.Birds.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Bird") ? .checkmark : .none
                case RowIndex.SmallFurry.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Small&Furry") ? .checkmark : .none
                case RowIndex.Horses.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Horse") ? .checkmark : .none
                case RowIndex.BarnYard.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("BarnYard") ? .checkmark : .none
                case RowIndex.Reptiles.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Reptile") ? .checkmark : .none
                case RowIndex.Rabbits.rawValue:
                    cell?.accessoryType = selectedAnimalTypes.contains("Rabbit") ? .checkmark : .none
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
            toggleSelectedAnimalType("Dog")
        case RowIndex.Cats.rawValue:
            toggleSelectedAnimalType("Cat")
        case RowIndex.Birds.rawValue:
            toggleSelectedAnimalType("Bird")
        case RowIndex.SmallFurry.rawValue:
            toggleSelectedAnimalType("Small&Furry")
        case RowIndex.Horses.rawValue:
            toggleSelectedAnimalType("Horse")
        case RowIndex.BarnYard.rawValue:
            toggleSelectedAnimalType("BarnYard")
        case RowIndex.Reptiles.rawValue:
            toggleSelectedAnimalType("Reptile")
        case RowIndex.Rabbits.rawValue:
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
