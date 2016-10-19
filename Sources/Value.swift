//
//  Value.swift
//  SQLConnector
//
//  Created by Stefan Urbanek on 2016-05-01.
//  Copyright (c) 2016 Stefan Urbanek. All rights reserved.
//  Licensed under MIT License
//


/// Value of base data types
public enum Value: Equatable {
	case bool(Swift.Bool)
	case int(Swift.Int)
	case double(Swift.Double)
	case text(String)

	case null
	/// Indicates that it was not possible to correctly fetch or convert the
	/// value. Also used when certain data types are not supported by the
	/// adaptor.
	case error(String)
	/*
	Future cases:

	case date(?)
	case time(?)
	case dateTime(?)
	case blob(?)
	case array([Value])
	case map([Value:Value])

	case object(AnyObject)
	*/
	
	/// Returns string representation of the value or `nil` if it is `nil` or
	/// if it can't be converted.
	public var stringValue: Swift.String? {
		switch self{
		case .null, .error: return nil
		case let .bool(val): return Swift.String(val)
		case let .int(val): return Swift.String(val)
		case let .double(val): return Swift.String(val)
		case let .text(val): return val
		}
	}

	/// Returns boolean representation of the value or `nil` if it is `nil` or
	/// if it can't be converted. Returns `false` if numeric value is 0,
	/// otherwise returns `true`. For string values always returns nil, as
	/// there might be many representations of boolean values.
	public var boolValue: Swift.Bool? {
		switch self {
		case .null, .error: return nil
		case let .bool(val): return Swift.Bool(val)
		case let .int(val): return Swift.Bool(val != 0)
		case let .double(val): return Swift.Bool(val != 0)
		case .text(_): return nil
		}
	}

	/// Returns integer representation of the value or `nil` if it is `nil` or
	/// if it can't be converted. For boolean values returns 1 for `true` and 0
	/// for `false`.
	public var intValue: Swift.Int? {
		switch self{
		case .null, .error: return nil
		case let .bool(val):
			if val {
				return Swift.Int(1)
			}
			else {
				return Swift.Int(0)
			}
		case let .int(val): return val
		case let .double(val): return Swift.Int(val)
		case let .text(val): return Swift.Int(val)
		}
	}

	/// Returns double representation of the value or `nil` if it is `nil` or
	/// if it can't be converted. For boolean values returns 1.0 for `true` and
	/// 0 for `false`.
	public var doubleValue: Swift.Double? {
		switch self{
		case .null, .error: return nil
		case let .bool(val):
			if val {
				return Swift.Double(1)
			}
			else {
				return Swift.Double(0)
			}
		case let .int(val): return Swift.Double(val)
		case let .double(val): return Swift.Double(val)
		case let .text(val): return Swift.Double(val)
		}
	}
}

public func ==(left: Value, right: Value) -> Bool {
	switch (left, right) {
	case (.null, .null): return true
	case (.bool(let lv), .bool(let rv)) where lv == rv: return true
	case (.int(let lv), .int(let rv)) where lv == rv: return true
	case (.double(let lv), .double(let rv)) where lv == rv: return true
	case (.text(let lv), .text(let rv)) where lv == rv: return true
	default: return false
	}
}
