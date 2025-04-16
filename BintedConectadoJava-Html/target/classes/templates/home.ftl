<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Binted - Inicio</title>
    <link rel="stylesheet" href="style.css">
    <style>
.slider-search-wrapper {
display: flex;
align-items: center;
justify-content: space-between;
gap: 20px;
padding: 20px;
}

.slider-container {
flex: 2;
position: relative;
overflow: hidden;
max-width: 70vw;
}

.search-container {
flex: 1;
display: flex;
flex-direction: column;
justify-content: center;
position: relative;
top: -20px;
}

.search-container h2 {
margin-bottom: 10px;
}

#search-bar {
padding: 10px;
font-size: 16px;
width: 100%;
}
.slider-message {
position: absolute;
top: 50%;
left: 50%;
transform: translate(-50%, -50%);
background: white;
padding: 30px 40px;
border-radius: 12px;
text-align: center;
z-index: 5;
box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
opacity: 0.95;
}

.slider-message h2 {
margin: 0 0 15px;
font-size: 24px;
color: #333;
}

.slider-button {
background-color: #00B5B5;
color: white;
text-decoration: none;
padding: 10px 20px;
font-weight: bold;
border-radius: 6px;
transition: background-color 0.3s ease;
}

.slider-button:hover {
background-color: #00B5B5;
}

.reviews-grid {
display: grid;
grid-template-columns: repeat(2, 1fr);
gap: 20px;
margin-top: 30px;
justify-items: center;
}

.review-card {
background: #fff;
border: 1px solid #ddd;
border-radius: 12px;
padding: 20px;
width: 250px;
box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
text-align: center;
transition: transform 0.3s ease;
}

.review-card:hover {
transform: translateY(-5px);
}

.review-card .stars {
font-size: 18px;
color: #ffc107;
margin-bottom: 10px;
}

.review-card p {
font-size: 15px;
color: #444;
margin-bottom: 10px;
}

.review-card span {
font-size: 13px;
color: #777;
}


</style>
</head>
<body>
<header>
<h1><img src="BINTED_LOGO.png" alt=""></h1>
    <nav>
        <ul>
            <li><a href="#">Inicio</a></li>
            <li><a href="comprar.html">Comprar</a></li>
            <li><a href="vender.html">Vender</a></li>
            <li><a href="loginin">Cerrar Sesión</a></li>
        </ul>
    </nav>
    <div class="saludo">Hola, ${usuario}</div>
</header>

<div class="wrapper">
        <div class="content">
            <div class="slider-search-wrapper">
                <!-- Slider -->
                <div class="slider-container">
                    <div class="slider">
                        <div class="slide" style="background-image: url('imgs_slider/back-view-female-tailor-checking-garments.jpg');"></div>
                        <div class="slide" style="background-image: url('imgs_slider/side-view-female-tailor-checking-garments.jpg');"></div>
                        <div class="slide" style="background-image: url('imgs_slider/side-view-woman-looking-clothes.jpg');"></div>
                    </div>
                    <div class="slider-message">
                        <h2>¿Quieres vaciar tu armario?</h2>
                        <a href="vender.html" class="slider-button">Vender ahora</a>
                    </div>
                    <div class="nav-buttons">
                        <button onclick="prevSlide()">&#10094;</button>
                        <button onclick="nextSlide()">&#10095;</button>
                    </div>
                </div>

                <!-- Buscador -->
                <div class="search-container">
                    <h2>¿Qué estás buscando?</h2>
                    <input type="text" id="search-bar" placeholder="Buscar...">
                    <div class="reviews-container">
                        <div class="reviews-grid">
                            <div class="review-card">
                                <p class="stars">⭐️⭐️⭐️⭐️⭐️</p>
                                <p>"Vendí toda mi ropa en dos días. ¡Una pasada!"</p>
                                <span>- Clara M.</span>
                            </div>
                            <div class="review-card">
                                <p class="stars">⭐️⭐️⭐️⭐️</p>
                                <p>"Muy fácil de usar, 100% recomendado."</p>
                                <span>- Sergio L.</span>
                            </div>
                            <div class="review-card">
                                <p class="stars">⭐️⭐️⭐️⭐️⭐️</p>
                                <p>"Me encanta Binted, volveré seguro."</p>
                                <span>- Lucía F.</span>
                            </div>
                            <div class="review-card">
                                <p class="stars">⭐️⭐️⭐️⭐️⭐️</p>
                                <p>"Encontré ropa genial por muy poco."</p>
                                <span>- Marta V.</span>
                            </div>
                            <div class="review-card">
                                <p class="stars">⭐️⭐️⭐️⭐️</p>
                                <p>"Todo perfecto, repetiré sin dudar."</p>
                                <span>- Iván D.</span>
                            </div>
                            <div class="review-card">
                                <p class="stars">⭐️⭐️⭐️⭐️⭐️</p>
                                <p>"Buenísima experiencia, cero complicaciones."</p>
                                <span>- Aitana R.</span>
                            </div>
                        </div>

                    </div>

                </div>

            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Binted. Todos los derechos reservados.</p>
        <p>
            <a href="privacidad.html">Política de Privacidad</a> |
            <a href="terminos.html">Términos y Condiciones</a> |
            <a href="contacto.html">Contacto</a>
        </p>
    </footer>
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

        const searchBar = document.getElementById("search-bar");
        searchBar.addEventListener("keypress", function(event) {
if (event.key === "Enter") {
const query = searchBar.value.trim();
localStorage.setItem("busqueda", query);
window.location.href = "comprar.html";
}
    });
    </script>
</main>
</body>
</html>