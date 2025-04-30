package org.example;

import com.rometools.rome.feed.synd.*;
import com.rometools.rome.io.SyndFeedOutput;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class RssFeedGenerator {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/Binteddb";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "root";
    private static final String SITE_BASE_URL = "http://localhost:8080";
    private static final int MAX_PRODUCTS = 15;

    public static String generateRssFeed() {
        SyndFeed feed = new SyndFeedImpl();
        feed.setFeedType("rss_2.0");
        feed.setTitle("Últimos productos en Binted");
        feed.setLink(SITE_BASE_URL);
        feed.setDescription("Productos recientes publicados en Binted");

        List<SyndEntry> entries = getRecentProductsFromDatabase();
        feed.setEntries(entries != null ? entries : new ArrayList<>());

        try {
            return new SyndFeedOutput().outputString(feed);
        } catch (Exception e) {
            return generateErrorRss("Error generando el feed: " + e.getMessage());
        }
    }

    private static List<SyndEntry> getRecentProductsFromDatabase() {
        List<SyndEntry> entries = new ArrayList<>();
        String query = "SELECT id, titulo, descripcion, precio, localidad, imagen, fecha_subida " +
                "FROM productos ORDER BY fecha_subida DESC LIMIT ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, MAX_PRODUCTS);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                SyndEntryImpl entry = new SyndEntryImpl();
                entry.setTitle(String.format("%s - %.2f€ (%s)",
                        rs.getString("titulo"),
                        rs.getBigDecimal("precio"),
                        rs.getString("localidad")));

                entry.setLink(SITE_BASE_URL + "/producto?id=" + rs.getInt("id"));
                entry.setPublishedDate(rs.getTimestamp("fecha_subida"));

                SyndContent description = new SyndContentImpl();
                description.setType("text/html");
                description.setValue(buildDescriptionHtml(rs));
                entry.setDescription(description);

                entries.add(entry);
            }
        } catch (SQLException e) {
            System.err.println("Database error: " + e.getMessage());
            return null;
        }
        return entries;
    }

    private static String buildDescriptionHtml(ResultSet rs) throws SQLException {
        StringBuilder html = new StringBuilder();
        String imagen = rs.getString("imagen");

        if (imagen != null && !imagen.isEmpty()) {
            html.append("<div style='margin-bottom:15px;'>")
                    .append("<img src=\"").append(imagen).append("\" style=\"max-width:100%;height:auto;\"/>")
                    .append("</div>");
        }

        html.append("<div style='margin-bottom:10px;'>")
                .append(rs.getString("descripcion"))
                .append("</div>")
                .append("<div><strong>Precio:</strong> ")
                .append(rs.getBigDecimal("precio"))
                .append("€</div>")
                .append("<div><strong>Ubicación:</strong> ")
                .append(rs.getString("localidad"))
                .append("</div>");

        return html.toString();
    }

    private static String generateErrorRss(String message) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
                "<rss version=\"2.0\">" +
                "<channel>" +
                "<title>Error en Binted RSS</title>" +
                "<description>" + message + "</description>" +
                "</channel>" +
                "</rss>";
    }
}
