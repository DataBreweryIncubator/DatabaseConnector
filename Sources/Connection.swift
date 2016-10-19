//
//  Connection.swift

/// Type that provides SQL statement execution.
///
public protocol ConnectionProtocol {
	associatedtype Cursor: CursorProtocol
	/// Executes statement and returns a query result.
	func execute(statement: String) -> ExecutionResult<Cursor>
}

/// Represents query execution result. Might either be a `success` and hold a
/// cursor or it might be a failure and hold an error.
public enum ExecutionResult<T> {
	case success(T)
	case failure(String)

	/// - Returns: `true` if the result is failure
	var isFailure: Bool {
		switch self {
		case .failure: return true
		default: return false
		}
	}
}

/// Type that provides interface for fetching rows
public protocol CursorProtocol: Sequence {
	associatedtype Iterator

	/// Returns number of columns the result row contains.
	var columnCount: Int { get }
	/// Returns an array of column names.
	var columnNames: [String] { get }

	/// Fetches next row from the database connection
	func fetchRow() -> FetchResult
	/// Fetches next row and closes the connection. Returns the first value in
	/// the fetched row.
	func fetchScalar() -> Result<Value>
	
	func makeIterator() -> Iterator
}

