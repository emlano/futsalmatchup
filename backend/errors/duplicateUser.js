class DuplicateUsername extends Error {
    constructor() {
        super("Username already taken")
        this.name = "DuplicateUsername"
    }
}

module.exports = DuplicateUsername