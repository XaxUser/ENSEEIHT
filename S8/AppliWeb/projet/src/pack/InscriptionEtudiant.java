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

@WebServlet("/InscriptionEtudiantServlet")
public class InscriptionEtudiant extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private CompteFacade compteFacade;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "InscriptionEtudiant");
        request.getRequestDispatcher("/inscriptionetudiant.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String adresse = request.getParameter("adresse");
        String phone = request.getParameter("phone");





        Compte compte = new Compte();
        compte.setUsername(username);
        compte.setPassword(password);
        compte.setEmail(email);
        compte.setNom(nom);
        compte.setPrenom(prenom);
        compte.setAdresse(adresse);
        compte.setPhone(phone);

        try {
            compteFacade.createCompte(compte);
            response.sendRedirect(request.getContextPath() + "/ConnexionEtudiantServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de l'inscription. Veuillez réessayer.");
            request.getRequestDispatcher("/inscriptionetudiant.jsp").forward(request, response);
        }
    }
}
