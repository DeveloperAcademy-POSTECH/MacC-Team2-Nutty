//
//  HomeNavigationViewModel.swift
//  Onbom
//
//  Created by moon on 10/14/23.
//

import SwiftUI

// TODO: navigationManager !!
class HomeNavigationViewModel: ObservableObject {
    @Published var homePath: [HomeRoute] = []
    @Published var isUserFromSubmitCheckListView : Bool = false
    
    func navigate(_ route: HomeRoute) {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            homePath.append(route)
        }
    }
    
    func pop() {
        var transaction = Transaction()
        transaction.disablesAnimations = true
        let _ = withTransaction(transaction) {
            homePath.removeLast()
        }
    }
    
    func popToRoot() {
        DispatchQueue.main.async {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            let _ = withTransaction(transaction) {
                self.homePath.removeAll()
            }
        }
    }
}

public enum HomeRoute {
    case MainView
    case DescriptionView
    case ApplyTypeView
    case MediHistoryView
    case MediConditionView
    case IDCardDescriptionView
    case IDCardOCRView
    case IDCardConfirmEditView
    case AddressFormView_Patient
    case AddressFormView_ActualPatient
    case AddressFormView_Agent
    case SignatureView
    case SubmitCheckListView
    case StepView_First
    case StepView_Second
    case PatientInfoView
    case AgentInfoView
    case OnboardingView
    case ApplyHistoryView
    case AgentInfoDetailView
    case RejectView
}
