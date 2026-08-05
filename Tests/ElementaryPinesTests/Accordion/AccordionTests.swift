import Elementary
import ElementaryPines
import TestUtilities
import XCTest

final class AccordionTests: XCTestCase {
    func testAccordionMultipleItems() throws {
        let expected = try String(
            contentsOf: fixtureURL("accordion-multiple.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAccordion(items: [
                .init(title: "What is Pines?", body: "Pines is a collection of Alpine.js and Tailwind CSS components."),
                .init(title: "How do I install it?", body: "Add the package as a SwiftPM dependency."),
                .init(title: "Is it free?", body: "Yes, Pines is free and open source."),
            ]),
            expected
        )
    }

    func testAccordionSingleItem() throws {
        let expected = try String(
            contentsOf: fixtureURL("accordion-single.html"),
            encoding: .utf8
        )
        HTMLAssertEqual(
            pinesAccordion(items: [
                .init(title: "Getting started", body: "Install the package and call setupPines().")
            ]),
            expected
        )
    }
}
