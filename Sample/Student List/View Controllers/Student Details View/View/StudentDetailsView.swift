//
//  StudentDetailsView.swift
//  SOLID
//
//  Created by Indrajit Chavda on 02/01/22.
//

import UIKit

/// Class to show details of students.
class StudentDetailsView: UIViewController {
    
    // MARK: Properties
    let viewModel: StudentDetailsViewModel
    var nameModificationObserver: ((_ newName: String) -> Void)?
    
    let labelStudentName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .heavy)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: Lifecycle methods
    init(viewModel: StudentDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.labelStudentName.text = viewModel.studentName
        
    }
    
    deinit {
        print("Deinit - ", String(describing: StudentDetailsView.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpViews()
        self.makeMainViewTouchable()
    }
    
    // MARK: Other methods
    private func setUpViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(labelStudentName)
        
        NSLayoutConstraint.activate([
            labelStudentName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                      constant: 10),
            labelStudentName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                       constant: -10),
            labelStudentName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 50)
        ])
    }
    
    func makeMainViewTouchable() {
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self,
                                                                   action: #selector(self.self.didTapOnMainView)))
    }
    
    @objc func didTapOnMainView() {
        let names = ["Robert Baratheon",
                     "Jaime Lannister",
                     "Jon Snow",
                     "Arya Stark",
                     "Joffrey Baratheon",
                     "Ygritte",
                     "Sansa Stark"]
        self.nameModificationObserver?(names.randomElement() ?? "No Name Produced")
    }
}
