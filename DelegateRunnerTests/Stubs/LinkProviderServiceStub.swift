//
//  LinkProviderServiceStub.swift
//  DelegateRunnerTests
//
//  Created by YUSUF KESKİN on 12.04.2024.
//

import Foundation
@testable import DelegateRunner


class LinkProviderServiceStub : LinkProviderServiceProtocol {
    
    var delegate: LinkProviderServiceDelegate? {
        didSet {
            try? delegate?.getImageLink(imageUrlString: stubLink)
        }
    }
}
