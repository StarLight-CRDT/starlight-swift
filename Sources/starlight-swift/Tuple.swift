
public struct Tuple<Left, Right>: Hashable where Left: Hashable, Right: Hashable {
    let left: Left;
    let right: Right;

    public static func == (lhs: Tuple<Left, Right>, rhs: Tuple<Left, Right>) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(left)
        hasher.combine(right)
    }
}