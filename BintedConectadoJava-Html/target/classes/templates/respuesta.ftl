<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Respuesta</title>
</head>
<body>
    <header>
            <h1><img src="BINTED_LOGO.png" alt=""></h1>
            <nav>
                <ul>
                    <li><a href="#">Inicio</a></li>
                    <li><a href="comprar.html">Comprar</a></li>
                    <li><a href="vender.html">Vender</a></li>
                    <li><a href="login.html">Cerrar Sesión</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <div class="content">
                <div class="slider-container">
                    <div class="slider">
                        <div class="slide" style="background-image: url('back-view-female-tailor-checking-garments.jpg');"></div>
                        <div class="slide" style="background-image: url('side-view-female-tailor-checking-garments.jpg');"></div>
                        <div class="slide" style="background-image: url('side-view-woman-looking-clothes.jpg');"></div>
                    </div>
                    <div class="nav-buttons">
                        <button onclick="prevSlide()">&#10094;</button>
                        <button onclick="nextSlide()">&#10095;</button>
                    </div>
                    <div class="search-container">
                        <h2>¿Qué estás buscando?</h2>
                        <input type="text" id="search-bar" placeholder="Buscar...">
                    </div>
                </div>

            </div>
            <script>
                let currentIndex = 0;
                function showSlide(index) {
                    const slider = document.querySelector(".slider");
                    if (index >= 3) currentIndex = 0;
                    else if (index < 0) currentIndex = 2;
                    else currentIndex = index;
                    slider.style.transform = `translateX(-${currentIndex * 100}vw)`;
                }
                function nextSlide() { showSlide(currentIndex + 1); }
                function prevSlide() { showSlide(currentIndex - 1); }
                setInterval(nextSlide, 5000);
            </script>
        </main>
</body>
</html>
