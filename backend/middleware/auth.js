// middleware for user authentication
function authenticateToken(req, res, next) {
  const header = req.headers["authorization"];
  const token = header && header.split(" ")[1];

  if (token == null)
    return res.status(401).send({ error: "no authorization token given" });

  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
    if (err)
      return res.status(403).send({ error: "malformed or expired token" });

    req.user_id = user.user_id;
    next();
  });
}

module.exports = { authenticateToken };
