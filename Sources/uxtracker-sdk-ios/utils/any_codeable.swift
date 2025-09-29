//
//  any_codeable.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 30/08/25.
//

import Foundation

enum AnyCodable: Codable, Sendable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)

    var value: Any {
        switch self {
        case .string(let v): return v
        case .int(let v): return v
        case .double(let v): return v
        case .bool(let v): return v
        }
    }

    init(_ value: some Sendable) {
        switch value {
        case let v as String: self = .string(v)
        case let v as Int: self = .int(v)
        case let v as Double: self = .double(v)
        case let v as Bool: self = .bool(v)
        default:
            preconditionFailure("Unsupported type: \(type(of: value))")
        }
    }

    // Codable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let v): try container.encode(v)
        case .int(let v): try container.encode(v)
        case .double(let v): try container.encode(v)
        case .bool(let v): try container.encode(v)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let v = try? container.decode(String.self) { self = .string(v) }
        else if let v = try? container.decode(Int.self) { self = .int(v) }
        else if let v = try? container.decode(Double.self) { self = .double(v) }
        else if let v = try? container.decode(Bool.self) { self = .bool(v) }
        else { throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unsupported type") }
    }
}

extension AnyCodable {
    static func safeWrap(_ value: Any) -> AnyCodable? {
        switch value {
        case let v as String: return .string(v)
        case let v as Int: return .int(v)
        case let v as Double: return .double(v)
        case let v as Bool: return .bool(v)
        default: return nil // Non-supported types are ignored
        }
    }
}
