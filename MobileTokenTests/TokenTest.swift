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
        let secret = "p_ggeBSlQwxoTPds93novuCNWZp1DF_NNQ9mcrFkx0g="
//        let secret = "2cNDYXrErLw6F2QGFHLwm1rdiaRE1PMxKc8oGti5kP0="
        let bank = Bank(name: Bank.BankName.AYANDE, logoResourceId: nil, secret: secret)
        let tokenPacket = "c15d8f73a30e82b6102038f8d33e4d7b580806aafdfdbd63cd3f81a5f96337a0ad71519cdd31a37c6f1fdf5d01172f1802382b96150a03b47c5180cc80c8ea39"
//        let tokenPacket = "0daaeb073962427f28b5b7eaaa37ba2491dac3d3ce8a1f81995d846524f987f9da1bac7fb664916464e128c3bf597352bd7849a902a463c66c57ccb4e8fbbd8d"
        let token = Token(tokenPaket: tokenPacket, bank: bank, cryptoModuleId: .one)
        XCTAssertTrue(token.parse())
    }

}
