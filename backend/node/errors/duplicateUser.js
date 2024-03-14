class DuplicateUsername extends Error {
    constructor() {
        super("username already taken")
        this.name = "DuplicateUsernameError"
    }
}

module.exports = DuplicateUsername