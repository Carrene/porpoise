//
//  MobileTokenTests.swift
//  MobileTokenTests
//
//  Created by hamed akhlaghi on 8/9/1397 AP.
//  Copyright © 1397 ba24.ir. All rights reserved.
//

import XCTest
@testable import MobileToken

class MobileTokenTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParseToken() {
        let secret = "D-vjoZUYzLsp0Uz4nyBF3xXGlA3HnAAouZsiUsDdzWA="
        let tokenPacket = "14d5d5620e7ac19a2cf9d4103ad2dc6be29b00ceeb5ad06dbeea7a0fafd2f366bdd68240fbc19ea2092e883abd0e2570a39c4805a58eda0ebe4f698307d71462"
        let token = Token(tokenPaket: tokenPacket, secret: secret)
        XCTAssertTrue(token.parse())
    }

}
