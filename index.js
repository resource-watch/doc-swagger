const express = require('express');
const app = express();
const swaggerUi = require('swagger-ui-express');
const logger = require('express-simple-logger')
const expressHealthcheck = require('express-healthcheck');

app.use(logger());

const options = {
  swaggerOptions: {
    url: process.env.SWAGGER_URL
  },
  customCss: '.swagger-ui .topbar img { display: none }'
}

app.use('/healthcheck', expressHealthcheck());

app.use('/documentation/', swaggerUi.serve, swaggerUi.setup(null, options));

const port = process.env.PORT || 3500;

app.listen(port, () => {
  console.log(`Listening on http://localhost:${port}`);
})
