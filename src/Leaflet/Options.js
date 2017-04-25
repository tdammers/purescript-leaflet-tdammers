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

exports.optValStr = function (str) { return str }
exports.optValNumber = function (n) { return n }
exports.optValInt = function (n) { return n }
exports.optValBoolean = function (n) { return n }
