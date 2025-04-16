<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Binted - Inicio</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f7f7f7;
        }
        header {
            background-color: #00B5B5;
            color: white;
            padding: 10px 20px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        header img {
            width: 200px;
            height: 100px;
        }
        nav ul {
            list-style: none;
            display: flex;
            margin: 0;
            padding: 0;
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
        .saludo {
            font-weight: bold;
            position: cener;
            top: 10px;
            right: 20px;
        }
        main {
            margin: 20px;
        }
        /* Slider */
        .slider-container {
            position: relative;
            width: 75%;
            max-width: 800px;
            margin: 20px auto;
            overflow: hidden;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        .slider {
            display: flex;
            transition: transform 0.5s ease-in-out;
            width: 300%; /* Tres diapositivas */
        }
        .slide {
            width: 100%;
            min-height: 400px;
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
            background: rgba(0,0,0,0.5);
            border: none;
            color: white;
            padding: 10px;
            cursor: pointer;
        }
        /* Buscador */
        .search-container {
            text-align: center;
            margin-top: 20px;
        }
        .search-container h2 {
            font-size: 18px;
            margin-bottom: 10px;
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
    <!-- Encabezado con logo y navegación -->
    <header>
        <img src="https://i.postimg.cc/JhzjqqD5/BINTED-LOGO.png" alt="BINTED-LOGO">
        <nav>
            <ul>
                <li><a href="#">Inicio</a></li>
                <li><a href="comprar.html">Comprar</a></li>
                <li><a href="vender.html">Vender</a></li>
                <li><a href="loginin">Cerrar Sesión</a></li>
            </ul>
        </nav>
        <div class="saludo">
            Hola, ${usuario}
        </div>
    </header>

    <!-- Contenido principal -->
    <main>
        <!-- Slider con imágenes -->
        <div class="slider-container">
            <div class="slide" style="background-image: url('https://s10.s3c.es/imag/_v0/1200x655/4/7/0/700x420_ropa-segunda-mano-app-vinted-wallapop.jpg');"></div>
                          <div class="slide" style="background-image: url('https://static.vinted.com/assets/seller-promotion/other/banner-phones-2ab679df561d617d4e0ca27f862f78cf1bfeeba70fcdaa9afc19cc0fcb102c26.jpg');"></div>
                          <div class="slide" style="background-image: url('https://www.evopayments.mx/blog/wp-content/uploads/2022/07/04-ArticuloVenderRopaOnline-770x513.jpg');"></div>
            <div class="nav-buttons">
                <button onclick="prevSlide()">&#10094;</button>
                <button onclick="nextSlide()">&#10095;</button>
            </div>
        </div>

        <!-- Barra de búsqueda -->
        <div class="search-container">
            <h2>¿Qué estás buscando?</h2>
            <input type="text" id="search-bar" placeholder="Buscar...">
        </div>
    </main>

    <!-- Script para el slider -->
    <script>
        // Se usa currentIndex con un valor predeterminado pasado desde el backend (o 0 por defecto)
        let currentIndex = ${currentIndex!0};
        const slider = document.querySelector('.slider');
        const totalSlides = 3;
        function showSlide(index) {
            if(index >= totalSlides) {
                currentIndex = 0;
            } else if(index < 0) {
                currentIndex = totalSlides - 1;
            } else {
                currentIndex = index;
            }
            // Cada diapositiva ocupa el 100% del contenedor
            slider.style.transform = `translateX(-${currentIndex * 100}%)`;
        }
        function nextSlide() { showSlide(currentIndex + 1); }
        function prevSlide() { showSlide(currentIndex - 1); }
        setInterval(nextSlide, 5000);
    </script>

</body>
</html>
