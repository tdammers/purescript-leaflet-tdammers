var mkMouseEvent = function (ev) {
    return {
        latlng: ev.latlng,
        layerPoint:
            {
                x: ev.layerPoint.x,
                y: ev.layerPoint.y
            },
        containerPoint:
            {
                x: ev.containerPoint.x,
                y: ev.containerPoint.y
            }
    }
}

exports.onMouseEventJS = function (eventName) {
    return function (target) {
        return function (action) {
            return function () {
                var handler = function (ev) {
                    action(mkMouseEvent(ev))()
                }
                target.on(eventName, handler)
                return handler
            }
        }
    }
}

exports.offMouseEventJS = function (eventName) {
    return function (target) {
        return function (handler) {
            return function () {
                target.off(eventName, handler)
                return null
            }
        }
    }
}
