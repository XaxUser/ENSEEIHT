package pack.entities;

import javax.persistence.*;

@Entity
public class OffrePostulee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne
    @JoinColumn(name = "compte_id")
    private Compte compte;

    @ManyToOne
    @JoinColumn(name = "offre_id")
    private Offre offre;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Compte getCompte() {
        return compte;
    }

    public void setCompte(Compte compte) {
        this.compte = compte;
    }

    public Offre getOffre() {
        return offre;
    }

    public void setOffre(Offre offre) {
        this.offre = offre;
    }
}
