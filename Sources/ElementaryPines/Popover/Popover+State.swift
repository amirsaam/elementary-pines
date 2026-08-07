import Foundation

enum PinesPopoverState {
    /// Alpine state for `pinesPopover`, seeded with the `arrow` and `position`
    /// parameters. The panel auto-flips between top/bottom based on the
    /// available viewport space when it opens.
    static func xData(arrow: Bool, position: String) -> String {
        """
        { popoverOpen: false, popoverArrow: \(arrow), popoverPosition: '\(position)', popoverHeight: 0, popoverOffset: 8, popoverHeightCalculate(){ this.$refs.popover.classList.add('invisible'); this.popoverOpen=true; let that=this; $nextTick(function(){ that.popoverHeight=that.$refs.popover.offsetHeight; that.popoverOpen=false; that.$refs.popover.classList.remove('invisible'); that.$refs.popoverInner.setAttribute('x-transition', ''); that.popoverPositionCalculate(); }); }, popoverPositionCalculate(){ if(window.innerHeight < (this.$refs.popoverButton.getBoundingClientRect().top + this.$refs.popoverButton.offsetHeight + this.popoverOffset + this.popoverHeight)){ this.popoverPosition='top'; } else { this.popoverPosition='bottom'; } } }
        """
    }

    /// Root `x-init`: re-calculate the popover position whenever it opens.
    static let rootInit = """
        $watch('popoverOpen', function(value){ if(value){ popoverPositionCalculate(); } });
        """

    /// Panel `x-init`: measure the panel height once it is in the DOM.
    static let panelInit = """
        setTimeout(function(){ popoverHeightCalculate(); }, 100);
        """
}
