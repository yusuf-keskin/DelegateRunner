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
        self.uiImage = image
        expectation?.fulfill()
    }
        
    var uiImage : UIImage?
    var sut : ImageVCViewModelProtocol?
    var imagelinkProvider: LinkProviderServiceProtocol?
    var expectation : XCTestExpectation?

    override func setUpWithError() throws {
        expectation = XCTestExpectation(description: "ImageVCViewModel Provider Test Expectation")
        imagelinkProvider = LinkProviderServiceStub()    
        sut = ImageVCViewModel(imageLinkProvider: imagelinkProvider!)
        sut?.viewModelDelegate = self
    }

    override func tearDownWithError() throws {
        imagelinkProvider = nil
        sut = nil
        expectation = nil
    }

    func test_ImageVCViewModel_WhenValidImageLinkProvided_DownloadsAnImage() throws {
        let asyncExpectation = try XCTUnwrap(expectation)
        self.wait(for: [asyncExpectation], timeout: 1)
        XCTAssertNotNil(uiImage,"When valid image link string provided, uiImage should be not nil.")
    }
}

final class ImageViewModelTests2: XCTestCase {

    var sut : ImageVCViewModelProtocol?
    var imagelinkProvider: LinkProviderServiceProtocol?
    var viewModelDelegate : ImageVCViewModelDelegate?
    
    override func setUpWithError() throws {
        imagelinkProvider = LinkProviderServiceStub()
        viewModelDelegate = ImageViewModelDelegateSpy(xcTestCase: self)
        sut = ImageVCViewModel(imageLinkProvider: imagelinkProvider!)
        sut?.viewModelDelegate = viewModelDelegate
    }
    
    override func tearDownWithError() throws {
        viewModelDelegate = nil
        imagelinkProvider = nil
        sut = nil
    }
    
    func test_ImageVCViewModel_WhenValidImageLinkProvided_DownloadsAnImage() throws {
        guard let delegate = viewModelDelegate as? ImageViewModelDelegateSpy else { return }
        waitForExpectations(timeout: 1)
        let image = try? XCTUnwrap(delegate.responseImage)
        XCTAssertNotNil(image,"When valid image link string provided, image should be not nil.")
    }
}
