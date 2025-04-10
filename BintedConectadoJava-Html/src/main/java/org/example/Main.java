package org.example;
import io.javalin.Javalin;
import io.javalin.rendering.template.JavalinFreemarker;
import freemarker.template.Configuration;
import java.util.HashMap;
import java.util.Map;

public class Main {
    public static void main(String[] args) {
        /*CONFIGURACION FREEMARKER*/
        Configuration freemarkerConfig = new Configuration(Configuration.VERSION_2_3_31);
        freemarkerConfig.setClassForTemplateLoading(Main.class, "/templates");
        /* INICIAR JAVALIN*/
        Javalin app = Javalin.create(config -> {
            config.fileRenderer(new JavalinFreemarker(freemarkerConfig));
        }).start(8080);
        app.get("/", ctx ->{
            ctx.render("login.ftl");
        });
        app.post("/submit", ctx-> {
            Map<String,Object> model= new HashMap<>();
            String usuario = ctx.formParam("usuario");
            String password = ctx.formParam("password");
            model.put("usuario", usuario);
            model.put("password", password);
            ctx.render("respuesta.ftl", model);
        });


    }
}