if (found) {
    if (%inCompilingState()) {
        if (foundImmediate) {
            exec(xt)
        } else {
            compileword(xt)
        }
    } else {
        exec(xt)
    }
} else {
    if (%inCompilingState()) {
        if (%isInteger(item)) {
            compileInt(item)
        } else {
            if (float) {
                compileFloat(item)
            } else {
                %rerror()
            }
        }
    } else {
        if (%isInteger(item)) {
            pushAsInt(item)
        } else {
            if (float) {
                pushAsFloat(item)
            } else {
                %rerror()
            }
        }
    }
}