//
//  filterViewControlelr.swift
//  PetAdoption-iOS
//
//  Created by Amir Fleminger on 4/11/18.
//  Copyright © 2018 Code For Orlando. All rights reserved.
//

import UIKit
class filterViewController: UITableViewController {
    
    enum RowIndex:Int {
        case All = 0, Dogs, Cats, Birds, SmallFurry, Horses, BarnYard, Reptiles
    }
    
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
        let testingSet: Set<String> = ["dogs","cats"]
        setAnimalTypeCheckmarks(testingSet)
    }
    
    func setAnimalTypeCheckmarks(_ set: Set<String>) {
        let section = 0
        for row in 0...self.tableView.numberOfRows(inSection: section) - 1{
            let indexPath = IndexPath(row: row, section: section)
            let cell =  tableView.cellForRow(at: indexPath)
            
            if set.contains("all"){
                // put a checkmark only on the 'All' cell
                cell?.accessoryType = (indexPath.row == RowIndex.All.rawValue) ? .checkmark : .none
            } else {
                switch indexPath.row{
                case RowIndex.Dogs.rawValue:
                    cell?.accessoryType = set.contains("dogs") ? .checkmark : .none
                case RowIndex.Cats.rawValue:
                    cell?.accessoryType = set.contains("cats") ? .checkmark : .none
                case RowIndex.Birds.rawValue:
                    cell?.accessoryType = set.contains("birds") ? .checkmark : .none
                case RowIndex.SmallFurry.rawValue:
                    cell?.accessoryType = set.contains("smallFurry") ? .checkmark : .none
                case RowIndex.SmallFurry.rawValue:
                    cell?.accessoryType = set.contains("smallFurry") ? .checkmark : .none
                case RowIndex.Horses.rawValue:
                    cell?.accessoryType = set.contains("horses") ? .checkmark : .none
                case RowIndex.BarnYard.rawValue:
                    cell?.accessoryType = set.contains("barnYard") ? .checkmark : .none
                case RowIndex.Reptiles.rawValue:
                    cell?.accessoryType = set.contains("reptiles") ? .checkmark : .none
                default:
                    cell?.accessoryType = .none
                }
                
            }
        }
    }
}
