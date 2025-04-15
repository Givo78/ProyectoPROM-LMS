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
        }).start(8080);

        // Datos de conexión a la base de datos
        String url = "jdbc:mysql://localhost:3306/Binteddb";
        String username = "root";
        String password2 = "root";

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

            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                String query = "INSERT INTO usuarios (usuario, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, usuario);
                    stmt.setString(2, email);
                    stmt.setString(3, password);
                    stmt.executeUpdate();
                }
                model.put("mensaje", "Registro exitoso. ¡Ahora puedes iniciar sesión!");
                model.put("usuario", usuario);
                ctx.render("respuesta.ftl", model);
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

        // Página principal tras login
        app.get("/home", ctx -> {
            Map<String, Object> model = new HashMap<>();
            String usuario = ctx.sessionAttribute("usuario");

            model.put("usuario", usuario != null ? usuario : "Invitado");
            model.put("currentIndex", 0);
            ctx.render("home.ftl", model);
        });
    }
}
