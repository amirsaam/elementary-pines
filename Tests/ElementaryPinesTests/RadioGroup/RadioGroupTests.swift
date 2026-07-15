import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class RadioGroupTests: XCTestCase {
    func testBasic() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRadioGroup-basic.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRadioGroup(
                options: [
                    .init(title: "Small", value: "sm"),
                    .init(title: "Medium", value: "md", description: "Recommended"),
                    .init(title: "Large", value: "lg", description: "Extra room"),
                ],
                name: "size"
            ),
            expected
        )
    }

    func testWithoutDescription() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRadioGroup-withoutDescription.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRadioGroup(
                options: [
                    .init(title: "Option A", value: "a"),
                    .init(title: "Option B", value: "b"),
                ],
                name: "choice"
            ),
            expected
        )
    }

    func testDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRadioGroup-disabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRadioGroup(
                options: [
                    .init(title: "Yes", value: "yes"),
                    .init(title: "No", value: "no"),
                    .init(title: "Maybe", value: "maybe"),
                ],
                name: "answer",
                disabled: true
            ),
            expected
        )
    }

    func testPerOptionDisabled() throws {
        let expected = try String(
            contentsOf: fixtureURL("pinesRadioGroup-perOptionDisabled.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesRadioGroup(
                options: [
                    .init(title: "Available", value: "yes"),
                    .init(title: "Out of stock", value: "no", disabled: true),
                    .init(title: "Maybe", value: "maybe"),
                ],
                name: "choice"
            ),
            expected
        )
    }
}
