//
//  ListViewController.swift
//  SOLID
//
//  Created by Indrajit Chavda on 28/12/21.
//

import UIKit

/// It lists the students in vetrtical fashion. Allows search and pagination.
final class StudentListView: UIViewController {
    // MARK: Properties
    var viewModel: StudentListViewModelProtocol
    var didSelectRowAtCompletion: ((_ viewModel: StudentTableCellViewModelProtocol?) -> Void)?
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(StudentTableCell.self, forCellReuseIdentifier: StudentTableCell.cellID)
        table.delegate = self
        table.dataSource = self
        return table
    }()

    // MARK: Life cycle methods
    
    init(viewModel: StudentListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.title = self.viewModel.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        getStudentData()
    }

    // MARK: Other methods
    private func setUpViews() {
        self.view.backgroundColor = .white
      
        self.view.addSubview(self.tableView)
        tableView.frame = self.view.bounds
    }

    private func getStudentData() {
        viewModel.observStudentData = { [weak self] (result) in
            switch result {
            case .success(_):
                self?.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        self.viewModel.loadStudentData() // Should always get called after above code.
    }
}
