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
        sut = LinkProviderService(listApiEndpoint: testUrl!)
        sut?.delegate = self
        expectation = XCTestExpectation(description: "Image Link Provider Test Expectation")
    }

    override func tearDownWithError() throws {
        testUrl = nil
        sut?.delegate = nil
        expectation = nil
        sut = nil
    }

    func test_LinkProvider_WhenValidEndpointProvided_ProvidesAnImageLinkString() throws {
        let asyncExpectation = try XCTUnwrap(expectation)
        self.wait(for: [asyncExpectation], timeout: 2)
        XCTAssertNotNil(imageLink,"When valid endpoint string provided, imageLink should be not nil")
    }
}
