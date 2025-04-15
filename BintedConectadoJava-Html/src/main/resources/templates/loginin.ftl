<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Binted - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7; /* Fondo suave */
            text-align: center;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin: 100px auto;
        }
        button {
            margin: 10px;
            padding: 10px;
            border: none;
            background: #00B5B5;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        nav ul {
            list-style: none;
            padding: 0;
            background: #00B5B5;
            margin: 0;
            display: flex;
            justify-content: center;
        }
        nav ul li {
            margin: 0 15px;
            padding: 10px;
        }
        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        img {
            width: 200px;
            height: 100px;
            margin-bottom: 20px;
        }
        .slider-container {
            width: 75%;
            position: relative;
            overflow: hidden;
        }
        .slider {
            display: flex;
            width: 500%;
            height: 800px;
            transition: transform 0.5s ease-in-out;
        }
        .slide {
            width: 100vw;
            height: 100vh;
            background-size: cover;
            background-position: center;
        }
        .nav-buttons {
            position: absolute;
            top: 50%;
            width: 100%;
            display: flex;
            justify-content: space-between;
            transform: translateY(-50%);
        }
        .nav-buttons button {
            background: rgba(0, 0, 0, 0.5);
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
        .search-container {
            width: 25%;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .search-container h2 {
            margin-bottom: 10px;
            font-size: 18px;
        }
        #search-bar {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Logo de la empresa -->
        <a href="https://postimages.org/" target="_blank">
            <img src="https://i.postimg.cc/JhzjqqD5/BINTED-LOGO.png" border="0" alt="BINTED-LOGO"/>
        </a>
        <h1>Iniciar Sesión</h1>
        <!-- Formulario de login -->
        <form action="/login" method="post">
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="usuario" required><br><br>

            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required><br><br>

            <button type="submit">Login</button>
        </form>
        <!-- Enlace a la página de registro -->
        <p>¿No tienes cuenta? <a href="/">Regístrate aquí</a></p>
    </div>

</body>
</html>
