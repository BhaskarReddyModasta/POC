//
//  POCTests.swift
//  POCTests
//
//  Created by Admin on 13/06/18.
//  Copyright © 2018 Bhaskar. All rights reserved.
//

import XCTest
@testable import POC

class CanadaModelTestCases: XCTestCase {
    
    //canada model data = System under test
    var canadaModel: CanadaListDataModel!
    
    override func setUp() {
        super.setUp()
        if let path = Bundle.main.path(forResource: "aboutcanada", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    print("could not convert data to UTF-8 format")
                    print("String format failed")
                    return
                }
                do {
                    let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                    canadaModel = CanadaListDataModel(json: responseJSONDict as? Dictionary<String, Any>)
                    
                } catch {
                    print("json failed")
                }
                
            } catch {
                print("Error")
            }
        }
    }
    
    override func tearDown() {
        canadaModel = nil
        super.tearDown()
    }
    // testing for title of the page
    func test_numberOfRows_failure() {
        let rows = canadaModel.rowsListArray.count
        XCTAssertNotEqual(rows, 0)
    }
    // Test to verify the details of model class fetched values
    func test_titleForPage_success() {
        XCTAssertEqual(canadaModel.rowsListArray[0].title, "Beavers")
        XCTAssertEqual(canadaModel.rowsListArray[0].description, "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony")
        
    }
    // Testing non nill objects
    func testInitialData_IsInitiallyNil() {
        XCTAssertNotNil(canadaModel.title)
        XCTAssertNotNil(canadaModel.rowsListArray.count)
        
    }
    
}
