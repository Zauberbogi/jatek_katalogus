document.getElementById('loginButton').addEventListener('click', async () => {
    const email = document.getElementById('email-login').value;
    const password = document.getElementById('password-login').value;

    if (!email || !password) {
        alert('Please enter both email and password.');
        return;
    }

    try {
        const response = await fetch('http://localhost:3000/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();
        console.log("Login response:", data);

        if (response.ok) {
            alert('Login successful!');
            localStorage.setItem('userId', data.user.id);
            console.log("Stored user ID:", localStorage.getItem('userId'));
            window.location.href = "games.html";
        } else {
            alert('Login failed: ' + data.message);
        }
    } catch (error) {
        console.error('Error during login:', error);
        alert('An error occurred. Please try again.');
    }
});


document.getElementById('registerButton').addEventListener('click', async () => {
    const name = document.getElementById('name-register').value;
    const email = document.getElementById('email-register').value;
    const password = document.getElementById('password-register').value; 

    if (!name || !email || !password) {
        alert('Please enter name, email, and password.');
        return;
    }

    try {
        const response = await fetch('http://localhost:3000/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name, email, password })
        });

        const data = await response.json();
        console.log("Registration response:", data);

        if (response.ok) {
            alert('Registration successful! Please log in.');
            document.getElementById('name-register').value = '';
            document.getElementById('email-register').value = '';
            document.getElementById('password-register').value = '';
        } else {
            alert('Registration failed: ' + data.message);
        }
    } catch (error) {
        console.error('Error during registration:', error);
        alert('An error occurred. Please try again.');
    }
});