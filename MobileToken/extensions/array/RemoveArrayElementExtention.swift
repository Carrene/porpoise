
extension Array where Element: Equatable {
    mutating func remove(_ obj: Element) {
        if let index = self.index(where: { $0 == obj }) {
            self.remove(at: index)
        }
    }
}

