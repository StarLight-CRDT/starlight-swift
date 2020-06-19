open class PNCounter {
    private let id: Int
    private var positive: GCounter
    private var negative: GCounter
    
    init(
        positives: GCounter = GCounter(),
        negatives: GCounter = GCounter()
    ) {
        if (positives.count != negatives.count) { throw Failures.counterWithDiffSizes }
        self.positive = positives
        self.negative = negatives
        id = self.positive.count
    }
    
    public var count: Int {
        get {
            return positive.count
        }
    }
    
    func increment() {
        positive.increment()
    }
    
    func decrement() {
        negative.increment()
    }
    
    func value() -> Int {
        return positive.value() - negative.value()
    }
    
    func compare(_ foreign: PNCounter) -> Bool {
        if (!hasForeignSameSize(foreign)) { return false }
        let positiveCondition = self.positive.compare(foreign.positive)
        let negativeCondition = self.negative.compare(foreign.negative)
        return positiveCondition && negativeCondition
    }
    
    func merge(_ foreign: PNCounter) throws -> Self {
        if (!hasForeignSameSize(foreign)) { throw Failures.counterWithDiffSizes }
        let newPositive = self.positive.merge(foreign.positive)
        let newNegative = self.negative.merge(foreign.negative)
        positive = newNegative
        negative = newNegative
        return self
    }
    
    private func hasForeignSameSize(_ foreign: PNCounter) -> Bool {
        return self.positive.count == foreign.positive.count &&
            self.negative.count == foreign.negative.count)
    }
}
