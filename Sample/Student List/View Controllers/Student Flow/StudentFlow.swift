//
//  StudentFlow.swift
//  SOLID
//
//  Created by Indrajit Chavda on 02/01/22.
//

import UIKit

struct StudentFlow {
    private let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func start() {
        let studentListViewModel = StudentListViewModel(service: StudentAPIServices())
        let studentListView = StudentListView(viewModel: studentListViewModel)
        studentListView.didSelectRowAtCompletion = { viewModel in
            guard let student = viewModel?.student else { return }
            
            let viewModel = StudentDetailsViewModel(student: student)
            let studentDetailsView = StudentDetailsView(viewModel: viewModel)
            studentDetailsView.nameModificationObserver = studentListView.observeForNewName
            navigation.pushViewController(studentDetailsView, animated: true)
        }
        navigation.pushViewController(studentListView, animated: true)
    }
    
}
