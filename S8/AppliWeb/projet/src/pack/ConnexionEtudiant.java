package pack;

import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pack.entities.Compte;
import pack.facade.CompteFacade;

@WebServlet("/ConnexionEtudiantServlet")
public class ConnexionEtudiant extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private CompteFacade compteFacade;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = request.getParameter("error");
        if (error != null && error.equals("invalid")) {
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect");
        }

        request.setAttribute("pageTitle", "ConnexionEtudiant");
        request.getRequestDispatcher("/connexionetudiant.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Compte compte = compteFacade.findByUsernameAndPassword(username, password);
        
        if (compte != null) {
            Compte compteAvecOffres = compteFacade.findCompteWithOffres(compte.getId());

            request.setAttribute("offres", compteFacade.listerOffres());
            request.getSession().setAttribute("compte", compteAvecOffres);

            request.getRequestDispatcher("/offresConnexion.jsp").forward(request, response);
        } else {
            response.sendRedirect("ConnexionEtudiantServlet?error=invalid");
        }
    }
}
