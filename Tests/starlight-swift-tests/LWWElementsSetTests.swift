import XCTest
@testable import starlight_swift

final class LWWElementSetTests: XCTestCase {

    let fixture1 = Dummy(field1: "Luke", field2: 20)
    let fixture2 = Dummy(field1: "Lea", field2: 26)
    let fixture3 = Dummy(field1: "Han", field2: 42)
    let fixture4 = Dummy(field1: "Chewbacca", field2: 43)

    var time: Double = 0.0;
    var tick: LWWElementSet<Dummy>.Tick!

    override func setUp() {
        self.time = 0.0
        self.tick = {
            self.time = self.time + 1;
            return self.time
        }
    }

    func testAdd() {
        let lwwSet = LWWElementSet<Dummy>(tick)

        XCTAssertEqual(lwwSet.add(fixture1).left, 1.0)
        XCTAssertEqual(lwwSet.add(fixture2).left, 2.0)
        XCTAssertEqual(lwwSet.add(fixture3).left, 3.0)

        XCTAssertEqual(lwwSet.count, 3)
    }

    func testRemove() {
        let lwwSet = LWWElementSet<Dummy>(tick)

        lwwSet.add(fixture1)
        let remove = lwwSet.add(fixture2)
        lwwSet.add(fixture3)
        
        lwwSet.remove(remove)

        XCTAssertEqual(lwwSet.count, 2)
        XCTAssertEqual(lwwSet.tombstone.count, 1)
    }

    func testMerge() {
        let lwwSet1 = LWWElementSet<Dummy>(tick)
        let lwwSet2 = LWWElementSet<Dummy>(tick)

        lwwSet1.add(fixture1)
        lwwSet1.add(fixture2)
        
        lwwSet2.add(fixture3)
        lwwSet2.add(fixture2)

        let lwwSet3 = lwwSet1.merge(lwwSet2)
        
        XCTAssertEqual(lwwSet3.count, 4)
    }
}