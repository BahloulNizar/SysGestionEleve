package dao;

import Metier.Note;
import java.util.List;

public interface INote {

    void addNote(Note n);

    void updateNote(Note n);

    void deleteNote(int id);

    Note getNote(int id);

    List<Note> getNotesByEleve(int eleveId);

    List<Note> getNotesByMatiere(int matiereId);

    List<Note> getAllNotes();
}