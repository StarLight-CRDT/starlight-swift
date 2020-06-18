open class GCounter {

    enum Failures: Error {
        case counterWithDiffSizes
    }

    private let id: Int
    private var nodes: [Int]

    public var count: Int {
        get {
            return nodes.count
        }
    }

    init(nodes: [Int] = []) {
        self.nodes = nodes;
        id = self.nodes.count
        self.nodes.append(0)
    }

    func increment() {
        nodes[id] = nodes[id] + 1 
    }

    func value() -> Int {
        return nodes.reduce(0, +)
    }

    func value(_ index: Int) -> Int {
        return self.nodes[index]
    }

    func compare(_ foreign: GCounter) -> Bool {
        if(self.count != foreign.count) { return false }
        return self.nodes.enumerated().allSatisfy { (index, element) in
            return element <= foreign.value(index)
        }
    }

    func merge(_ foreign: GCounter) throws -> Self {
        if(self.count != foreign.count) { throw Failures.counterWithDiffSizes } 
        let result = self.nodes.enumerated().map { (index, element) in 
            return max(element, foreign.value(index))
        }
        self.nodes = result
        return self
    }
}
