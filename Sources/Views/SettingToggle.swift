//
//  SettingToggle.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A simple toggle.
 */
public struct SettingToggle: View, Setting {
    public var id: AnyHashable?
    public var title: String
    @Binding public var isOn: Bool
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding: CGFloat? = nil
    public var isEnabled: Bool
    public var valueChangedTo: (Bool, String) -> Void

    public init(
        id: AnyHashable? = nil,
        title: String,
        isOn: Binding<Bool>,
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat? = nil,
        isEnabled: Bool,
        valueChangedTo: @escaping (Bool, String) -> Void
    ) {
        self.id = id
        self.title = title
        self._isOn = isOn
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.isEnabled = isEnabled
        self.valueChangedTo = valueChangedTo
    }

    public var body: some View {
        SettingToggleView(
            title: title,
            isOn: $isOn,
            isEnabled: isEnabled,
            horizontalSpacing: horizontalSpacing,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding,
            valueChangedTo: valueChangedTo
        )
    }
}

struct SettingToggleView: View {
    @Environment(\.edgePadding) var edgePadding
    
    let title: String
    @Binding var isOn: Bool
    let isEnabled: Bool

    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding: CGFloat? = nil
    var valueChangedTo: (Bool, String) -> Void

    var body: some View {
        HStack(spacing: horizontalSpacing) {
            Text(title + (isEnabled ? "" : " is disabled"))
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, verticalPadding)
                .foregroundStyle(isEnabled ? .primary : .secondary)
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .disabled( !isEnabled)
                .onChange(of: isOn) { state in
                    valueChangedTo (state, title)
                }
        }
        .padding(.horizontal, horizontalPadding ?? edgePadding)
        .accessibilityElement(children: .combine)
    }
}
