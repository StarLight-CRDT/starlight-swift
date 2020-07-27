
open class LWWElementSet<T> where T: Hashable {

    public typealias Tick = () -> Double

    private var data: GSet<Tuple<Double, T>>
    private var tomb: GSet<Tuple<Double, T>>
    private var ticker: Tick

    public var dataset: GSet<Tuple<Double, T>> {
        get {
            return data
        }
    }

    public var tombstone: GSet<Tuple<Double, T>> {
        get {
            return tomb
        }
    }
    
    public var count: Int {
        get {
            return data.count - tomb.count
        }
    }

    init(_ tick: @escaping Tick) {
        ticker = tick
        data = GSet<Tuple<Double, T>>()
        tomb = GSet<Tuple<Double, T>>()
    }

    public func contains(_ input: Tuple<Double, T>) -> Bool {
        return data.contains(input) && !tomb.contains(input)
    }

    @discardableResult public func add(_ input: T) -> Tuple<Double, T> {
        let tuple = Tuple<Double, T>(left: ticker(), right: input)
        data.add(tuple)
        return tuple
    }

    public func remove(_ input: Tuple<Double, T> ) {
        if self.contains(input) {
            tomb.add(input)
        }
    }

    public func compare(_ foreign: LWWElementSet<T>) -> Bool {
        return count == foreign.count && dataset.compare(foreign.dataset) && tombstone.compare(foreign.tombstone)
    }

    public func merge(_ foreign: LWWElementSet<T>) -> Self {
        data = data.merge(foreign.dataset)
        tomb = tomb.merge(foreign.tombstone)
        return self
    }
}