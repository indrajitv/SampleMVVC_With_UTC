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
        studentListView.didSelectRowAtCompletion = didSelectRowAtCompletion
        navigation.pushViewController(studentListView, animated: true)
    }
    
    func didSelectRowAtCompletion(_ viewModel: StudentTableCellViewModelProtocol?) {
        guard let student = viewModel?.student else { return }
        
        let viewModel = StudentDetailsViewModel(student: student)
        let studentDetailsView = StudentDetailsView(viewModel: viewModel)
        navigation.pushViewController(studentDetailsView, animated: true)
    }
}
