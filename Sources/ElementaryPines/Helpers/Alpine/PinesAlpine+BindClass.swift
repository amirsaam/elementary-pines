import Elementary
import ElementaryAlpine

func pinesAlpineBindClass(
    _ branches: [(className: String, condition: String)]
) -> HTMLAttributeValue.Alpine.BindClass {
    let value =
        branches
        .map { "'\($0.className)' : \($0.condition)" }
        .joined(separator: ", ")
    return .init(rawValue: "{ \(value) }")
}
