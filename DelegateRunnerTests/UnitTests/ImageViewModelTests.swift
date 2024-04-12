//
//  ImageViewModelTests.swift
//  DelegateRunnerTests
//
//  Created by YUSUF KESKİN on 12.04.2024.
//

import XCTest
@testable import DelegateRunner

final class ImageViewModelTests: XCTestCase, ImageVCViewModelDelegate {
    
    func getImage(image: UIImage) {
        print("hey")
        self.uiImage = image
        expectation?.fulfill()
    }
        
    var uiImage : UIImage?
    var sut : ImageVCViewModelProtocol?
    var imagelinkProvider: LinkProviderServiceProtocol?
    var expectation : XCTestExpectation?

    override func setUpWithError() throws {
        expectation = XCTestExpectation(description: "ImageVCViewModel Provider Test Expectation")
        imagelinkProvider = LinkProviderServiceSpy()    
        sut = ImageVCViewModel(imageLinkProvider: imagelinkProvider!)
        sut?.viewModelDelegate = self
    }

    override func tearDownWithError() throws {
        imagelinkProvider = nil
        sut = nil
        expectation = nil
    }

    func testExample() throws {
        let asyncExpectation = try XCTUnwrap(expectation)
        self.wait(for: [asyncExpectation], timeout: 1)
        XCTAssertNotNil(uiImage,"When valid image link string provided, ImageVCViewModel data source should supply an UImage")
    }
}
