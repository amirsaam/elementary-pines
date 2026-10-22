import Elementary

/// Type-safe toast type mirroring the `window.toast` `type` option.
public enum PinesToastType: String, Sendable, CaseIterable {
    case `default`
    case success
    case info
    case warning
    case danger
}

/// Type-safe toast position mirroring the `window.toast` `position` option.
public enum PinesToastPosition: String, Sendable, CaseIterable {
    case topLeft = "top-left"
    case topCenter = "top-center"
    case topRight = "top-right"
    case bottomLeft = "bottom-left"
    case bottomCenter = "bottom-center"
    case bottomRight = "bottom-right"
}

/// Type-safe invocation for `window.toast(message, { type, description, position, html })`.
///
/// Use ``js`` in Alpine handlers (e.g. `.x.on("click", invocation.js)`) or
/// ``script()`` to emit a one-shot `<script>` for server flashes.
///
/// ```swift
/// let inv = PinesToastInvocation(message: "Saved", type: .success, position: .topCenter)
/// button(.x.on("click", inv.js)) { "Save" }.pinesButtonStyle(.solid)
/// ```
public struct PinesToastInvocation: Sendable {
    public var message: String
    public var type: PinesToastType
    public var description: String?
    public var position: PinesToastPosition
    public var html: String?
    public var container: String?

    public init(
        message: String,
        type: PinesToastType = .default,
        description: String? = nil,
        position: PinesToastPosition = .topCenter,
        html: String? = nil,
        container: String? = nil
    ) {
        self.message = message
        self.type = type
        self.description = description
        self.position = position
        self.html = html
        self.container = container
    }

    /// JavaScript expression that dispatches the toast. Use in `.x.on("click", invocation.js)`.
    public var js: String {
        var opts: [String] = [
            "type: \(pinesJavaScriptStringLiteral(type.rawValue))",
            "position: \(pinesJavaScriptStringLiteral(position.rawValue))",
        ]
        if let description {
            opts.append("description: \(pinesJavaScriptStringLiteral(description))")
        }
        if let html {
            opts.append("html: \(pinesJavaScriptStringLiteral(html))")
        }
        if let container {
            opts.append("container: \(pinesJavaScriptStringLiteral(container))")
        }
        return "window.toast(\(pinesJavaScriptStringLiteral(message)), { \(opts.joined(separator: ", ")) })"
    }

    /// `<script>` element that fires the toast on `DOMContentLoaded`. Useful for flash after redirect.
    public func script() -> some HTML {
        HTMLRaw("<script>document.addEventListener('DOMContentLoaded',()=>{\(js)})</script>")
    }
}
