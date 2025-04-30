package org.example;

import io.javalin.Javalin;
import io.javalin.rendering.template.JavalinFreemarker;
import freemarker.template.Configuration;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        // Configuración de Freemarker
        Configuration freemarkerConfig = new Configuration(Configuration.VERSION_2_3_31);
        freemarkerConfig.setClassForTemplateLoading(Main.class, "/templates");
        freemarkerConfig.setDefaultEncoding("UTF-8");

        // Iniciar Javalin
        Javalin app = Javalin.create(config -> {
            config.fileRenderer(new JavalinFreemarker(freemarkerConfig));
            config.staticFiles.add(staticFileConfig -> {
                staticFileConfig.hostedPath = "/";
                staticFileConfig.directory = "public";
                staticFileConfig.location = io.javalin.http.staticfiles.Location.CLASSPATH;
            });
        }).start(8080);

        // Datos de conexión a la base de datos
        String url = "jdbc:mysql://localhost:3306/Binteddb";
        String username = "root";
        String password2 = "root";

        // Crear base de datos y tabla si no existen
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/?user=" + username + "&password=" + password2)) {
            Statement stmt = conn.createStatement();
            // Crear base de datos si no existe
            stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS Binteddb");
            // Usar la base de datos
            stmt.executeUpdate("USE Binteddb");
            // Crear tabla usuarios si no existe
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS usuarios (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "usuario VARCHAR(255) UNIQUE NOT NULL," +
                    "email VARCHAR(255) UNIQUE NOT NULL," +
                    "password VARCHAR(255) NOT NULL" +
                    ")");
            // Crear tabla productos si no existe
            stmt.executeUpdate("CREATE TABLE IF NOT EXISTS productos (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY," +
                    "titulo VARCHAR(255) NOT NULL," +
                    "descripcion TEXT NOT NULL," +
                    "precio DECIMAL(10,2) NOT NULL," +
                    "localidad VARCHAR(255) NOT NULL," +
                    "imagen LONGTEXT NOT NULL," +
                    "fecha_subida DATETIME NOT NULL" +
                    ")");

            System.out.println("Base de datos y tabla verificadas/creadas exitosamente.");
        } catch (SQLException e) {
            System.out.println("Error al crear la base de datos o la tabla.");
            e.printStackTrace();
        }

        // Probar conexión inicial
        try (Connection conn = DriverManager.getConnection(url, username, password2)) {
            System.out.println("Conexión a la base de datos exitosa.");
        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos.");
            e.printStackTrace();
        }

        // Página inicial (formulario de registro)
        app.get("/", ctx -> ctx.render("login.ftl"));

        // Registro de usuarios
        app.post("/submit", ctx -> {
            Map<String, Object> model = new HashMap<>();
            String usuario = ctx.formParam("usuario");
            String email = ctx.formParam("email");
            String password = ctx.formParam("password");

            if (usuario == null || email == null || password == null ||
                    usuario.isEmpty() || email.isEmpty() || password.isEmpty()) {
                model.put("error", "Todos los campos son obligatorios.");
                ctx.render("login.ftl", model);
                return;
            }

            // Verificar si el usuario o el email ya existen
            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                // Verificar si el nombre de usuario ya existe
                String checkUserQuery = "SELECT * FROM usuarios WHERE usuario = ?";
                try (PreparedStatement checkUserStmt = conn.prepareStatement(checkUserQuery)) {
                    checkUserStmt.setString(1, usuario);
                    ResultSet userResultSet = checkUserStmt.executeQuery();
                    if (userResultSet.next()) {
                        model.put("error", "El nombre de usuario ya está en uso.");
                        ctx.render("login.ftl", model);
                        return;
                    }
                }

                // Verificar si el email ya existe
                String checkEmailQuery = "SELECT * FROM usuarios WHERE email = ?";
                try (PreparedStatement checkEmailStmt = conn.prepareStatement(checkEmailQuery)) {
                    checkEmailStmt.setString(1, email);
                    ResultSet emailResultSet = checkEmailStmt.executeQuery();
                    if (emailResultSet.next()) {
                        model.put("error", "El email ya está registrado.");
                        ctx.render("login.ftl", model);
                        return;
                    }
                }

                // Si no existe, proceder con el registro
                String query = "INSERT INTO usuarios (usuario, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, usuario);
                    stmt.setString(2, email);
                    stmt.setString(3, password);
                    stmt.executeUpdate();
                }

                model.put("mensaje", "Has registrado correctamente, " + usuario);
                // Redirigir a loginin.ftl con el mensaje de éxito
                ctx.render("loginin.ftl", model);
            } catch (SQLException e) {
                e.printStackTrace();
                model.put("error", "Error al registrar usuario: " + e.getMessage());
                ctx.render("login.ftl", model);
            }
        });

        // Página de login
        app.get("/loginin", ctx -> ctx.render("loginin.ftl"));

        // Procesar login
        app.post("/loginin", ctx -> {
            String usuario = ctx.formParam("usuario");
            String password = ctx.formParam("password");
            Map<String, Object> model = new HashMap<>();

            if (usuario == null || password == null || usuario.isEmpty() || password.isEmpty()) {
                model.put("error", "Por favor, rellena todos los campos.");
                ctx.render("loginin.ftl", model);
                return;
            }

            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                String query = "SELECT * FROM usuarios WHERE usuario = ? AND password = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, usuario);
                    stmt.setString(2, password);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        ctx.sessionAttribute("usuario", usuario);
                        ctx.redirect("/home");
                    } else {
                        model.put("error", "Usuario o contraseña incorrectos");
                        ctx.render("loginin.ftl", model);
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                model.put("error", "Error al acceder a la base de datos");
                ctx.render("loginin.ftl", model);
            }
        });


        // Guardar producto en la base de datos
        app.post("/subirProducto", ctx -> {
            // Parsear el JSON recibido
            Map<String, Object> producto = ctx.bodyAsClass(Map.class);

            String titulo = (String) producto.get("titulo");
            String descripcion = (String) producto.get("descripcion");
            String precioStr = producto.get("precio").toString();
            String localidad = (String) producto.get("localidad");
            String imagenBase64 = (String) producto.get("imagen");
            String fechaSubida = (String) producto.get("fecha_subida");

            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                String query = "INSERT INTO productos (titulo, descripcion, precio, localidad, imagen, fecha_subida) VALUES (?, ?, ?, ?, ?, ?)";

                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, titulo);
                    stmt.setString(2, descripcion);
                    stmt.setBigDecimal(3, new java.math.BigDecimal(precioStr));
                    stmt.setString(4, localidad);
                    stmt.setString(5, imagenBase64);
                    stmt.setTimestamp(6, Timestamp.valueOf(fechaSubida.replace("T", " ").substring(0, 19)));

                    stmt.executeUpdate();
                }

                ctx.status(200);
                ctx.result("Producto guardado exitosamente");
            } catch (SQLException e) {
                e.printStackTrace();
                ctx.status(500);
                ctx.result("Error al guardar el producto en la base de datos: " + e.getMessage());
            }
        });

        // Página principal tras login
        app.get("/home", ctx -> {
            Map<String, Object> model = new HashMap<>();
            String usuario = ctx.sessionAttribute("usuario");

            model.put("usuario", usuario != null ? usuario : "Invitado");
            model.put("currentIndex", 0);
            ctx.render("home.ftl", model);
        });

        // RSS Feed de productos recientes
        app.get("/rss", ctx -> {
            String rssContent = RssFeedGenerator.generateRssFeed();
            ctx.contentType("application/rss+xml");
            ctx.result(rssContent);
        });


    }
}
