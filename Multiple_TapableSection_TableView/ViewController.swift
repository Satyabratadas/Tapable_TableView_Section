//
//  ViewController.swift
//  Multiple_TapableSection_TableView
//
//  Created by Satyabrata Das on 18/02/24.
//

import UIKit

struct Section {
    var mainCellTitle: String
    var expandableCellOptions: [String]
    var isExpandableCellsHidden: Bool
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    let tapableCellIdentifier = "TableViewCellForTapableSection"
    let sliderCellIdentifier = "TableViewCellForSlider"
    let cellIdentifier = "TableViewCell"
    var category = ["Banner", "Canvas Photo", "Bookmark","Banner", "Canvas Photo", "Bookmark","Banner", "Canvas Photo", "Bookmark"]
    var sortBy = ["A-Z", "Z-A"]
    var color = ["Red", "Green", "Blue"]
    var sections: [Section] = []
  
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        sections.append(Section(mainCellTitle: "Category", expandableCellOptions: category, isExpandableCellsHidden: true))
        sections.append(Section(mainCellTitle: "Slider", expandableCellOptions: [], isExpandableCellsHidden: true))
        sections.append(Section(mainCellTitle: "Sort By", expandableCellOptions: sortBy, isExpandableCellsHidden: true))
        sections.append(Section(mainCellTitle: "Color", expandableCellOptions: color, isExpandableCellsHidden: true))
        self.tableView.register(UINib(nibName: tapableCellIdentifier, bundle: nil), forCellReuseIdentifier: tapableCellIdentifier)
        self.tableView.register(UINib(nibName: sliderCellIdentifier, bundle: nil), forCellReuseIdentifier: sliderCellIdentifier)
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        super.viewDidLoad()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        if !section.isExpandableCellsHidden {
            return section.expandableCellOptions.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            // Load a different cell for a specific section
            let cell = tableView.dequeueReusableCell(withIdentifier: sliderCellIdentifier, for: indexPath) as! TableViewCellForSlider
            cell.sliderHeader.text = sections[indexPath.section].mainCellTitle
            // Configure the cell as needed
            return cell
        }else{
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: tapableCellIdentifier, for: indexPath) as! TableViewCellForTapableSection
                cell.cellHeaderTxt.text = sections[indexPath.section].mainCellTitle
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
                cell.sectionCellName.text = sections[indexPath.section].expandableCellOptions[indexPath.row - 1]
                return cell
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 1{
            if indexPath.row == 0{
                sections[indexPath.section].isExpandableCellsHidden = !sections[indexPath.section].isExpandableCellsHidden
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 100
        }else{
            if indexPath.row == 0{
                return 50
            }else{
                return 30
            }
        }
        
    }
    
    
    
}



