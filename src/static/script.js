document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const picture = document.getElementById('picture').value;
    
    // Use relative URL for API call
    fetch('/auth', {  // Relative path to the Flask API endpoint
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            username: username,
            password: password,
            picture: picture
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.url) {
            document.getElementById('response').innerText = `URL: ${data.url}`;
        } else {
            document.getElementById('response').innerText = data.error || 'Unknown error';
        }
    })
    .catch(error => {
        document.getElementById('response').innerText = `Error: ${error.message}`;
    });
});
