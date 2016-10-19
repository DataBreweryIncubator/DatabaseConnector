//
//  Result.swift
//

/// Query fetch result. Can represent three states: `empty` when there is no
/// more data avilable, `data` when values were fetched or `failure` when an
/// error or another kind of signal occured.
public enum FetchResult {
	case empty
	case data(Row)
	case failure(String)

	/// Returns `true` if the result is empty.
	var isEmpty: Bool {
		switch self {
		case .empty: return true
		default: return false
		}
	}

	/// Returns `true` if the result is failure.
	var isFailure: Bool {
		switch self {
		case .failure: return true
		default: return false
		}
	}
}


public func ==(left: FetchResult, right: FetchResult) -> Bool {
	switch (left, right) {
	case (.empty, .empty): return true
	case (.data(let lv), .data(let rv)) where lv == rv: return true
	case (.failure(let lv), .failure(let rv)) where lv == rv: return true
	default: return false
	}
}


/// Represents a tuple of values.
public protocol Row {
	/// Array of values.
	var values: [Value] { get }

	/// Returns a value at position `index`
	subscript(index: Int) -> Value { get }

	/// Returns a value at first column with name `name`
	subscript(name: String) -> Value? { get }
}

public func ==(left: Row, right: Row) -> Bool {
	return left.values == right.values
}

/// Generic result wrapper
public enum Result<T> {
	public typealias Value = T
	case success(Value)
	case failure(String)

	var isFailure: Bool {
		switch self {
		case .success: return false
		case .failure: return true
		}
	}
}


public func ==<T:Equatable>(left: Result<T>, right: Result<T>) -> Bool {
	switch (left, right) {
	case (.success(let lv), .success(let rv)) where lv == rv: return true
	case (.failure(let lv), .failure(let rv)) where lv == rv: return true
	default: return false
	}
}

