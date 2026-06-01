package web;

import dao.IAdministrateur;
import dao.ImplAdministrateur;
import dao.SingletonConnection;
import Metier.Administrateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private IAdministrateur adminDao;

    @Override
    public void init() throws ServletException {
        adminDao = new ImplAdministrateur();

        if (adminDao.login("admin@test.com", "123") == null) {
            Administrateur defaultAdmin = new Administrateur();
            defaultAdmin.setNom("Directeur FST");
            defaultAdmin.setEmail("admin@test.com");
            defaultAdmin.setMotDePasse("123");
            adminDao.addAdmin(defaultAdmin);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        Administrateur admin = adminDao.login(email, pass);

        if (admin != null) {
            admin.setNom("Directeur FST");

            EntityManager em = SingletonConnection.getEntityManager();
            EntityTransaction tx = em.getTransaction();
            try {
                tx.begin();
                em.merge(admin);
                tx.commit();
            } catch (Exception e) {
                if (tx.isActive()) tx.rollback();
                e.printStackTrace();
            }

            HttpSession session = request.getSession();
            session.setAttribute("adminSession", admin);

            response.sendRedirect("dashboard.jsp");

        } else {
            request.setAttribute("erreur", "Email ou mot de passe incorrect !");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}