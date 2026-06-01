package Metier;

import jakarta.persistence.*;
import java.util.Date;

@Entity
public class Note {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private float valeur;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateSaisie;

    @ManyToOne
    @JoinColumn(name = "eleve_id")
    private Eleve eleve;

    @ManyToOne
    @JoinColumn(name = "matiere_id")
    private Matiere matiere;

    public Note() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public float getValeur() { return valeur; }
    public void setValeur(float valeur) { this.valeur = valeur; }
    public Date getDateSaisie() { return dateSaisie; }
    public void setDateSaisie(Date dateSaisie) { this.dateSaisie = dateSaisie; }
    public Eleve getEleve() { return eleve; }
    public void setEleve(Eleve eleve) { this.eleve = eleve; }
    public Matiere getMatiere() { return matiere; }
    public void setMatiere(Matiere matiere) { this.matiere = matiere; }
}