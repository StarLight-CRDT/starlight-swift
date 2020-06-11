open class TwoPhaseSet<T> where T: Hashable {

    private var data: GSet<T>
    private var tomb: GSet<T>

    public var dataset: GSet<T> {
        get {
            return data
        }
    }

    public var tombstone: GSet<T> {
        get {
            return tomb
        }
    }
    
    public var count: Int {
        get {
            return data.count - tomb.count
        }
    }

    init() {
        data = GSet<T>()
        tomb = GSet<T>()
    }

    public func contains(_ input: T) -> Bool {
        return data.contains(input) && !tomb.contains(input)
    }

    public func add(_ input: T) {
        data.add(input)
    }

    public func remove(_ input: T) {
        if self.contains(input) {
            tomb.add(input)
        }
    }

    public func compare(_ foreign: TwoPhaseSet<T>) -> Bool {
        if (count != foreign.count) { return false }
        return dataset.compare(foreign.dataset) && tombstone.compare(foreign.tombstone)
    }

    public func merge(_ foreign: TwoPhaseSet<T>) -> Self {
        data = data.merge(foreign.dataset)
        tomb = tomb.merge(foreign.tomb)
        return self
    }
}
