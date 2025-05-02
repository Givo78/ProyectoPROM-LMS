<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Binted - Comprar</title>
    <link rel="stylesheet" href="/style.css">
    <style>
<style>
        main {
               padding: 20px;
               display: grid;
               grid-template-columns: repeat(3, 1fr); /* Forzamos 3 columnas de igual ancho */
               gap: 20px; /
           }

           .producto-bloque {
               background: #fff;
               border: 1px solid #ddd;
               border-radius: 12px;
               box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
               overflow: hidden;
               transition: transform 0.2s ease-in-out;
               box-sizing: border-box;
           }

           .producto-imagen-container {
               position: relative;
               width: 100%;
               height: 200px;
               overflow: hidden;
               border-bottom: 1px solid #eee;
               display: flex;
               justify-content: center;
               align-items: center;
           }

           .producto-imagen {
               display: block;
               max-width: 100%;
               max-height: 100%;
               object-fit: cover;
               border: 2px solid #eee;
           }

           .producto-detalles {
               padding: 15px;
           }

    .producto-titulo {
        font-size: 1.1em;
        font-weight: bold;
        margin-bottom: 8px;
        color: #333;
    }

    .producto-precio {
        color: #00B5B5;
        font-weight: bold;
        margin-bottom: 10px;
        font-size: 1.2em;
    }

    .producto-localidad {
        color: #777;
        font-size: 0.9em;
        margin-bottom: 5px;
    }

    .producto-fecha {
        color: #999;
        font-size: 0.8em;
        margin-bottom: 10px;
    }

    .producto-descripcion-breve {
        color: #555;
        font-size: 0.95em;
        margin-bottom: 10px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        height: 57px;
    }

    .producto-acciones {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 15px;
    }

    .producto-acciones button {
        background-color: #00B5B5;
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.9em;
        transition: background-color 0.3s ease;
    }

    .producto-acciones button:hover {
        background-color: #008A8A;
    }

    .no-productos {
        text-align: center;
        padding: 20px;
        color: #555;
    }

    .error-message {
        color: red;
        text-align: center;
        margin-top: 20px;
    }
</style>
</head>
<body>
<header>
    <h1><img src="/BINTED_LOGO.png" alt=""></h1>
    <nav>
        <ul>
            <li><a href="/home">Inicio</a></li>
            <li><a href="/comprar">Comprar</a></li>
            <li><a href="/subirProducto.ftl">Vender</a></li>
            <li><a href="/logout">Cerrar Sesión</a></li>
        </ul>
    </nav>
    <div class="saludo">Hola, ${usuario! 'Invitado'}</div>
</header>

<div class="wrapper">
    <div class="content">
        <main>
            <#if error??>
                <p class="error-message">${error}</p>
            <#else>
                <#if productos?? && productos?size gt 0>
                    <#list productos as producto>
                        <div class="producto-bloque">
                            <div class="producto-imagen-container">
                                <#if producto.imagen??>
                                    <img src="${producto.imagen}" alt="${producto.titulo}" class="producto-imagen">
                                <#else>
                                    <div class="missing-data">Sin imagen</div>
                                </#if>
                            </div>
                            <div class="producto-detalles">
                                <h2 class="producto-titulo">${producto.titulo}</h2>
                                <p class="producto-precio">${producto.precio?string.currency}</p>
                                <p class="producto-localidad">Localidad: ${producto.localidad}</p>
                                <p class="producto-fecha">Publicado: ${producto.fecha_subida}</p>
                                <p class="producto-descripcion-breve">${producto.descripcion}</p>
                                <div class="producto-acciones">
                                    <button onclick="window.location.href='/compra.html'">Comprar</button>
                                    <button onclick="eliminarProducto(${producto.id})">Eliminar</button>
                                </div>
                            </div>
                        </div>
                    </#list>
                <#else>
                    <p class="no-productos">No hay productos disponibles en este momento.</p>
                </#if>
            </#if>
        </main>
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
    function eliminarProducto(productoId) {
        if (confirm('¿Estás seguro de que quieres eliminar este producto?')) {
            fetch('/eliminarProducto/' + productoId, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    alert('Error al eliminar el producto.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error al comunicarse con el servidor.');
            });
        }
    }
</script>
</body>
</html>
