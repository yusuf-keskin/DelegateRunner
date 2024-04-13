//
//  LinkProviderServiceStub.swift
//  DelegateRunnerTests
//
//  Created by YUSUF KESKİN on 12.04.2024.
//

import UIKit
import XCTest
@testable import DelegateRunner


class LinkProviderServiceStub : LinkProviderServiceProtocol {
    
    var delegate: LinkProviderServiceDelegate? {
        didSet {
            try? delegate?.getImageLink(imageUrlString: stubLink)
        }
    }
}


class ImageViewModelDelegateSpy : ImageVCViewModelDelegate {
    
    var responseImage : UIImage?
    var expectation : XCTestExpectation?
    
    var xcTestCase : XCTestCase
    
    init(xcTestCase: XCTestCase) {
        self.xcTestCase = xcTestCase
        setExpectation()
    }
    
    func setExpectation() {
        expectation = xcTestCase.expectation(description: "ImageViewModel Expectation")
    }
    
    func getImage(image: UIImage) {
        guard (expectation != nil) else { return }
        responseImage = image
        expectation?.fulfill()
        expectation = nil
    }
}
