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
    case InternetError = "인터넷 연결을 확인해주세요"
}

public final class FirebaseStorageManager {
    static let shared: FirebaseStorageManager = .init()
    
    private static let storageRef = Storage.storage().reference().child("pdf")
    
    public func upload(_ pdfData: Data, completion: ((_: Error?) -> Void)? = nil) async {
        #if DEBUG
        sleep(1)
        // completion?(FirebaseStorageError.InternetError)
        completion?(nil)
        #else
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: currentDate)

        Self.storageRef
            .child(dateString)
            .putData(pdfData, metadata: nil) { _, error in
                completion?(error)
            }
        #endif
    }
    
}
