document.addEventListener('DOMContentLoaded', () => {
    loadGames();
    loadReviews();

    const submitButton = document.getElementById('submit');
    if (submitButton) {
        submitButton.addEventListener('click', submitReview);
    } else {
        console.error('Submit button not found');
    }

    document.querySelectorAll('.rentButton').forEach(button => {
        button.addEventListener('click', () => rentGame(button.getAttribute('data-game-id')));
    });


    const returnButton = document.getElementById('returnButton');
    if (returnButton) {
        returnButton.addEventListener('click', returnGame);
    } else {
        console.error('Return button not found');
    }
});


async function loadReviews() {
    try {
        const response = await fetch('http://localhost:3000/reviews');
        if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);
        const reviews = await response.json();

        const reviewsContainer = document.getElementById('recent-reviews');
        if (!reviewsContainer) {
            console.error('Reviews container element with ID "recent-reviews" not found in HTML');
            return;
        }
        reviewsContainer.innerHTML = "<h3>Recent Reviews</h3>";

        reviews.forEach(review => {
            const reviewElement = document.createElement('p');
            reviewElement.innerHTML = `<strong>${review.game_name}</strong> - ${review.user_name}: ${review.comment_text} (Rating: ${review.rating}/5)`;
            reviewsContainer.appendChild(reviewElement);
        });
    } catch (error) {
        console.error('Error fetching reviews:', error);
    }
}


async function loadGames() {
    try {
        console.log("Fetching games...");
        const response = await fetch("http://localhost:3000/games/list");
        if (!response.ok) throw new Error(`HTTP error! Status: ${response.status}`);
        const games = await response.json();
        console.log("Received games:", games);

        const gameSelect = document.getElementById("sgames");
        if (!gameSelect) {
            console.error('Game select element with ID "sgames" not found in HTML');
            return;
        }
        gameSelect.innerHTML = "";

        games.forEach(game => {
            const option = document.createElement("option");
            option.value = game.id;
            option.textContent = game.name;
            gameSelect.appendChild(option);
        });
    } catch (error) {
        console.error("Error fetching games:", error);
    }
}


async function submitReview() {
    const userId = localStorage.getItem('userId');
    if (!userId) {
        alert('You must be logged in to submit a review.');
        return;
    }

    const gameId = document.getElementById('sgames').value;
    const rating = document.getElementById('rgames').value;
    const reviewText = document.getElementById('review').value;

    if (!reviewText.trim()) {
        alert("Please enter a review before submitting.");
        return;
    }

    try {
        const response = await fetch('http://localhost:3000/reviews', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ user_id: userId, game_id: gameId, rating: rating, comment_text: reviewText })
        });

        const data = await response.json();
        alert(data.message);
        loadReviews();
    } catch (error) {
        console.error('Error submitting review:', error);
    }
}


async function rentGame(gameId) {
    const userId = localStorage.getItem('userId');
    if (!userId) {
        alert('You must be logged in to rent a game.');
        return;
    }

    const paymentConfirmed = confirm('Do you want to rent this game for 6 euros?');
    if (!paymentConfirmed) {
        alert('Payment cancelled. Game not rented.');
        return;
    }

    try {
        const response = await fetch('http://localhost:3000/rent', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ user_id: userId, game_id: gameId })
        });

        const data = await response.json();
        if (response.ok) {
            const rentalDate = new Date();
            const dueDate = new Date(rentalDate);
            dueDate.setMonth(rentalDate.getMonth() + 1);
            alert(`${data.message}\nRental due date: ${dueDate.toLocaleDateString()}`);
        } else {
            alert('Rental failed: ' + data.message);
        }
    } catch (error) {
        console.error('Error renting game:', error);
        alert('An error occurred while renting the game.');
    }
}


async function returnGame() {
    const userId = localStorage.getItem('userId');
    if (!userId) {
        alert('You must be logged in to return a game.');
        return;
    }

    try {
        const response = await fetch('http://localhost:3000/return', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ user_id: userId })
        });

        const data = await response.json();
        alert(data.message);
    } catch (error) {
        console.error('Error returning game:', error);
        alert('An error occurred while returning the game.');
    }
}