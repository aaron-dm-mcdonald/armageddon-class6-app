// Event listener for form submission
document.getElementById('loginForm').addEventListener('submit', async function (event) {
    event.preventDefault(); // Prevent the default form submission behavior

    // Get the values entered in the form fields
    const username = document.getElementById('username').value;  // Username input value
    const password = document.getElementById('password').value;  // Password input value
    const picture = document.getElementById('picture').value;    // Picture input value

    // Prepare the payload (data to be sent in the request body)
    const payload = {
        username: username,  // Send the entered username
        password: password,  // Send the entered password
        picture: picture,    // Send the picture URL
    };

    // Make a POST request to the '/auth' endpoint with the request payload
    const response = await fetch('/auth', {
        method: 'POST', // HTTP method to use for the request
        headers: {
            'Content-Type': 'application/json', // Indicate that the body is JSON
        },
        body: JSON.stringify(payload), // Convert the payload to a JSON string
    });

    // Check if the response from the server is successful (status code 2xx)
    if (response.ok) {
        const data = await response.json(); // Parse the JSON response
        const url = data.url;  // Get the URL returned by the API

        // Redirect the user to the URL received from the API
        window.location.href = url;
    } else {
        // If the response is not successful (e.g., invalid login or other error)
        const errorData = await response.json(); // Parse the error response
        // Display the error message to the user
        document.getElementById('response').innerText = `Error: ${errorData.error}`;
    }
});
