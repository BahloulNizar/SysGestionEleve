package dao;

import Metier.Releve;
import java.util.List;

public interface IReleve {
    void addReleve(Releve r);
    Releve getReleve(int id);
    List<Releve> getAllReleves();
}