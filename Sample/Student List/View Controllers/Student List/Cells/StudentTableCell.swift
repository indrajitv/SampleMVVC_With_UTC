//
//  StudentTableCell.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import UIKit

/// Cell being used by StudentListView table to list the students
class StudentTableCell: UITableViewCell {
    
    // MARK: Properties
    static let cellID = String(describing: StudentTableCell.self)
    
    var viewModel: StudentTableCellViewModelProtocol? {
        didSet {
            setData()
        }
    }
    
    // MARK: Life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Other methods
    private func setUpViews() {
        backgroundColor = .systemRed
        self.textLabel?.numberOfLines = 0
    }
    
    private func setData() {
        guard let viewModel = self.viewModel else {
            return
        }
        // Set your label and images etc.
        let textToShow =  viewModel.studentName + "\n" + viewModel.studentDOB // Wrong, It is resp. vm.
        self.textLabel?.text = textToShow
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = nil
    }
}
