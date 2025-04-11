-- Eliminar la base de datos si existe
DROP DATABASE IF EXISTS Binteddb;

-- Crear la base de datos
CREATE DATABASE Binteddb;

-- Usar la base de datos recién creada
USE Binteddb;

-- Eliminar tablas si existen
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS contactos;

-- Crear tabla de usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('usuario', 'administrador') NOT NULL DEFAULT 'usuario',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion TEXT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    fotos VARCHAR(255),  -- Solo se guarda la URL de la imagen
    localidad VARCHAR(100) NOT NULL,
    id_usuario INT NOT NULL,
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id)
);

-- Crear tabla de contactos (opcional)
CREATE TABLE contactos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    id_usuario_interesado INT NOT NULL,
    mensaje TEXT NOT NULL,
    fecha_contacto TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_producto) REFERENCES productos(id),
    FOREIGN KEY (id_usuario_interesado) REFERENCES usuarios(id)
);

-- Insertar datos de ejemplo en la tabla usuarios
INSERT INTO usuarios (nombre, correo, contrasena, rol) VALUES
('Juan Pérez', 'juan@example.com', 'contraseñaEncriptada1', 'usuario'),
('Admin', 'admin@example.com', 'contraseñaEncriptadaAdmin', 'administrador');

-- prueba
-- Insertar productos de ejemplo con URLs de imágenes
INSERT INTO productos (titulo, descripcion, precio, fotos, localidad, id_usuario) VALUES
('iPhone 12', 'Smartphone de última generación', 800.00, 'https://images.unsplash.com/photo-1604679639369-58b1026f8ed5', 'Madrid', 1),
('Coche Toyota Corolla', 'Vehículo usado en buen estado', 12000.00, 'https://images.pexels.com/photos/1687465/pexels-photo-1687465.jpeg', 'Madrid', 1),
('Bicicleta de montaña', 'Bicicleta ideal para senderismo', 500.00, 'https://cdn.pixabay.com/photo/2017/07/26/22/06/bicycle-2547427_960_720.jpg', 'Barcelona', 1);
