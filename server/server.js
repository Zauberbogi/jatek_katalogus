const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const path = require('path');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

app.use(express.static(path.join(__dirname, '../client')));


app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, '../client/login.html'));
});


app.get('/games', (req, res) => {
    res.sendFile(path.join(__dirname, '../client/games.html'));
});

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME
});

const port = process.env.PORT || 3000;


app.post('/register', (req, res) => {
    const { name, email, password } = req.body;

    if (!name || !email || !password) {
        return res.status(400).json({ message: 'Name, email, and password are required.' });
    }

    const checkQuery = 'SELECT * FROM user_person WHERE email = ?';
    pool.query(checkQuery, [email], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Internal server error.' });
        }

        if (results.length > 0) {
            return res.status(400).json({ message: 'Email already registered.' });
        }

        const insertQuery = 'INSERT INTO user_person (name, email, password) VALUES (?, ?, ?)';
        pool.query(insertQuery, [name, email, password], (err, result) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ message: 'Could not register user.' });
            }
            res.status(201).json({ message: 'Registration successful', user: { id: result.insertId, name, email } });
        });
    });
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

        const user = results[0];
        res.status(200).json({ 
            message: 'Login successful', 
            user: { id: user.id, name: user.name, email: user.email }
        });
    });
});


app.post('/rent', (req, res) => {
    const { user_id, game_id } = req.body;

    if (!user_id || !game_id) {
        return res.status(400).json({ message: 'User ID and Game ID are required.' });
    }

    const checkQuery = 'SELECT rented_game_id FROM user_person WHERE id = ?';
    pool.query(checkQuery, [user_id], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Internal server error.' });
        }
        
        if (results[0].rented_game_id) {
            return res.status(400).json({ message: 'User already has a rented game.' });
        }
        
        const rentQuery = 'UPDATE user_person SET rented_game_id = ?, rental_date = NOW() WHERE id = ?';
        pool.query(rentQuery, [game_id, user_id], (err) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ message: 'Could not rent the game.' });
            }
            res.status(200).json({ message: 'Game rented successfully!' });
        });
    });
});


app.post('/return', (req, res) => {
    const { user_id } = req.body;

    if (!user_id) {
        return res.status(400).json({ message: 'User ID is required.' });
    }

    const returnQuery = 'UPDATE user_person SET rented_game_id = NULL, rental_date = NULL WHERE id = ?';
    pool.query(returnQuery, [user_id], (err) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Could not return the game.' });
        }
        res.status(200).json({ message: 'Game returned successfully!' });
    });
});


app.get('/games/list', (req, res) => {
    pool.query("SELECT * FROM games", (err, results) => {
        if (err) {
            console.error("Database error:", err); 
            return res.status(500).json({ message: "Database error" });
        }
        res.status(200).json(results);
    });
});


app.post('/reviews', (req, res) => {
    const { user_id, game_id, rating, comment_text } = req.body;

    if (!user_id || !game_id || !rating || !comment_text) {
        return res.status(400).json({ message: 'All fields are required.' });
    }

    const query = 'INSERT INTO comments (game_id, user_id, comment_text, comment_date) VALUES (?, ?, ?, NOW())';
    pool.query(query, [game_id, user_id, comment_text], (err) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Could not submit review.' });
        }

        const ratingQuery = 'INSERT INTO ratings (game_id, user_id, rating) VALUES (?, ?, ?)';
        pool.query(ratingQuery, [game_id, user_id, rating], (err) => {
            if (err) {
                console.error('Database error:', err);
                return res.status(500).json({ message: 'Could not submit rating.' });
            }
            res.status(200).json({ message: 'Review and rating submitted successfully!' });
        });
    });
});


app.get('/reviews', (req, res) => {
    const query = `
        SELECT games.name AS game_name, user_person.name AS user_name, comments.comment_text, ratings.rating 
        FROM comments 
        JOIN user_person ON comments.user_id = user_person.id
        JOIN games ON comments.game_id = games.id
        LEFT JOIN ratings ON comments.game_id = ratings.game_id AND comments.user_id = ratings.user_id
        ORDER BY comments.comment_date DESC 
        LIMIT 10
    `;

    pool.query(query, (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Could not retrieve reviews.' });
        }
        res.status(200).json(results);
    });
});

app.listen(port, () => {
    console.log(`A szerver fut a ${port}... porton`);
});