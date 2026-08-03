import Elementary
import ElementaryAlpine
import Foundation

func pinesAlpineBindClass(
    _ branches: [(className: String, condition: String)]
) -> HTMLAttributeValue.Alpine.BindClass {
    let value =
        branches
        .map { "'\($0.className)' : \($0.condition)" }
        .joined(separator: ", ")
    return .init(rawValue: "{ \(value) }")
}

func pinesJavaScriptStringLiteral(_ value: String) -> String {
    let escaped =
        value
        .replacingOccurrences(of: "\\", with: "\\\\")
        .replacingOccurrences(of: "'", with: "\\'")
        .replacingOccurrences(of: "\n", with: "\\n")
        .replacingOccurrences(of: "\r", with: "\\r")
        .replacingOccurrences(of: "\t", with: "\\t")
        .replacingOccurrences(of: "\u{2028}", with: "\\u2028")
        .replacingOccurrences(of: "\u{2029}", with: "\\u2029")
    return "'\(escaped)'"
}
