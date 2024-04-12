//
//  ViewModelErrors.swift
//  DelegateRunner
//
//  Created by YUSUF KESKİN on 11.04.2024.
//

import UIKit

enum ViewModelError : LocalizedError {
    case serverError
    case dataTypeError
    case urlCreationError
    
    var errorDescription: String? {
        switch self {
            case .serverError:
                "Server response status code is out of expectable range"
            case .dataTypeError:
                "Server data response type is unvalid"
            case .urlCreationError:
                "Url creation from given string is failed, invalid string format"
        }
    }
}
