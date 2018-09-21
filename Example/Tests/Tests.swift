import AstroForms
import XCTest


class TestForm: Form, ValidatableForm {

}

class StringRow: ValueRow {

    func valueDidEdit() {}
    func valueDidStartEditing() {}
    func valueDidEndEditing() {}
    var valueHasChanged: Bool = false
    var valueHasEndedEditing: Bool = false
    var valueHasStartedEditing: Bool = false

    typealias Value = String

    var value: String

    init(value: String) {
        self.value = value
    }

}

class ValidationTests: XCTestCase {
    
    var form = TestForm(frame: .zero)
    
    var stringRow = StringRow(value: "astro")
    
    override func setUp() { super.setUp() }
    
    override func tearDown() { super.tearDown() }
    
    /// If all tests pass or fail, validation passes or fails.
    func testValidationPassFail() {
    
        let passResult = form.validate(
            row: stringRow,
            { $0 == "astro" },
            { $0.count == 5 }
        )
        
        XCTAssert(passResult == true)
        
        let failResult = form.validate(
            row: stringRow,
            { $0 == "foo" },
            { $0.count == 8 }
        )
        
        XCTAssert(failResult == false)
        
    }
    
    /// If only one test fails, the whole chain fails
    func testChainFailure() {
        
        let failResult = form.validate(
            row: stringRow,
            { $0 == "astro" },
            { $0.count == 20 }
        )
        
        XCTAssert(failResult == false)
        
    }
    
    /// The validation error status and message should be correect
    func testMessageValidation() {
        
        let message = "The input string must equal astro"
        
        let failResult = form.validate(
            row: stringRow,
            ({ $0 == "forms" }, message)
        )
        
        XCTAssert(failResult.0 == false)
        XCTAssert(failResult.1 == message)
        
    }
    
    /// If the second in chain fails, that message should be returned
    func testSecondInChainMessage() {
        
        let message = "The character count must be correct"
        
        let failResult = form.validate(
            row: stringRow,
            ({ $0 == "astro" }, "This should pass"),
            ({ $0.count == 10 }, message)
        )
        
        XCTAssert(failResult.0 == false)
        XCTAssert(failResult.1 == message)
        
    }
    
    /// If using a validation list, each line should have a correct status
    /// and message
    func testValidationList() {
        
        let equalityMessage = "String should equal astro"
        let countMessage = "Character count should be correct"
        let atSymbolMessage = "@ Symbol should be included"
        
        let mixedResult = form.validateList(
            row: stringRow,
            ({$0 == "astro" }, equalityMessage),
            ({$0.count == 10}, countMessage),
            ({$0.contains("@")}, atSymbolMessage)
        )
        
        XCTAssert(mixedResult[0].0 == true)
        XCTAssert(mixedResult[0].1 == equalityMessage)
        XCTAssert(mixedResult[1].0 == false)
        XCTAssert(mixedResult[1].1 == countMessage)
        XCTAssert(mixedResult[2].0 == false)
        XCTAssert(mixedResult[2].1 == atSymbolMessage)
        
    }
    
}
