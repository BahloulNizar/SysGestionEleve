package Metier;

import jakarta.persistence.*;
import java.util.Date;

@Entity
public class Releve {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Temporal(TemporalType.TIMESTAMP)
    private Date dateGeneration;

    @Lob
    private byte[] contenuPDF;

    @OneToOne
    @JoinColumn(name = "eleve_id")
    private Eleve eleve;

    public Releve() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public Date getDateGeneration() { return dateGeneration; }
    public void setDateGeneration(Date dateGeneration) { this.dateGeneration = dateGeneration; }
    public byte[] getContenuPDF() { return contenuPDF; }
    public void setContenuPDF(byte[] contenuPDF) { this.contenuPDF = contenuPDF; }
    public Eleve getEleve() { return eleve; }
    public void setEleve(Eleve eleve) { this.eleve = eleve; }
}