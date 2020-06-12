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
        XCTAssertEqual(twoPset.count, 3)
    }
    
    func testContains() {
        let twoPset = TwoPhaseSet<Dummy>()
        twoPset.add(fixture1)
        XCTAssertTrue(twoPset.contains(fixture1))
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
        
        XCTAssertFalse(twoPset1.contains(fixture2))
        XCTAssertFalse(twoPset1.compare(twoPset2))
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
        
        XCTAssertTrue(twoPset1.compare(twoPset2))
        XCTAssertFalse(twoPset1.compare(twoPset3))
        XCTAssertFalse(twoPset1.compare(twoPset4))
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
        XCTAssertTrue(twoPsetMerged.compare(twoPset4))
    }
}
