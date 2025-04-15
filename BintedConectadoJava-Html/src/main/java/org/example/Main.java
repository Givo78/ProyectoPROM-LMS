package org.example;

import io.javalin.Javalin;
import io.javalin.rendering.template.JavalinFreemarker;
import freemarker.template.Configuration;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        /* CONFIGURACION FREEMARKER */
        Configuration freemarkerConfig = new Configuration(Configuration.VERSION_2_3_31);
        freemarkerConfig.setClassForTemplateLoading(Main.class, "/templates");

        /* INICIAR JAVALIN */
        Javalin app = Javalin.create(config -> {
            config.fileRenderer(new JavalinFreemarker(freemarkerConfig));
        }).start(8080);

        // Conexión a la base de datos
        String url = "jdbc:mysql://localhost:3306/Binteddb"; //importante el puerto para probar en diferentes equipos
        String username = "root"; // Usa tu nombre de usuario de MySQL
        String password2 = "root"; // Usa tu contraseña de MySQL
        try (Connection conn = DriverManager.getConnection(url, username, password2)) {
            System.out.println("Conexión a la base de datos exitosa.");
        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos.");
            e.printStackTrace();
        }

        // Ruta principal que renderiza el formulario de registro (login.ftl)
        app.get("/", ctx -> {
            ctx.render("login.ftl");
        });

        // Ruta para manejar el formulario de registro
        app.post("/submit", ctx -> {
            Map<String, Object> model = new HashMap<>();
            String usuario = ctx.formParam("usuario");
            String email = ctx.formParam("email");
            String password = ctx.formParam("password");

            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                String query = "INSERT INTO usuarios (usuario, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, usuario);
                    stmt.setString(2, email);
                    stmt.setString(3, password);
                    stmt.executeUpdate();
                }
                model.put("mensaje", "Registro exitoso. ¡Ahora puedes iniciar sesión!");
                ctx.render("respuesta.ftl", model);
            } catch (SQLException e) {
                e.printStackTrace();
                model.put("error", "Error al registrar usuario: " + e.getMessage());
                ctx.render("login.ftl", model);
            }
        });

        // Ruta para mostrar el formulario de loginin (inicio de sesión)
        app.get("/loginin", ctx -> {
            ctx.render("loginin.ftl");
        });

// Ruta para manejar el formulario de loginin
        app.post("/loginin", ctx -> {
            String usuario = ctx.formParam("usuario");
            String password = ctx.formParam("password");
            Map<String, Object> model = new HashMap<>();

            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                String query = "SELECT * FROM usuarios WHERE usuario = ? AND password = ?";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, usuario);
                    stmt.setString(2, password);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        ctx.redirect("/home"); // Página principal tras login exitoso
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
    }
}