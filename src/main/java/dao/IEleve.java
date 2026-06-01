package dao;

import Metier.Eleve;
import java.util.List;

public interface IEleve {
    void addEleve(Eleve e);
    void modifyEleve(Eleve e);
    void deleteEleve(int id);
    Eleve getEleve(int id);
    List<Eleve> getListEleves();
    void updateEleve(Eleve e);
}