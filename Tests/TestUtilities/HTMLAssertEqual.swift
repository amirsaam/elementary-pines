import Elementary
import XCTest

/// Asserts that the rendered HTML of `html` matches the `expected` string
/// byte-for-byte.
///
/// On failure, both the expected and actual rendered HTML are printed so
/// the diff is obvious.
///
/// Snapshot test pattern: read the expected string from a fixture file
/// under `Tests/<TestTarget>/SnapshotFixtures/`, pass it as `expected`:
///
/// ```swift
/// let expected = try String(contentsOf: snapshotURL, encoding: .utf8)
/// HTMLAssertEqual(button { "Save" }.pinesButtonStyle(.solid), expected)
/// ```
public func HTMLAssertEqual(
    _ html: some HTML,
    _ expected: String,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    let actual = html.render()
    if actual != expected {
        XCTFail(
            """
            Rendered HTML did not match expected.

            Expected:
            \(expected)

            Actual:
            \(actual)
            """,
            file: file,
            line: line
        )
    }
}
