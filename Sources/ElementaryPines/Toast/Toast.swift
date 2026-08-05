import Elementary
import ElementaryAlpine
import ElementaryTailwind

private func pinesToastPositionBinding() -> HTMLAttributeValue.Alpine.BindClass {
    pinesAlpineBindClass([
        (
            twValue(.insetRight(.zero), .insetTop(.zero), .marginTop(.size(6), variants: [.sm]), .marginRight(.size(6), variants: [.sm])),
            "position=='top-right'"
        ),
        (
            twValue(.insetLeft(.zero), .insetTop(.zero), .marginTop(.size(6), variants: [.sm]), .marginLeft(.size(6), variants: [.sm])),
            "position=='top-left'"
        ),
        (
            twValue(
                .insetLeft(.fraction("1/2")),
                .translate(.x("1/2"), negative: true),
                .insetTop(.zero),
                .marginTop(.size(6), variants: [.sm])
            ), "position=='top-center'"
        ),
        (
            twValue(
                .insetRight(.zero),
                .insetBottom(.zero),
                .marginRight(.size(6), variants: [.sm]),
                .marginBottom(.size(6), variants: [.sm])
            ), "position=='bottom-right'"
        ),
        (
            twValue(
                .insetLeft(.zero),
                .insetBottom(.zero),
                .marginLeft(.size(6), variants: [.sm]),
                .marginBottom(.size(6), variants: [.sm])
            ), "position=='bottom-left'"
        ),
        (
            twValue(
                .insetLeft(.fraction("1/2")),
                .translate(.x("1/2"), negative: true),
                .insetBottom(.zero),
                .marginBottom(.size(6), variants: [.sm])
            ), "position=='bottom-center'"
        ),
    ])
}

private func pinesToastIcon(_ type: String, _ path: String, fillRule: Bool = true) -> some HTML {
    SVG.svg(
        SVGAttribute(name: "x-show", value: "toast.type=='\(type)'"),
        SVGAttribute(
            name: "class",
            value: twValue(
                .width(.arbitrary("18px")),
                .height(.arbitrary("18px")),
                .marginRight(.size(1.5)),
                .marginLeft(.size(1), negative: true)
            )
        ),
        SVGAttribute(name: "viewBox", value: "0 0 24 24"),
        SVGAttribute(name: "fill", value: "none"),
        SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg")
    ) {
        SVG.path(
            SVGAttribute(name: "fill-rule", value: fillRule ? "evenodd" : nil),
            SVGAttribute(name: "clip-rule", value: fillRule ? "evenodd" : nil),
            SVGAttribute(name: "d", value: path),
            SVGAttribute(name: "fill", value: "currentColor")
        )
    }
}

