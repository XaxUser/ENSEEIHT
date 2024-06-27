package pack;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pack.entities.Compte;
import pack.entities.Entreprise;
import pack.facade.CompteFacade;

@WebServlet("/ConnexionEntrepriseServlet")
public class ConnexionEntreprise extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private CompteFacade compteFacade;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String error = request.getParameter("error");
        if (error != null && error.equals("invalid")) {
            request.setAttribute("errorMessage", "Nom d'utilisateur ou mot de passe incorrect");
        }

        request.setAttribute("pageTitle", "ConnexionEntreprise");
        request.getRequestDispatcher("/connexionentreprise.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        


        Compte compte = compteFacade.findByEmailAndPassword(email, password);
        request.setAttribute("offres", compteFacade.listerOffres());


        if (compte != null) {
        	
            Entreprise entreprise = compteFacade.findEntrepriseByCompte(compte);
            
            request.getSession().setAttribute("entreprise", entreprise);


            response.sendRedirect(request.getContextPath() + "/CreationOffreServlet");

        } else {
            response.sendRedirect("ConnexionEntrepriseServlet?error=invalid");
        }
    }
}
