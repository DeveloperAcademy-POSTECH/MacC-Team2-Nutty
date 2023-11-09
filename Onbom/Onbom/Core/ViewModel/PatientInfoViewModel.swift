//
//  PatientInfoViewModel.swift
//  Onbom
//
//  Created by moon on 10/11/23.
//

import Foundation
import Combine

final class PatientInfoViewModel: ObservableObject {
    
    @Published var seniorIDNumber1:         String = ""
    @Published var seniorIDNumber2:         String = ""
    @Published var seniorPhoneNumber:       String = ""
    @Published var seniorName:              String = ""
    
    @Published var hasMobile:               Bool = true
    
    @Published var isSeniorNameWrong:       Bool = false
    @Published var isSeniorPhoneNumberWrong:Bool = false
    @Published var isSeniorIDNumber1Wrong:  Bool = false
    
    // Output subscribers
    @Published var formIsValid = false
    
    private var publishers = Set<AnyCancellable>()
    
    init() {
        isPatientInfoFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &publishers)
    }
    
    // TODO: TestCode 작성하기
    
    
    private var IDNumber1Publisher: AnyPublisher<Bool, Never> {
        $seniorIDNumber1
            .map { number in
                return number.count == 6
            }
            .eraseToAnyPublisher()
    }
    
    private var IDNumber2Publisher: AnyPublisher<Bool, Never> {
        $seniorIDNumber2
            .map { number in
                return number.count == 7
            }
            .eraseToAnyPublisher()
    }
    
    private var phoneNumberPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .CombineLatest(
                $seniorPhoneNumber
                    .map { number in
                        return number.count == 11
                    }
                    .eraseToAnyPublisher(),
                $hasMobile
                    .map { hasMobile in
                        return !hasMobile
                    }
                    .eraseToAnyPublisher()
            )
            .map { $0 || $1 }
            .eraseToAnyPublisher()
    }
    
    private var hasMobilePublisher: AnyPublisher<Bool, Never> {
        return $hasMobile
            .map { hasMobile in
                return hasMobile
            }
            .eraseToAnyPublisher()
    }
    
    var namePublisher: AnyPublisher<Bool, Never> {
        $seniorName
            .map { name in
                return name.count > 0
            }
            .eraseToAnyPublisher()
    }
    
    private var isPatientInfoFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(
            namePublisher,
            phoneNumberPublisher,
            IDNumber1Publisher,
            IDNumber2Publisher
        )
        .debounce(for: .milliseconds(50), scheduler: RunLoop.main)
        .map { $0 && $1 && $2 && $3 }
        .eraseToAnyPublisher()
    }
    
    public func validateInputField() -> Bool {
        
        isSeniorIDNumber1Wrong          = !seniorIDNumber1.isValidDateOfBirth()
        
        if(hasMobile == true) {
            isSeniorPhoneNumberWrong    = !seniorPhoneNumber.isValidPhoneNumber()
        } else {
            isSeniorPhoneNumberWrong    = false
        }
        isSeniorNameWrong               = !seniorName.isValidName()
                
        return ![isSeniorNameWrong, isSeniorIDNumber1Wrong, isSeniorPhoneNumberWrong]
            .reduce(false) { $0 || $1 }
        
    }
    
    public func validateName() -> Bool {
        isSeniorNameWrong               = !seniorName.isValidName()
        return !isSeniorNameWrong
    }
    
    public func validatePhoneNumber() -> Bool {
        isSeniorPhoneNumberWrong        = !seniorPhoneNumber.isValidPhoneNumber()
        return !isSeniorPhoneNumberWrong
    }
    
    public func validateIDNumber1() -> Bool {
        isSeniorIDNumber1Wrong          = !seniorIDNumber1.isValidDateOfBirth()
        return !isSeniorIDNumber1Wrong
    }
}

