document.getElementById('loginForm').addEventListener('submit', async function (event) {
    event.preventDefault(); // Prevent the default form submission

    // Get form values
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const picture = document.getElementById('picture').value;

    // Prepare the request payload
    const payload = {
        username: username,
        password: password,
        picture: picture,
    };

    try {
        // Make a POST request to the '/auth' endpoint
        const response = await fetch('/auth', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(payload),
        });

        // Handle the response
        if (response.ok) {
            const data = await response.json();
            const url = data.url;

            // Redirect to the URL returned by the API
            window.location.href = url;
        } else {
            // Handle errors (e.g., invalid login or country)
            const errorData = await response.json();
            document.getElementById('response').innerText = `Error: ${errorData.error}`;
        }
    } catch (error) {
        // Handle network errors
        document.getElementById('response').innerText = 'Error: Unable to connect to the server.';
    }
});
