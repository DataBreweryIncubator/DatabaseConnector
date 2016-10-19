public enum DataType: Equatable {
	case bool
	case int
	case double
	case text

	/// Represents NULL value
	case null
	/// Represents errorneous data type (failure)
	case error(String)

	// TODO: Future:
	// case date
	// case time
	// case datetime
	// case timestamp
	// case blob

	// Collections
	// case array
	// case map
}

public func ==(lhs: DataType, rhs: DataType) -> Bool {
	switch (lhs, rhs) {
	case (.bool, .bool): return true
	case (.int, .int): return true
	case (.double, .double): return true
	case (.text, .text): return true
	case (.null, .null): return true
	case let (.error(le), .error(re)) where le == re: return true
	default: return false
	}
}
