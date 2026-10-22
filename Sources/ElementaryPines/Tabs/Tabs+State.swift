enum PinesTabsState {
    static let xData =
        "{ tabSelected: 1, tabId: $id('tabs'), tabButtonClicked(tabButton){ this.tabSelected = tabButton.id.replace(this.tabId + '-', ''); this.tabRepositionMarker(tabButton); }, tabRepositionMarker(tabButton){ this.$refs.tabMarker.style.width = tabButton.offsetWidth + 'px'; this.$refs.tabMarker.style.height = tabButton.offsetHeight + 'px'; this.$refs.tabMarker.style.left = tabButton.offsetLeft + 'px'; }, tabContentActive(tabContent){ return this.tabSelected == tabContent.id.replace(this.tabId + '-content-', ''); }, tabMarkerObserver: null, tabObserveMarker(){ if (this.tabMarkerObserver || typeof ResizeObserver === 'undefined') { return; } this.tabMarkerObserver = new ResizeObserver(() => { let bar = this.$refs.tabButtons; if (bar && bar.firstElementChild) { this.tabRepositionMarker(bar.firstElementChild); } }); this.tabMarkerObserver.observe(this.$refs.tabButtons); } }"

    /// The marker is measured once at init, which yields a zero-sized marker
    /// when the tab group starts out hidden (inside a collapsed section, a
    /// dialog, or a tab panel). Observing the tab bar re-measures it as soon
    /// as it gets a real size.
    static let xInit =
        "tabObserveMarker(); tabRepositionMarker($refs.tabButtons.firstElementChild);"
}
