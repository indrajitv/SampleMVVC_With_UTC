//
//  StudentList+Extensions.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import UIKit

extension StudentListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
         let student = self.viewModel.getStudent(at: indexPath.item)
        didSelectRowAtCompletion?(student)
    }
}

extension StudentListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getGetNumberOfStudent()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableCell.cellID,
                                                 for: indexPath) as! StudentTableCell
        cell.viewModel = self.viewModel.getStudent(at: indexPath.item)
        return cell
    }
}
