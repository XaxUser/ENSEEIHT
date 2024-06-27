package pack.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Critere {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int mot_cle;
	private String lieu;
	private String duree;
	private String secteur;
	private String poste;
	
	public Critere() {
		
	}
	
	
	public void setKey(int mot_cle) {
		this.mot_cle = mot_cle;
	}
	
	public int getKey() {
		return this.mot_cle ;
	}	
	
	public void setLieu(String lieu) {
		this.lieu = lieu;
	}
	
	public String getLieu() {
		return this.lieu ;
	}	
	
	public void setDuree(String duree) {
		this.duree = duree;
	}
	
	public String getDuree() {
		return this.duree ;
	}	
	
	public void setSecteur(String secteur) {
		this.secteur = secteur;
	}
	
	public String getSecteur() {
		return this.secteur ;
	}	
	
	public void setPoste(String poste) {
		this.poste = poste;
	}
	
	public String getPoste() {
		return this.poste ;
	}	
	
	
}