/// Renders the global Pines UI toast notification stack.
public func pinesToast() -> some HTML {
    let descriptionClass = pinesAlpineBindClass([
        (className: twValue(.paddingLeft(.size(5))), condition: "toast.type!='default'")
    ])
    let html = div(.position(.relative), .width(.auto), .height(.auto), .x.data("")) {
        template(.x.teleport("body")) {
            ul(
                .x.data(PinesToastState.xData),
                .x.on(
                    "set-toasts-layout",
                    "layout=event.detail.layout; if(layout == 'expanded'){ expanded=true; } else { expanded=false; } stackToasts();",
                    modifiers: [.window]
                ),
                .x.on(
                    "toast-show",
                    "event.stopPropagation(); if(event.detail.position){ position = event.detail.position; } toasts.unshift({ id: 'toast-' + Math.random().toString(16).slice(2), show: false, message: event.detail.message, description: event.detail.description, type: event.detail.type, html: event.detail.html });",
                    modifiers: [.window]
                ),
                .x.on("mouseenter", "toastsHovered=true;"),
                .x.on("mouseleave", "toastsHovered=false"),
                .x.setup(
                    "if(layout == 'expanded'){ expanded = true; } stackToasts(); $watch('toastsHovered', function(value){ if(layout == 'default'){ if(position.includes('bottom')){ resetBottom(); } else { resetTop(); } if(value){ expanded = true; if(layout == 'default'){ stackToasts(); } } else { if(layout == 'default'){ expanded = false; setTimeout(function(){ stackToasts(); }, 10) } } } });"
                ),
                .position(.fixed),
                .display(.block),
                .width(.full),
                .zIndex(.arbitrary("99")),
                .maxWidth(.xs, variants: [.sm]),
                .x.bindClass(pinesToastPositionBinding()),
                .x.cloak
            ) {
                template(.x.loop("(toast, index) in toasts"), .x.bind("key", "toast.id")) {
                    li(
                        .x.bind("id", "toast.id"),
                        .x.data("{ toastHovered: false }"),
                        .x.setup(
                            "if(position.includes('bottom')){ $el.firstElementChild.classList.add('toast-bottom'); $el.firstElementChild.classList.add('opacity-0', 'translate-y-full'); } else { $el.firstElementChild.classList.add('opacity-0', '-translate-y-full'); } setTimeout(function(){ setTimeout(function(){ if(position.includes('bottom')){ $el.firstElementChild.classList.remove('opacity-0', 'translate-y-full'); } else { $el.firstElementChild.classList.remove('opacity-0', '-translate-y-full'); } $el.firstElementChild.classList.add('opacity-100', 'translate-y-0'); setTimeout(function(){ stackToasts(); }, 10); }, 5); }, 50); setTimeout(function(){ setTimeout(function(){ $el.firstElementChild.classList.remove('opacity-100'); $el.firstElementChild.classList.add('opacity-0'); if(toasts.length == 1){ $el.firstElementChild.classList.remove('translate-y-0'); $el.firstElementChild.classList.add('-translate-y-full'); } setTimeout(function(){ deleteToastWithId(toast.id) }, 300); }, 5); }, 4000);"
                        ),
                        .x.on("mouseover", "toastHovered=true"),
                        .x.on("mouseout", "toastHovered=false"),
                        .position(.absolute),
                        .width(.full),
                        .transitionDuration(.ms(300)),
                        .transitionTimingFunction(.easeOut),
                        .userSelect(.none),
                        .maxWidth(.xs, variants: [.sm]),
                        .x.bindClass(pinesAlpineBindClass([(className: "toast-no-description", condition: "!toast.description")]))
                    ) {
                        span(
                            .position(.relative),
                            .display(.flex),
                            .flexDirection(.column),
                            .items(.start),
                            .width(.full),
                            .transition(.all),
                            .transitionDuration(.ms(300)),
                            .transitionTimingFunction(.easeOut),
                            .backgroundColor(.white),
                            .borderWidth(.bare),
                            .borderColor(PinesColor.gray.shade(.tint1)),
                            .boxShadow(.arbitrary("0_5px_15px_-3px_rgb(0_0_0_/_0.08)")),
                            .borderRadius(.md, variants: [.sm]),
                            .maxWidth(.xs, variants: [.sm]),
                            .x.bindClass(
                                pinesAlpineBindClass([
                                    (className: "p-4", condition: "!toast.html"), (className: "p-0", condition: "toast.html"),
                                ])
                            )
                        ) {
                            template(.x.when("!toast.html")) {
                                div(.position(.relative)) {
                                    div(
                                        .display(.flex),
                                        .items(.center),
                                        .x.bindClass(
                                            pinesAlpineBindClass([
                                                (twValue(.textColor(PinesColor.green.shade(.base))), "toast.type=='success'"),
                                                (twValue(.textColor(PinesColor.blue.shade(.base))), "toast.type=='info'"),
                                                (twValue(.textColor(PinesColor.orange.shade(.accent))), "toast.type=='warning'"),
                                                (twValue(.textColor(PinesColor.red.shade(.base))), "toast.type=='danger'"),
                                                (twValue(.textColor(PinesColor.gray.shade(.deep))), "toast.type=='default'"),
                                            ])
                                        )
                                    ) {
                                        pinesToastIcon(
                                            "success",
                                            "M12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2ZM16.7744 9.63269C17.1238 9.20501 17.0604 8.57503 16.6327 8.22559C16.2051 7.87615 15.5751 7.93957 15.2256 8.36725L10.6321 13.9892L8.65936 12.2524C8.24484 11.8874 7.61295 11.9276 7.248 12.3421C6.88304 12.7566 6.92322 13.3885 7.33774 13.7535L9.31046 15.4903C10.1612 16.2393 11.4637 16.1324 12.1808 15.2547L16.7744 9.63269Z"
                                        )
                                        pinesToastIcon(
                                            "info",
                                            "M12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2ZM12 9C12.5523 9 13 8.55228 13 8C13 7.44772 12.5523 7 12 7C11.4477 7 11 7.44772 11 8C11 8.55228 11.4477 9 12 9ZM13 12C13 11.4477 12.5523 11 12 11C11.4477 11 11 11.4477 11 12V16C11 16.5523 11.4477 17 12 17C12.5523 17 13 16.5523 13 16V12Z"
                                        )
                                        pinesToastIcon(
                                            "warning",
                                            "M9.44829 4.46472C10.5836 2.51208 13.4105 2.51168 14.5464 4.46401L21.5988 16.5855C22.7423 18.5509 21.3145 21 19.05 21L4.94967 21C2.68547 21 1.25762 18.5516 2.4004 16.5862L9.44829 4.46472ZM11.9995 8C12.5518 8 12.9995 8.44772 12.9995 9V13C12.9995 13.5523 12.5518 14 11.9995 14C11.4473 14 10.9995 13.5523 10.9995 13V9C10.9995 8.44772 11.4473 8 11.9995 8ZM12.0009 15.99C11.4486 15.9892 11.0003 16.4363 10.9995 16.9886L10.9995 16.9986C10.9987 17.5509 11.4458 17.9992 11.9981 18C12.5504 18.0008 12.9987 17.5537 12.9995 17.0014L12.9995 16.9914C13.0003 16.4391 12.5532 15.9908 12.0009 15.99Z"
                                        )
                                        pinesToastIcon(
                                            "danger",
                                            "M2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12C22 17.5228 17.5228 22 12 22C6.47715 22 2 17.5228 2 12ZM11.9996 7C12.5519 7 12.9996 7.44772 12.9996 8V12C12.9996 12.5523 12.5519 13 11.9996 13C11.4474 13 10.9996 12.5523 10.9996 12V8C10.9996 7.44772 11.4474 7 11.9996 7ZM12.001 14.99C11.4488 14.9892 11.0004 15.4363 10.9997 15.9886L10.9996 15.9986C10.9989 16.5509 11.446 16.9992 11.9982 17C12.5505 17.0008 12.9989 16.5537 12.9996 16.0014L12.9996 15.9914C13.0004 15.4391 12.5533 14.9908 12.001 14.99Z"
                                        )
                                        p(
                                            .x.text("toast.message"),
                                            .fontSize(.arbitrary("13px")),
                                            .fontWeight(.medium),
                                            .lineHeight(.none),
                                            .textColor(PinesColor.gray.shade(.dark))
                                        ) {}
                                    }
                                    p(
                                        .x.show("toast.description"),
                                        .x.bindClass(descriptionClass),
                                        .marginTop(.size(1.5)),
                                        .fontSize(.xs),
                                        .lineHeight(.none),
                                        .opacity(.value(70)),
                                        .x.text("toast.description")
                                    ) {}
                                }
                            }
                            template(.x.when("toast.html")) { div(HTMLAttribute(name: "x-html", value: "toast.html")) {} }
                            span(
                                .x.on("click", "burnToast(toast.id)"),
                                .position(.absolute),
                                .insetRight(.zero),
                                .padding(.size(1.5)),
                                .marginRight(.size(2.5)),
                                .textColor(PinesColor.gray.shade(.accent)),
                                .transitionDuration(.ms(100)),
                                .transitionTimingFunction(.easeInOut),
                                .opacity(.value(0)),
                                .cursor(.pointer),
                                .borderRadius(.full),
                                .backgroundColor(PinesColor.gray.shade(.tint1), variants: [.hover]),
                                .textColor(PinesColor.gray.shade(.base), variants: [.hover]),
                                .x.bindClass(
                                    pinesAlpineBindClass([
                                        (
                                            twValue(.insetTop(.fraction("1/2")), .translate(.y("1/2"), negative: true)),
                                            "!toast.description && !toast.html"
                                        ),
                                        (twValue(.insetTop(.zero), .marginTop(.size(2.5))), "toast.description || toast.html"),
                                        (twValue(.opacity(.value(100))), "toastHovered"),
                                        (twValue(.opacity(.value(0))), "!toastHovered"),
                                    ])
                                )
                            ) {
                                SVG.svg(
                                    SVGAttribute(name: "class", value: twValue(.width(.size(3)), .height(.size(3)))),
                                    SVGAttribute(name: "fill", value: "currentColor"),
                                    SVGAttribute(name: "viewBox", value: "0 0 20 20"),
                                    SVGAttribute(name: "xmlns", value: "http://www.w3.org/2000/svg")
                                ) {
                                    SVG.path(
                                        SVGAttribute(name: "fill-rule", value: "evenodd"),
                                        SVGAttribute(
                                            name: "d",
                                            value:
                                                "M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                                        ),
                                        SVGAttribute(name: "clip-rule", value: "evenodd")
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return HTMLRaw(html.render())
}
