//
//  ImageLinkProviderTests.swift
//  DelegateRunnerTests
//
//  Created by YUSUF KESKİN on 12.04.2024.
//

import XCTest
@testable import DelegateRunner

final class LinkProviderServiceTests: XCTestCase, LinkProviderServiceDelegate {
    
    func getImageLink(imageUrlString: String) {
        imageLink = imageUrlString
        expectation?.fulfill()
    }
    
    var imageLink : String?
    var sut : LinkProviderServiceProtocol?
    var testUrl : String?
    var expectation : XCTestExpectation?

    override func setUpWithError() throws {
        testUrl = IMAGE_INFO_LINK
        sut = LinkProviderService(imageInfoLink: testUrl!)
        sut?.delegate = self
        expectation = XCTestExpectation(description: "Image Link Provider Test Expectation")
    }

    override func tearDownWithError() throws {
        testUrl = nil
        sut?.delegate = nil
        expectation = nil
        sut = nil
    }

    func test_ImageLinkProvider_WhenValidEndpointProvided_ShouldReturnString() throws {
        let asyncExpectation = try XCTUnwrap(expectation)
        self.wait(for: [asyncExpectation], timeout: 1)
        XCTAssertNotNil(imageLink,"When valid endpoint string provided, delegate should supply a url string")
    }
}
