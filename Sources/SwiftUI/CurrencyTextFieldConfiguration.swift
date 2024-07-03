//
//  CurrencyTextField.swift
//  
//
//  Created by Marino Felipe on 11.04.21.
//

#if canImport(CurrencyFormatter)
import CurrencyFormatter
#endif

import Foundation
import struct SwiftUI.Binding

import UIKit

/// A type that hold all configuration and settings for a currency text field.
@available(iOS 13.0, *)
public final class CurrencyTextFieldConfiguration {
    let placeholder: String

    @Binding
    var text: String

    @OptionalBinding
    private(set) var unformattedText: Binding<String?>?

    @OptionalBinding
    private(set) var inputAmount: Binding<Double?>?

    @OptionalBinding
    private(set) var hasFocus: Binding<Bool?>?

    let clearsWhenValueIsZero: Bool

    @Binding
    var formatter: CurrencyFormatter

    let onCommit: (() -> Void)?

    let onEditingChanged: ((Bool) -> Void)?

    let textFieldConfiguration: ((UITextField) -> Void)?

    /// Creates a default `CurrencyTextFieldConfiguration` instance with base properties set.
    ///
    /// - Parameters:
    ///   - text: The text to display and edit.
    ///   - hasFocus: Binding property to keep track and drive UITextField responder state.
    ///   - formatter: Currency formatter binding that will be used by the TextField. It holds all formatting related settings, such
    ///   as currency, locale, hasDecimals, etc, and propagates formatting updates.
    /// - Returns: Initialized instance of `CurrencyTextFieldConfiguration`.
    ///
    /// - note: Only text and formatter are set. When additional configurations are needed, like performing actions on text field
    /// events, or configuring the underlying text field, the initializer can be used instead.
    public static func makeDefault(
        text: Binding<String>,
        hasFocus: Binding<Bool?>? = nil,
        formatter: Binding<CurrencyFormatter>
    ) -> Self {
        .init(
            text: text,
            hasFocus: hasFocus,
            formatter: formatter,
            textFieldConfiguration: nil,
            onEditingChanged: nil,
            onCommit: nil
        )
    }

    /// Creates a CurrencyTextField configuration with given properties.
    ///
    /// - Parameters:
    ///   - placeholder: Text that is shown when the text field is empty, describes its purpose.
    ///   - text: The text to display and edit.
    ///   - unformattedText: Binding property that gives the latest unformatted text field text.
    ///   - inputAmount: Binding property that gives the latest Double value for text field text.
    ///   - hasFocus: Binding property to keep track and drive UITextField responder state.
    ///   - clearsWhenValueIsZero: When `true` the text field text is cleared when user finishes editing with value as zero,
    ///   otherwise if `false` the text field text will keep it's text when value is zero.
    ///   - formatter: Currency formatter binding that will be used by the TextField. It holds all formatting related settings, such
    ///   as currency, locale, hasDecimals, etc, and propagates formatting updates.
    ///   - textFieldConfiguration: Closure to `configure the underlying UITextField`.
    ///   Unfortunately, so far, for many things there are no APIs provided by Apple to go from SwiftUI to UIKit,
    ///   like conversion of Font to UIFont. This configuration block allows the user to configure
    ///   the underlying `UITextField` as they wish. Use this block to set any UITextField specific property as `.borderStyle`,
    ///   `.keyboardType`, `.font`, `.textColor`, etc.
    ///   - onEditingChanged: The action to perform when the user
    ///     begins editing `text` and after the user finishes editing `text`.
    ///     The closure receives a Boolean value that indicates the editing
    ///     status: `true` when the user begins editing, `false` when they
    ///     finish.
    ///   - onCommit: An action to perform when the user performs an action
    ///     (for example, when the user presses the Return key) while the text
    ///     field has focus.
    public init(
        placeholder: String = "",
        text: Binding<String>,
        unformattedText: Binding<String?>? = nil,
        inputAmount: Binding<Double?>? = nil,
        hasFocus: Binding<Bool?>? = nil,
        clearsWhenValueIsZero: Bool = false,
        formatter: Binding<CurrencyFormatter>,
        textFieldConfiguration: ((UITextField) -> Void)?,
        onEditingChanged: ((Bool) -> Void)? = nil,
        onCommit: (() -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.unformattedText = unformattedText
        self.inputAmount = inputAmount
        self.hasFocus = hasFocus
        self._formatter = formatter
        self.clearsWhenValueIsZero = clearsWhenValueIsZero
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.textFieldConfiguration = textFieldConfiguration
    }
}
