open class GSet<T>: CRDTSet<T> where T: Hashable {

    private var data: Set<T>

    override public var dataset: Set<T> {
        get {
            return data
        }
    }

    override init() {
        data = .init()
    }
    
    override public var count: Int {
        get {
            return data.count
        }
    }

    override public func add(_ input: T) {
        data.insert(input)
    }

    override public func contains(_ input: T) -> Bool {
        return data.contains(input)
    }

    override public func compare(_ foreign: CRDTSet<T>) -> Bool {
        if (data.count != foreign.count) { return false }
        return data.allSatisfy { foreign.contains($0) }
    }

    override public func merge(_ foreign: CRDTSet<T>) -> Self {
        data = data.union(foreign.dataset)
        return self
    }
}
