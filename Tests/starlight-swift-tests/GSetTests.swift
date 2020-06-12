import XCTest
@testable import starlight_swift

final class GSetTests: XCTestCase {

    let fixture1 = Dummy(field1: "Luke", field2: 20)
    let fixture2 = Dummy(field1: "Lea", field2: 26)
    let fixture3 = Dummy(field1: "Han", field2: 42)
    let fixture4 = Dummy(field1: "Chewbacca", field2: 43)

    func testAdd() {
        let gset = GSet<Dummy>()
        gset.add(fixture1)
        gset.add(fixture2)
        gset.add(fixture3)
        
        XCTAssertEqual(gset.count, 3)
    }
    
    func testContains() {
        let gset = GSet<Dummy>()
        gset.add(fixture1)
        
        XCTAssertEqual(gset.contains(fixture1), true)
    }
    
    func testCompare() {
        let gset = GSet<Dummy>()
        gset.add(fixture1)
        gset.add(fixture2)
        gset.add(fixture3)
        
        let gset2 = GSet<Dummy>()
        gset2.add(fixture1)
        gset2.add(fixture2)
        gset2.add(fixture3)
        
        let gset3 = GSet<Dummy>()
        gset3.add(fixture1)
        gset3.add(fixture2)
        
        let gset4 = GSet<Dummy>()
        gset4.add(fixture1)
        gset4.add(fixture2)
        gset4.add(fixture3)
        gset4.add(fixture4)
        
        XCTAssertEqual(gset.compare(gset2), true)
        XCTAssertEqual(gset.compare(gset3), false)
        XCTAssertEqual(gset.compare(gset4), false)
    }
    
    func testMerge() {
        let gset = GSet<Dummy>()
        gset.add(fixture1)
        gset.add(fixture2)
        gset.add(fixture3)
        
        let gset2 = GSet<Dummy>()
        gset2.add(fixture1)
        gset2.add(fixture2)
        gset2.add(fixture4)
        
        let gset3 = GSet<Dummy>()
        gset3.add(fixture1)
        gset3.add(fixture2)
        gset3.add(fixture3)
        gset3.add(fixture4)
        
        let gset4: GSet<Dummy> = gset.merge(gset2)
        XCTAssertEqual(gset4.compare(gset3), true)
    }
}
