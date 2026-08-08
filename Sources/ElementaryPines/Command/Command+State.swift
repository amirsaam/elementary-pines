import Elementary

/// Alpine state and search/keyboard logic for `pinesCommand`.
enum PinesCommandState {
    static func xData(items: [PinesCommandItem]) -> String {
        let itemsJS = items.map(pinesCommandItemJS).joined(separator: ", ")
        return
            """
            {
            commandItems: [\(itemsJS)],
            commandItemsFiltered: [],
            commandItemActive: null,
            commandItemSelected: null,
            commandId: $id('command'),
            commandSearch: '',
            commandSearchIsEmpty(){ return this.commandSearch.length == 0; },
            commandItemIsActive(item){ return this.commandItemActive && this.commandItemActive.value == item.value; },
            commandItemActiveNext(){ let index = this.commandItemsFiltered.indexOf(this.commandItemActive); if (index < this.commandItemsFiltered.length - 1) { this.commandItemActive = this.commandItemsFiltered[index + 1]; this.commandScrollToActiveItem(); } },
            commandItemActivePrevious(){ let index = this.commandItemsFiltered.indexOf(this.commandItemActive); if (index > 0) { this.commandItemActive = this.commandItemsFiltered[index - 1]; this.commandScrollToActiveItem(); } },
            commandScrollToActiveItem(){ if (this.commandItemActive) { let el = document.getElementById(this.commandItemActive.value + '-' + this.commandId); if (!el) { return; } let newScrollPos = (el.offsetTop + el.offsetHeight) - this.$refs.commandItemsList.offsetHeight; this.$refs.commandItemsList.scrollTop = newScrollPos > 0 ? newScrollPos : 0; } },
            commandSearchItems(){ if (!this.commandSearchIsEmpty()) { let term = this.commandSearch.replace(/\\*/g, '').toLowerCase(); this.commandItemsFiltered = this.commandItems.filter(item => item.title.toLowerCase().startsWith(term)); this.commandScrollToActiveItem(); } else { this.commandItemsFiltered = this.commandItems.filter(item => item.default); } this.commandItemActive = this.commandItemsFiltered[0]; },
            commandShowCategory(item, index){ if (index == 0) { return true; } if (typeof this.commandItems[index - 1] === 'undefined') { return false; } return item.category != this.commandItems[index - 1].category; },
            commandCategoryCapitalize(string){ return string.charAt(0).toUpperCase() + string.slice(1); },
            commandSelect(item){ if (item.disabled) { return; } this.commandItemSelected = item; if (item.action) { eval(item.action); } }
            }
            """
    }

    private static func pinesCommandItemJS(_ item: PinesCommandItem) -> String {
        let icon = item.icon.map { pinesIcon($0, size: .sm, attributes: [.marginRight(.size(2))]).render() } ?? ""
        let shortcut = item.shortcut.map { pinesJavaScriptStringLiteral($0) } ?? "null"
        let action = item.action.map { pinesJavaScriptStringLiteral($0) } ?? "null"
        return
            "{ title: \(pinesJavaScriptStringLiteral(item.title)), value: \(pinesJavaScriptStringLiteral(item.value)), icon: \(pinesJavaScriptStringLiteral(icon)), default: \(item.isDefault), category: \(pinesJavaScriptStringLiteral(item.category)), right: \(shortcut), disabled: \(item.disabled), action: \(action) }"
    }
}
