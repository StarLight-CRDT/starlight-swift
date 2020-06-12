open class GSet<T> where T: Hashable {

    private var data: Set<T>

    public var dataset: Set<T> {
        get {
            return data
        }
    }

    init() {
        data = .init()
    }
    
    public var count: Int {
        get {
            return data.count
        }
    }

    public func add(_ input: T) {
        data.insert(input)
    }

    public func contains(_ input: T) -> Bool {
        return data.contains(input)
    }

    public func compare(_ foreign: GSet<T>) -> Bool {
        if (data.count != foreign.count) { return false }
        return data.allSatisfy { foreign.contains($0) }
    }

    public func merge(_ foreign: GSet<T>) -> Self {
        data = data.union(foreign.dataset)
        return self
    }
}
