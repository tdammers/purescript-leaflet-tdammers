exports.markerJS =
    function (position) {
        return function (options) {
            return function () {
                return L.marker(position, options)
            }
        }
    }
