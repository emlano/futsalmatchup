class MissingArguments extends Error {
    constructor() {
        super("Request missing data arguments")
        this.name = "MissingArguments"
    }
}

module.exports = MissingArguments