package web;

import dao.IEleve;
import dao.ImplEleve;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/supprimerEleve")
public class SupprimerEleveServlet extends HttpServlet {

    private IEleve eleveDao;

    @Override
    public void init() throws ServletException {
        eleveDao = new ImplEleve();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");

            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                eleveDao.deleteEleve(id);
            }

            response.sendRedirect("listeEleves");

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("listeEleves?error=delete");
        }
    }
}