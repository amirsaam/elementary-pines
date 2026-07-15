/// Size variants for `pinesSwitch(labelText:name:id:color:size:checked:disabled:)`.
///
/// Each case maps to a different set of Tailwind height/width/translate
/// classes used for the switch track, knob, and label.
public enum PinesSwitchSize: Sendable {
    /// Default size. Track is `h-6 w-10`, knob is `w-5 h-5`.
    case `default`
    /// Small size. Track is `h-4 w-6`, knob is `w-3 h-3`.
    case small
}
