html/
ad-scheduler/
├── static/
│   ├── css/
│   │   └── styles.css
│   ├── js/
│   │   └── script.js
│   ├── index.html
│   ├── create-account.html
│   ├── subscription.html
│   └── payment.html
├── app.py
├── requirements.txt
└── README.md

                            <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ad Scheduler - Home</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Ad Scheduler</h1>
    </header>
    <main>
        <h2>Welcome!</h2>
        <a href="create-account.html">Sign Up</a>
    </main>
</body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Create Your Account</h1>
    </header>
    <main>
        <form id="createAccountForm">
            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
            <label for="email">Email Address:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Create Account</button>
        </form>
    </main>
    <script src="js/script.js"></script>
</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subscription Prices</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Subscription Prices</h1>
    </header>
    <main>
        <h2>Pricing Details</h2>
        <ul>
            <li>One-Time Payment: $100 for 1 social media channel + 50 free ads.</li>
            <li>Additional Channels: $10/month per channel.</li>
            <li>Unlimited Channels: $25/month.</li>
        </ul>
        <a href="payment.html">Subscribe Now</a>
    </main>
</body>
</html>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <header>
        <h1>Payment</h1>
    </header>
    <main>
        <form id="paymentForm" action="/payment" method="post">
            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" required>
            <button type="submit">Pay Now</button>
        </form>
    </main>
</body>
</html>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
}
header {
    background-color: #f4f4f4;
    padding: 10px;
    text-align: center;
}
main {
    padding: 20px;
    max-width: 800px;
    margin: 0 auto;
}
form {
    display: flex;
    flex-direction: column;
}
label, input, button {
    margin-bottom: 10px;
}
button {
    padding: 10px;
    background-color: #007BFF;
    color: #fff;
    border: none;
    cursor: pointer;
}
button:hover {
    background-color: #0056b3;
}
document.getElementById('createAccountForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
        alert('Passwords do not match!');
        return;
    }

    // Proceed with form submission (e.g., send data to the server)
    alert('Account created successfully!');
});
from flask import Flask, request, jsonify, send_from_directory
import os

app = Flask(__name__)

# Admin email list
ADMIN_EMAILS = {'admin@example.com'}

# Static file serving for frontend
@app.route('/<path:filename>')
def serve_static(filename):
    return send_from_directory('static', filename)

# Admin check decorator
def admin_required(f):
    def wrapper(*args, **kwargs):
        user_email = request.headers.get('User-Email')
        if user_email in ADMIN_EMAILS:
            return f(*args, **kwargs)
        else:
            return jsonify({'message': 'Access denied'}), 403
    return wrapper

@app.route('/payment', methods=['POST'])
def payment():
    amount = request.form.get('amount')
    if not amount:
        return jsonify({'message': 'Amount is required'}), 400

    if 'User-Email' in request.headers and request.headers['User-Email'] in ADMIN_EMAILS:
        return jsonify({'message': 'Payment processed successfully for admin!'}), 200
    else:
        # Here you would integrate with a real payment gateway
        return jsonify({'message': 'Payment processed successfully for non-admin!'}), 200

if __name__ == '__main__':
    app.run(debug=True)
Flask==2.3.0
# Ad Scheduler

This is a simple ad scheduling application with subscription and admin features.

## Getting Started

To run this application:

1. Install dependencies:
   ```bash
   pip install -r requirements.txt
