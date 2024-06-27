package pack.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Note {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int valeur;
	
	public Note() {
			
	}
		
		
	public void setId(int id) {
		this.id = id;
	}
		
	public int getId() {
		return this.id ;
	}	
	
	public void setValeur(int valeur) {
		this.valeur = valeur;
	}
		
	public int getValeur() {
		return this.valeur ;
	}	
}
