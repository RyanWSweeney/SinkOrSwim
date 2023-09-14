//
//  TableViewController.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//


import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view's dataSource and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        //Register Custom Cell classes
        self.tableView.register(CustomCellType1.self, forCellReuseIdentifier: "CustomCellType1")
        
        self.tableView.register(CustomCellType2.self, forCellReuseIdentifier: "CustomCellType2")

        self.tableView.register(CustomCellType3.self, forCellReuseIdentifier: "CustomCellType3")

    }
    
    // MARK: - UITableViewDataSource methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // You can adjust this as necessary
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
                // Use CustomCellType1 for the first row
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellType1", for: indexPath) as! CustomCellType1
                cell.titleLabel.text = "Click Me!"
                return cell
            } else if indexPath.row == 1 {
                // Use CustomCellType2 for the second row
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellType2", for: indexPath) as! CustomCellType2
                cell.titleLabel.text = "Click Me Too!"
                return cell
            } else if indexPath.row == 2 {
                // Use CustomCellType3 for the third row
                let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCellType3", for: indexPath) as! CustomCellType3
                cell.titleLabel.text = "Click Me 3!!"
                return cell
            }

        return UITableViewCell()
    }

    // MARK: - UITableViewDelegate methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? CustomCellType1 {
            cell.changeTextColorToRandom()
        }
        tableView.deselectRow(at: indexPath, animated: true) // Deselect the cell after it's tapped
    }
}
