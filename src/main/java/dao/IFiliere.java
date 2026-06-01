package dao;

import Metier.Filiere;
import java.util.List;

public interface IFiliere {
    public void ajouterFiliere(Filiere f);
    public List<Filiere> listerFilieres();
    public void supprimerFiliere(int id);
    public Filiere getFiliere(int id);
}