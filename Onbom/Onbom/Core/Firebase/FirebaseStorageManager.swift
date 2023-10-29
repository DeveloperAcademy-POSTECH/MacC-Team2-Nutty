//
//  FirebaseStorageManager.swift
//  Onbom
//
//  Created by moon on 10/29/23.
//

import FirebaseStorage
import PDFKit

enum FirebaseStorageError: String, Error {
    case TimeOutError = "죄송합니다, 작업이 시간초과되었습니다. 다시 시도해주세요"
    case TestError = "에러가 정상동작하는지 테스트합니다"
}

public final class FirebaseStorageManager {
    static let shared: FirebaseStorageManager = .init()
    
    private static let storageRef = Storage.storage().reference().child("pdf")
    
    public func upload(_ pdfData: Data) async throws {
        #if DEBUG
        sleep(UInt32(2.5))
//        throw FirebaseStorageError.TestError
        #else
        let startTime = Date()
        Self.storageRef
            .child(UUID().uuidString)
            .putData(pdfData, metadata: nil)
        
        let endTime = Date()
        let executionTime = UInt32(endTime.timeIntervalSince(startTime))
        sleep(UInt32(2.5) - executionTime) // TODO
        #endif
    }
}
