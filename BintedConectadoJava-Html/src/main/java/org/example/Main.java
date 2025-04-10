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
        String url = "jdbc:mysql://localhost:3307/Binteddb";
        String username = "root"; // Usa tu nombre de usuario de MySQL
        String password2 = "root"; // Usa tu contraseña de MySQL
        try (Connection conn = DriverManager.getConnection(url, username, password2)) {
            System.out.println("Conexión a la base de datos exitosa.");
        } catch (SQLException e) {
            System.out.println("Error al conectar a la base de datos.");
            e.printStackTrace();
        }

        // Ruta principal que renderiza el formulario de login
        app.get("/", ctx -> {
            ctx.render("login.ftl");
        });

        // Ruta para manejar el formulario enviado
        app.post("/submit", ctx -> {
            Map<String, Object> model = new HashMap<>();
            String usuario = ctx.formParam("usuario");
            String email = ctx.formParam("email");
            String password = ctx.formParam("password");

            // Guardar usuario y contraseña en la base de datos
            try (Connection conn = DriverManager.getConnection(url, username, password2)) {
                String query = "INSERT INTO usuarios (usuario, email, password) VALUES (?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, usuario);
                    stmt.setString(2,email);
                    stmt.setString(3, password);
                    stmt.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

            // Pasar los datos al template
            model.put("usuario", usuario);
            model.put("password", password);
            ctx.render("respuesta.ftl", model);
        });
    }
}
