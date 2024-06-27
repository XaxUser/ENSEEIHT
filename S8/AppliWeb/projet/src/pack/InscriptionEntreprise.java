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

@WebServlet("/InscriptionEntrepriseServlet")
public class InscriptionEntreprise extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private CompteFacade compteFacade;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("pageTitle", "InscriptionEntreprise");
        request.getRequestDispatcher("/inscriptionentreprise.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");
        String secteur = request.getParameter("secteurActivite");
        String email = request.getParameter("email");
        String nom = request.getParameter("nom");
        String adresse = request.getParameter("adresse");
        String phone = request.getParameter("phone");
        
        
        Entreprise entreprise = new Entreprise();
        entreprise.setNom(nom);
        entreprise.setSecteurActivite(secteur);


        Compte compte = new Compte();
        compte.setPassword(password);
        compte.setEmail(email);
        compte.setNom(nom);
        compte.setAdresse(adresse);
        compte.setPhone(phone);
        
        entreprise.setCompte(compte);

        try {
            compteFacade.createCompte(compte);
            compteFacade.createEntreprise(entreprise);


            response.sendRedirect(request.getContextPath() + "/ConnexionEntrepriseServlet");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de l'inscription. Veuillez réessayer.");
            request.getRequestDispatcher("/inscriptionentreprise.jsp").forward(request, response);
        }
    }
}
