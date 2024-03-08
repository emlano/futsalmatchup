class DuplicateTeamName extends Error {
  constructor() {
    super("Teamname already taken");
    this.name = "DuplicateTeamnameError";
  }
}

module.exports = DuplicateTeamName;
