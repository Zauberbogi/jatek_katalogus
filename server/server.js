const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
require('dotenv').config();
const path = require('path');

const app = express();
app.use(express.json());
app.use(cors());


app.use(express.static(path.join(__dirname, '../client')));


app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../client/login.html'));
});

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});


app.post('/login', (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email and password are required.' });
    }

    const query = 'SELECT * FROM user_person WHERE email = ? AND password = ?';

    pool.query(query, [email, password], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Internal server error.' });
        }

        if (results.length === 0) {
            return res.status(401).json({ message: 'Invalid email or password.' });
        }

        res.status(200).json({ message: 'Login successful', user: results[0] });
    });
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
    console.log(`Szerver elindítva a ${port} -es porton...`);
});
