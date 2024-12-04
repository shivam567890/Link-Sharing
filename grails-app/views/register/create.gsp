<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create User</title>
    <!-- Include any necessary CSS files -->
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <h1>Create User</h1>

    <!-- Display validation errors if any -->
    <g:if test="${errors}">
        <div class="error-messages">
            <h2>Error(s) occurred:</h2>
            <ul>
                <g:eachError var="error" bean="${errors}">
                    <li>${error}</li>
                </g:eachError>
            </ul>
        </div>
    </g:if>

    <!-- Form for user creation -->
    <form action="${create_user}" method="post">
        <div class="form-group">
            <label for="firstName">First Name:</label>
            <input type="text" id="firstName" name="firstName" class="form-control" placeholder="Enter your first name" />
        </div>
        <!-- Add other form fields here -->

        <button type="submit">Create User</button>
    </form>

    <!-- Include any necessary JavaScript files -->
</body>
</html>
