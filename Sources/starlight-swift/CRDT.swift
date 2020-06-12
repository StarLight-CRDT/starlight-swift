open class CRDTSet<T> where T: Hashable {

    public var dataset: Set<T> {
        get {
            fatalError()
        }
    }
    
    public var count: Int {
        get {
            fatalError()
        }
    }

    public func add(_ input: T) { fatalError() }

    public func contains(_ input: T) -> Bool { fatalError() }

    public func compare(_ foreign: CRDTSet<T>) -> Bool { fatalError() }

    public func merge(_ foreign: CRDTSet<T>) -> CRDTSet<T> { fatalError() }
}
