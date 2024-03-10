function logRequest(req, res, next) {
  const time = new Date();
  const body = JSON.parse(JSON.stringify(req.body)); // deep copy req.body
  if (body[0] != null && body[0].password != null)
    body[0].password = "*****"; // hide password from logs
  else if (body.password != null) body.password = "*****";

  const formattedTime = `${time.getHours()}h:${time.getMinutes()}m:${time.getSeconds()}s`;
  console.log(
    `[ ${formattedTime} ] - ${req.method} request at ${
      req.url
    } with body ${JSON.stringify(body)}`
  );
  next();
}

module.exports = { logRequest };
