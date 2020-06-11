import XCTest
@testable import starlight_swift

final class TwoPhaseSetTests: XCTestCase {

    let fixture1 = Dummy(field1: "Luke", field2: 20)
    let fixture2 = Dummy(field1: "Lea", field2: 26)
    let fixture3 = Dummy(field1: "Han", field2: 42)
    let fixture4 = Dummy(field1: "Chewbacca", field2: 43)

    func testAdd() {
        let twoPset = TwoPhaseSet<Dummy>()
        twoPset.add(fixture1)
        twoPset.add(fixture2)
        twoPset.add(fixture3)
        XCTAssertEqual(twoPset.dataset.dataset.count, 3)
    }
    
    func testContains() {
        let twoPset = TwoPhaseSet<Dummy>()
        twoPset.add(fixture1)
        XCTAssertEqual(twoPset.contains(fixture1), true)
    }
    
    func testRemove() {
        let twoPset1 = TwoPhaseSet<Dummy>()
        twoPset1.add(fixture1)
        twoPset1.add(fixture2)
        twoPset1.add(fixture3)
        twoPset1.remove(fixture2)
        
        let twoPset2 = TwoPhaseSet<Dummy>()
        twoPset2.add(fixture1)
        twoPset2.add(fixture3)
        
        XCTAssertEqual(twoPset1.dataset.dataset.count, 2)
        XCTAssertEqual(twoPset1.compare(twoPset2), true)
    }
    
    func testCompare() {
        let twoPset1 = TwoPhaseSet<Dummy>()
        twoPset1.add(fixture1)
        twoPset1.add(fixture2)
        twoPset1.add(fixture3)
        let twoPset2 = TwoPhaseSet<Dummy>()
        twoPset2.add(fixture1)
        twoPset2.add(fixture2)
        twoPset2.add(fixture3)
        let twoPset3 = TwoPhaseSet<Dummy>()
        twoPset3.add(fixture1)
        twoPset3.add(fixture2)
        let twoPset4 = TwoPhaseSet<Dummy>()
        twoPset4.add(fixture1)
        twoPset4.add(fixture2)
        twoPset4.add(fixture3)
        twoPset4.add(fixture4)
        
        XCTAssertEqual(twoPset1.compare(twoPset2), true)
        XCTAssertEqual(twoPset1.compare(twoPset3), false)
        XCTAssertEqual(twoPset1.compare(twoPset4), false)
    }
    
    func testMerge() {
        let twoPset1 = TwoPhaseSet<Dummy>()
        twoPset1.add(fixture1)
        twoPset1.add(fixture2)
        twoPset1.add(fixture3)
        let twoPset2 = TwoPhaseSet<Dummy>()
        twoPset2.add(fixture1)
        twoPset2.add(fixture2)
        twoPset2.add(fixture4)
        let twoPset4 = TwoPhaseSet<Dummy>()
        twoPset4.add(fixture1)
        twoPset4.add(fixture2)
        twoPset4.add(fixture3)
        twoPset4.add(fixture4)
        
        let twoPsetMerged = twoPset1.merge(twoPset2)
        XCTAssertEqual(twoPsetMerged.compare(twoPset4), true)
    }
}
