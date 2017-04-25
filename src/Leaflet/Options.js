exports.mkOptionsJS =
    function (fst) {
        return function (snd) {
            return function (options) {
                var retval = {}
                options.forEach(function (x) {
                    retval[fst(x)] = snd(x)
                })
                return retval
            }
        }
    }

var identity = function (a) { return a; }

exports.optValString = identity
exports.optValNumber = identity
exports.optValInt = identity
exports.optValBoolean = identity
exports.optValArray = identity
