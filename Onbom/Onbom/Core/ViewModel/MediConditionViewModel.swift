//
//  MediConditionViewModel.swift
//  Onbom
//
//  Created by moon on 10/11/23.
//

import Foundation
import Combine

final class MediConditionViewModel: ObservableObject {
    @Published var hasInfectiousDisease: Bool?
    @Published var hasMentalDisorder: Bool?
    
    // Output subscribers
    @Published var formIsValid = false
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isMediConditionFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
    }
    
    
    private var isInfectiousDiseaseChecked: AnyPublisher<Bool, Never> {
        $hasInfectiousDisease
            .map { answer in
                return answer != nil
            }
            .eraseToAnyPublisher()
    }
    
    private var isMentalDisorderChecked: AnyPublisher<Bool, Never> {
        $hasMentalDisorder
            .map { answer in
                return answer != nil
            }
            .eraseToAnyPublisher()
    }
    
    private var isMediConditionFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(
            isInfectiousDiseaseChecked,
            isMentalDisorderChecked)
        .map { infectiousDiseaseChecked, mentalDisorderChecked in
            return infectiousDiseaseChecked && mentalDisorderChecked
        }
        .eraseToAnyPublisher()
    }
    
}

