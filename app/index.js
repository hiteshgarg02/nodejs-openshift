const path = require('path');
const express = require('express');

const app = express();
const port = process.env.PORT || '8080';
const dbUrl = process.env.DBURL || '';
const clientId = process.env.CLIENTID || '';

app.engine('html', require('ejs').renderFile);

app.get('/', (req, res) => {
    res.render(__dirname + '/index.html', { dbUrl: dbUrl, clientId: clientId });
});

app.listen(port, () => {
    console.log(`Listening requests on http://localhost:${port}`);
});
