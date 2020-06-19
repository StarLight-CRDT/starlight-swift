import XCTest
@testable import starlight_swift

final class PNCounterTests: XCTestCase {
    func testIncrementWithNoInitialValue() {
        let pnCounter = PNCounter()
        
        pnCounter.increment()
        
        XCTAssertEqual(pnCounter.count, 1)
        XCTAssertEqual(pnCounter.value(), 1)
    }
}
