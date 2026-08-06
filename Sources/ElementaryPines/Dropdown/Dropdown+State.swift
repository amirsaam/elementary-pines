import Elementary

/// Alpine state and keyboard navigation for `pinesDropdown`.
enum PinesDropdownState {
    static let xData =
        """
        {
        dropdownOpen: false,
        activeIndex: 0,
        openDropdown(){ \
        this.dropdownOpen = true; \
        this.$nextTick(() => { \
        const items = [...this.$refs.dropdownPanel.querySelectorAll('[data-dropdown-item]')]; \
        if (items.length) { items[this.activeIndex]?.focus(); } \
        }); \
        }, \
        closeDropdown(){ \
        this.dropdownOpen = false; \
        this.$refs.dropdownButton?.focus(); \
        }, \
        moveTo(index){ \
        const items = [...this.$refs.dropdownPanel.querySelectorAll('[data-dropdown-item]')]; \
        if (items.length === 0) { return; } \
        this.activeIndex = (index + items.length) % items.length; \
        items[this.activeIndex]?.focus(); \
        }, \
        moveNext(){ this.moveTo(this.activeIndex + 1); }, \
        movePrev(){ this.moveTo(this.activeIndex - 1); } \
        }
        """
}
