open class PNCounter {
    private let id: Int
    private var positive: GCounter
    private var negative: GCounter
    
    init(positives: GCounter, negatives: GCounter) throws {
        if (positives.count != negatives.count) { throw Failures.counterWithDiffSizes }
        self.positive = positives
        self.negative = negatives
        id = self.positive.count
    }

    convenience init() {
        try! self.init(positives: GCounter(), negatives: GCounter()) 
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
        do {
            let newPositive = try positive.merge(foreign.positive)
            let newNegative = try negative.merge(foreign.negative)
            positive = newPositive
            negative = newNegative
        } catch (let err) {
            throw err
        }
        return self
    }
    
    private func hasForeignSameSize(_ foreign: PNCounter) -> Bool {
        return 
            self.positive.count == foreign.positive.count &&
            self.negative.count == foreign.negative.count
    }
}
