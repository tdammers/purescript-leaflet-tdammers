exports.latlng =
    function (lat) {
        return function (lng) {
            return L.latLng(lat, lng)
        }
    }

exports.lat =
    function (latlng) {
        return latlng.lat
    }

exports.lng =
    function (latlng) {
        return latlng.lng
    }

exports.latLngBounds =
    function (corner1) {
        return function (corner2) {
            return L.latLngBounds(corner1, corner2)
        }
    }

exports.extendToPoint = function (llb) { return function (x) { return llb.extend(x) } }
exports.extendToBounds = function (llb) { return function (x) { return llb.extend(x) } }
exports.padLatLngBounds = function (llb) { return function (x) { return llb.pad(x) } }

exports.getCenter = function (llb) { return llb.getCenter() }
exports.getNorthWest = function (llb) { return llb.getNorthWest() }
exports.getSouthWest = function (llb) { return llb.getSouthWest() }
exports.getNorthEast = function (llb) { return llb.getNorthEast() }
exports.getSouthEast = function (llb) { return llb.getSouthEast() }
exports.getNorth = function (llb) { return llb.getNorth() }
exports.getSouth = function (llb) { return llb.getSouth() }
exports.getWest = function (llb) { return llb.getWest() }
exports.getEast = function (llb) { return llb.getEast() }

exports.containsPoint = function (a) { return function (b) { return a.contains(b) } }
exports.contains = function (a) { return function (b) { return a.contains(b) } }
exports.intersects = function (a) { return function (b) { return a.intersects(b) } }

exports.latLngBoundsEq = function (a) { return function (b) { return a.equals(b) } }

exports.toBBoxString = function (llb) { return llb.toBBoxString() }
