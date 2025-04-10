<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Binted - Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Registrarse</h1>
        <form action="/submit" method="post">
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="usuario" required><br><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required><br><br>

            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required><br><br>

            <input type="submit" value="Enviar">
        </form>
    </div>
    <script>
        function checkLogin() {
            window.location.href = 'main.html';
        }
    </script>
</body>
</html>
