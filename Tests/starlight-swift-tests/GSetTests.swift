import XCTest
@testable import starlight_swift

final class GSetTests: XCTestCase {

    let fixture1 = Dummy(field1: "Marcos 1", field2: 42)
    let fixture2 = Dummy(field1: "Marcos 2", field2: 42)
    let fixture3 = Dummy(field1: "Marcos 3", field2: 42)
    let fixture4 = Dummy(field1: "Marcos 4", field2: 42)

    func testAdd() {
        let gset: CRDTSet<Dummy> = GSet<Dummy>()
        gset.add(fixture1)
        gset.add(fixture2)
        gset.add(fixture3)
        XCTAssertEqual(gset.dataset.count, 3)
    }
}
