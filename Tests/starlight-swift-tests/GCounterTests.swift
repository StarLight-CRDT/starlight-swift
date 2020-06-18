import XCTest
@testable import starlight_swift

final class GCounterTests: XCTestCase {

    func testIncrementWithNonInitialValue() {
        let counter = GCounter()

        counter.increment()

        XCTAssertEqual(counter.count, 1)
        XCTAssertEqual(counter.value(), 1)
    }

    func testIncrementWithWithInitialValue() {
        let counter = GCounter(nodes: [1, 1, 0])

        counter.increment()

        XCTAssertEqual(counter.count, 4)
        XCTAssertEqual(counter.value(), 3)
    }

    func testCompareWithSameAmountOfIncrements() {
        let counter1 = GCounter()
        let counter2 = GCounter()

        counter1.increment()
        counter2.increment()

        XCTAssertTrue(counter1.compare(counter2))
    }

    func testCompareWithDiffAmountOfIncrements() {
        let counter1 = GCounter()
        let counter2 = GCounter()

        counter1.increment()
        counter2.increment()
        counter2.increment()

        XCTAssertTrue(counter1.compare(counter2))
    }

    func testCompareWithDiffAmountOfIncrementsAndInitialValue() {
        let initial = [1, 1, 2, 5]
        let counter1 = GCounter(nodes: initial)
        let counter2 = GCounter(nodes: initial)

        counter1.increment()
        counter2.increment()
        counter2.increment()

        XCTAssertTrue(counter1.compare(counter2))
    }

    func testMergeWithInitialValues() {

        let counter1 = GCounter(nodes: [1, 2, 1])
        let counter2 = GCounter(nodes: [2, 2, 1])

        counter1.increment()
        counter2.increment()
        counter2.increment()

        let expected = GCounter(nodes: [2, 2, 1])
        expected.increment()
        expected.increment()
    
        XCTAssertTrue(expected.compare((try! counter1.merge(counter2))))
    }
}
