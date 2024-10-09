//
//  CountriesTableViewDataSource.swift
//  CurrencyExplorer
//
//  Created by sokolli on 4/10/24.
//

import Foundation
import UIKit

class CountriesTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    private var cellIdentifier : String!
    private var items : [T]!


    init(cellIdentifier : String, items : [T]) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.sectionHeaderTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier) as! ViewTableViewCell
        cell.accessoryView = UIImageView(image: UIImage(systemName: "chevron.right"))
        cell.accessoryView?.tintColor = .white
        cell.textLabel?.numberOfLines = 0
        let item = items[indexPath.row]
        cell.configCellInfo(country: item as! Country)
        return cell
    }
}

