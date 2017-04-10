exports.map =
    function (domID) {
        return function(latlng) {
            return function (zoom) {
                return function () {
                    var m = L.map(domID)
                    m.setView(latlng, zoom)
                    return m
                }
            }
        }
    }

exports.tileLayer =
    function (urlTemplate) {
        return function () {
            return L.tileLayer(urlTemplate, {})
        }
    }

exports.addLayer =
    function (layer) {
        return function (map) {
            return function () {
                layer.addTo(map)
            }
        }
    }

exports.setView =
    function (map) {
        return function (latlng) {
            return function (zoom) {
                return function () {
                    map.setView(latlng, zoom)
                }
            }
        }
    }

exports.invalidateSize =
    function (map) {
        return function () {
            map.invalidateSize()
        }
    }

exports.getCenter =
    function (map) {
        return function () {
            return map.getCenter()
        }
    }

exports.getZoom =
    function (map) {
        return function () {
            return map.getZoom()
        }
    }

exports.onZoom =
    function (map) {
        return function (handler) {
            return function () {
                map.on('zoom', function (data) {
                    handler()
                })
            }
        }
    }

exports.onMove =
    function (map) {
        return function (handler) {
            return function () {
                map.on('move', function (ev) {
                    handler(ev.latlng)()
                })
            }
        }
    }

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

exports.onMouseEvent = function (eventName) {
    return function (map) {
        return function (handler) {
            return function () {
                map.on(eventName, function (ev) {
                    handler(mkMouseEvent(ev))()
                })
            }
        }
    }
}
