//
//  ImageLinkProviderSpy.swift
//  DelegateRunnerTests
//
//  Created by YUSUF KESKİN on 12.04.2024.
//

import Foundation
@testable import DelegateRunner

class LinkProviderServiceDelegateSpy : LinkProviderServiceDelegate {
    func getImageLink(imageUrlString: String) {
    }
}

class LinkProviderServiceSpy : LinkProviderServiceProtocol {
    
    var delegate: LinkProviderServiceDelegate? {
        didSet {
            try? delegate?.getImageLink(imageUrlString: stubLink)
        }
    }
    
    init() {
        delegate = LinkProviderServiceDelegateSpy()
    }
}
