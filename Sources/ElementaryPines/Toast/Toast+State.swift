enum PinesToastState {
    static let xData = #"""
        { 
                toasts: [],
                toastsHovered: false,
                expanded: false,
                layout: 'default',
                position: 'top-center',
                paddingBetweenToasts: 15,
                deleteToastWithId (id){
                    for(let i = 0; i < this.toasts.length; i++){
                        if(this.toasts[i].id === id){
                            this.toasts.splice(i, 1);
                            break;
                        }
                    }
                },
                burnToast(id){
                    burnToast = this.getToastWithId(id);
                    burnToastElement = document.getElementById(burnToast.id);
                    if(burnToastElement){
                        if(this.toasts.length == 1){
                            if(this.layout=='default'){
                                this.expanded = false;
                            }
                            burnToastElement.classList.remove('translate-y-0');
                            if(this.position.includes('bottom')){
                                burnToastElement.classList.add('translate-y-full');
                            } else {
                                burnToastElement.classList.add('-translate-y-full');
                            }
                        }
                        burnToastElement.classList.add('opacity-0');
                        let that = this;
                        setTimeout(function(){
                            that.deleteToastWithId(id);
                            setTimeout(function(){
                                that.stackToasts();
                            }, 1)
                        }, 300);
                    }
                },
                getToastWithId(id){
                    for(let i = 0; i < this.toasts.length; i++){
                        if(this.toasts[i].id === id){
                            return this.toasts[i];
                        }
                    }
                },
                stackToasts(){
                    this.positionToasts();
                    this.calculateHeightOfToastsContainer();
                    let that = this;
                    setTimeout(function(){
                        that.calculateHeightOfToastsContainer();
                    }, 300);
                },
                positionToasts(){
                    if(this.toasts.length == 0) return;
                    let that = this;
                    let scales = ['100%', '94%', '88%', '82%', '76%'];
                    let zIndices = [100, 90, 80, 70, 60];
                    let offsets = [0, 16, 32, 48, 64];
                    let isBottom = this.position.includes('bottom');
                    for(let i = 0; i < this.toasts.length; i++){
                        let el = document.getElementById(this.toasts[i].id);
                        if(!el) continue;
                        el.style.zIndex = zIndices[i] || 60;
                        if(i >= 4){
                            el.style.opacity = '0';
                            let idx = i;
                            setTimeout(function(){ that.toasts.splice(idx, 1); }, 300);
                            continue;
                        }
                        if(this.expanded){
                            let offset = 0;
                            for(let j = 0; j < i; j++){
                                let prevEl = document.getElementById(this.toasts[j].id);
                                if(prevEl){
                                    offset += prevEl.offsetHeight + this.paddingBetweenToasts;
                                }
                            }
                            el.style.scale = '100%';
                            el.style.transform = 'translateY(0px)';
                            if(isBottom){
                                el.style.top = 'auto';
                                el.style.bottom = offset + 'px';
                            } else {
                                el.style.bottom = 'auto';
                                el.style.top = offset + 'px';
                            }
                        } else {
                            let scaleVal = scales[i] !== undefined ? scales[i] : '76%';
                            let offsetVal = offsets[i] !== undefined ? offsets[i] : 64;
                            el.style.scale = scaleVal;
                            if(isBottom){
                                el.style.top = 'auto';
                                el.style.bottom = '0px';
                                el.style.transform = 'translateY(-' + offsetVal + 'px)';
                            } else {
                                let topEl = document.getElementById(this.toasts[0].id);
                                if(topEl){
                                    topEl.style.top = '0px';
                                    topEl.style.bottom = 'auto';
                                    this.alignBottom(topEl, el);
                                }
                                el.style.transform = 'translateY(' + offsetVal + 'px)';
                            }
                        }
                    }
                },
                alignBottom(element1, element2) {
                    let top1 = element1.offsetTop;
                    let height1 = element1.offsetHeight;
                    let height2 = element2.offsetHeight;
                    let top2 = top1 + (height1 - height2);
                    element2.style.top = top2 + 'px';
                },
                alignTop(element1, element2) {
                    let top1 = element1.offsetTop;
                    element2.style.top = top1 + 'px';
                },
                resetBottom(){
                    for(let i = 0; i < this.toasts.length; i++){
                        if(document.getElementById( this.toasts[i].id )){
                            let toastElement = document.getElementById( this.toasts[i].id );
                            toastElement.style.bottom = '0px';
                        }
                    }
                },
                resetTop(){
                    for(let i = 0; i < this.toasts.length; i++){
                        if(document.getElementById( this.toasts[i].id )){
                            let toastElement = document.getElementById( this.toasts[i].id );
                            toastElement.style.top = '0px';
                        }
                    }
                },
                getBottomPositionOfElement(el){
                    return (el.getBoundingClientRect().height + el.getBoundingClientRect().top);
                },
                calculateHeightOfToastsContainer(){
                    if(this.toasts.length == 0){
                        $el.style.height = '0px';
                        return;
                    }
                    lastToast = this.toasts[this.toasts.length - 1];
                    lastToastRectangle = document.getElementById(lastToast.id).getBoundingClientRect();
                    firstToast = this.toasts[0];
                    firstToastRectangle = document.getElementById(firstToast.id).getBoundingClientRect();
                    if(this.toastsHovered){
                        if(this.position.includes('bottom')){
                            $el.style.height = ((firstToastRectangle.top + firstToastRectangle.height) - lastToastRectangle.top) + 'px';
                        } else {
                            $el.style.height = ((lastToastRectangle.top + lastToastRectangle.height) - firstToastRectangle.top) + 'px';
                        }
                    } else {
                        $el.style.height = firstToastRectangle.height + 'px';
                    }
                }
            }
        """#
}
