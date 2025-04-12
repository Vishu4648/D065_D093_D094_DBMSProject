const http = require('http');
const fs = require('fs');
const querystring = require('querystring');
const mysql = require('mysql2');

// MySQL connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'root',
  database: 'project'
});

connection.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err.stack);
    return;
  }
  console.log('Connected to MySQL');
});

// Create HTTP server
const server = http.createServer((req, res) => {
  // Serve signup form
  if (req.method === 'GET' && req.url === '/') {
    fs.readFile('signup.html', (err, data) => {
      if (err) {
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        res.end('Error loading signup form.');
        return;
      }
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    });

  // Serve login form
  } else if (req.method === 'GET' && req.url === '/login.html') {
    fs.readFile('login.html', (err, data) => {
      if (err) {
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        res.end('Error loading login page.');
        return;
      }
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    });

  // Serve index/home page
  } else if (req.method === 'GET' && req.url === '/index.html') {
    fs.readFile('index.html', (err, data) => {
      if (err) {
        res.writeHead(500, { 'Content-Type': 'text/plain' });
        res.end('Error loading index.html');
        return;
      }
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    });

  // Handle registration
  } else if (req.method === 'POST' && req.url === '/register') {
    let body = '';
    req.on('data', chunk => { body += chunk.toString(); });
    req.on('end', () => {
      const { name, mobile, email, password, confirmPassword } = querystring.parse(body);

      if (password !== confirmPassword) {
        res.writeHead(400, { 'Content-Type': 'text/html' });
        res.end(`<h2 style="color:red;">Passwords do not match!</h2><a href="/signup.html">Try again</a>`);
        return;
      }

      const sql = 'INSERT INTO users (name, mobile, email, password) VALUES (?, ?, ?, ?)';
      connection.query(sql, [name, mobile, email, password], (err, result) => {
        if (err) {
          res.writeHead(500, { 'Content-Type': 'text/plain' });
          res.end('Database Error: ' + err.message);
          return;
        }

        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(`<h2 style="color:green;">Registration Successful!</h2><a href="/login.html">Go to Login</a>`);
      });
    });

  // Handle login
  } else if (req.method === 'POST' && req.url === '/login.html') {
    let body = '';
    req.on('data', chunk => { body += chunk.toString(); });
    req.on('end', () => {
      const { email, password } = querystring.parse(body);

      const sql = 'SELECT * FROM users WHERE email = ? AND password = ?';
      connection.query(sql, [email, password], (err, results) => {
        if (err) {
          res.writeHead(500, { 'Content-Type': 'text/plain' });
          res.end('Database Error: ' + err.message);
          return;
        }

        if (results.length > 0) {
          res.writeHead(200, { 'Content-Type': 'text/html' });
          res.end(`<h2 style="color:green;">Welcome back, ${results[0].name}!</h2><a href="/index.html">Back to Home</a>`);
        } else {
          res.writeHead(401, { 'Content-Type': 'text/html' });
          res.end(`<h2 style="color:red;">Invalid email or password</h2><a href="/login.html">Try Again</a>`);
        }
      });
    });

  } else {
    // 404 Not Found
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('404 Not Found');
  }
});

// Start the server
server.listen(3000, () => {
  console.log('Server running at http://localhost:3000');
});
