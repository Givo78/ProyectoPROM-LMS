package org.example;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class TrabajadorDAO {
    private static final SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();

    public static void guardarUsuario(Trabajador trabajador) {
        Session session = sessionFactory.openSession();
        try {
            session.beginTransaction();
            session.persist(trabajador);
            session.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        } finally {
            session.close();
        }
    }
}
