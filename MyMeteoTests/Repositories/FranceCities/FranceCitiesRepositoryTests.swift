//
//  FranceCitiesRepositoryTests.swift
//  MyMeteoTests
//
//  Created by Sami Benmakhlouf on 01/12/2019.
//  Copyright © 2019 Sami Benmakhlouf. All rights reserved.
//

import Nimble
import Quick
import XCTest

@testable import MyMeteo

class FranceCitiesRepositoryTests: QuickSpec, JSONFileReadable {

    // MARK: - Properties

    private var franceCitiesRepository: FranceCitiesRepository!
    private var fileReader: FileReaderProtocolMock!

    // MARK: - Tests

    override func spec() {
        beforeEach {
            self.fileReader = FileReaderProtocolMock()
            self.franceCitiesRepository = FranceCitiesRepository(fileReader: self.fileReader)
        }

        describe("GIVEN we have a valid France Cities list") {
            beforeEach {
                self.fileReader.readFromReturnValue = self.readFile(named: "france_cities_valid_mock")
            }
            context("WHEN I retrieve it") {
                var list: [FranceCitiesRepositoryResponseProtocol] = []
                beforeEach {
                    self.franceCitiesRepository.fetch(success: { response in
                        list = response
                    }, failure: { _ in
                        fail("Should not fail!")
                    })
                }
                it("THEN we call fileReader") {
                    expect(self.fileReader.readFromCallsCount).toEventually(equal(1))
                }
                it("THEN the list should not be empty") {
                    expect(list.isEmpty).toEventually(beFalse())
                }
                it("THEN the list should contains 10 cities") {
                    expect(list.count).toEventually(equal(3))
                }
                it("THEN the first item is Dijon") {
                    expect(list.first?.name).toEventually(equal("Dijon"))
                }
                it("THEN the second item is Grenoble") {
                    expect(list[safe: 1]?.name).toEventually(equal("Grenoble"))
                }
                it("THEN the thid item is Lille") {
                    expect(list[safe: 2]?.name).toEventually(equal("Lille"))
                }
            }
        }
        describe("GIVEN we have a empty France Cities list") {
            beforeEach {
                self.fileReader.readFromReturnValue = self.readFile(named: "france_cities_empty_mock")
            }
            context("WHEN I retrieve it") {
                var list: [FranceCitiesRepositoryResponseProtocol] = []
                beforeEach {
                    self.franceCitiesRepository.fetch(success: { response in
                        list = response
                    }, failure: { _ in
                        fail("Should not fail!")
                    })
                }
                it("THEN we call fileReader") {
                    expect(self.fileReader.readFromCallsCount).toEventually(equal(1))
                }
                it("THEN the list should not be empty") {
                    expect(list.isEmpty).toEventually(beTrue())
                }
                it("THEN the list should contains 10 cities") {
                    expect(list.count).toEventually(equal(0))
                }
            }
        }
        describe("GIVEN we have an invali France Cities list") {
            beforeEach {
                self.fileReader.readFromReturnValue = self.readFile(named: "france_cities_invalid_mock")
            }
            context("WHEN I retrieve it") {
                var error: FranceCitiesRepositoryError?
                beforeEach {
                    self.franceCitiesRepository.fetch(success: { _ in
                        fail("Should not be on success!")
                    }, failure: { retrievedError in
                        error = retrievedError
                    })
                }
                it("THEN we call fileReader") {
                    expect(self.fileReader.readFromCallsCount).toEventually(equal(1))
                }
                it("THEN an unknown error is triggred") {
                    expect(error).toEventually(equal(.unknown))
                }
            }
        }
    }
}
