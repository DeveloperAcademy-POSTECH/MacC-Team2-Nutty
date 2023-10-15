//
//  HomeNavigationViewModel.swift
//  Onbom
//
//  Created by moon on 10/14/23.
//

import SwiftUI

class HomeNavigationViewModel: ObservableObject{
    @Published var homePath: [HomeRoute] = []
    
    func navigate(_ route: HomeRoute)  {
        homePath.append(route)
    }
    
    func pop() {
        homePath.removeLast()
    }
    
    func popToRoot() {
        homePath = []
    }
}

public enum HomeRoute {
    case MainView
    case ApplyTypeView
    case MediHistoryView
    case MediConditionView
    case IDCardDescriptionView
    case IDCardOCRView
    case IDCardConfirmEditView
    case AddressFormView_Patient
    case AddressFormView_Agent
    case SignatureView
    case SubmitCheckListView
    case StepView_First
    case StepView_Second
    case PatientInfoView
    case AgentInfoView
    case RejectView
}
