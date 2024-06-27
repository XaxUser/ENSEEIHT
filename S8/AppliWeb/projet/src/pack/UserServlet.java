package pack;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userType = request.getParameter("userType");
        String action = request.getParameter("action");

        if (userType != null && action != null) {
            if (action.equals("inscription")) {
                if (userType.equals("etudiant")) {
                    response.sendRedirect("InscriptionEtudiantServlet");
                } else if (userType.equals("entreprise")) {
                    response.sendRedirect("InscriptionEntrepriseServlet");
                } else {
                    response.sendRedirect("index.jsp?error=invalidUserType");
                }
            } else if (action.equals("connexion")) {
                if (userType.equals("etudiant")) {
                    response.sendRedirect("ConnexionEtudiantServlet");
                } else if (userType.equals("entreprise")) {
                    response.sendRedirect("ConnexionEntrepriseServlet");
                } else {
                    response.sendRedirect("index.jsp?error=invalidUserType");
                }
            } else {
                response.sendRedirect("index.jsp?error=invalidAction");
            }
        } else {
            response.sendRedirect("index.jsp?error=missingParameters");
        }
    }
}
