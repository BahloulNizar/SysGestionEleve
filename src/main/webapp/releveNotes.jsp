<%@ page import="java.util.List" %>
<%@ page import="Metier.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Administrateur admin = (Administrateur) session.getAttribute("adminSession");
  if (admin == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  Eleve eleve = (Eleve) request.getAttribute("eleve");
  List<Note> notes = (List<Note>) request.getAttribute("notes");

  if (eleve == null) {
    response.sendRedirect("listeEleves");
    return;
  }

  double totalPoints = 0;
  double totalCoeffs = 0;
  String dateEdition = new SimpleDateFormat("dd/MM/yyyy").format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Relevé de Notes Officiel | <%= eleve.getNom() %></title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

  <style>
    body { font-family: 'Segoe UI', Arial, sans-serif; background: #525659; margin: 0; padding: 20px 0; }
    .no-print { max-width: 210mm; margin: 0 auto 20px; display: flex; justify-content: space-between; align-items: center; background: white; padding: 15px 20px; border-radius: 4px; box-sizing: border-box; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
    .btn { padding: 8px 16px; border-radius: 4px; border: 1px solid #ccc; cursor: pointer; font-weight: 600; display: flex; align-items: center; gap: 8px; text-decoration: none; font-size: 13px; transition: 0.2s; }
    .btn-pdf { background: #d32f2f; color: white; border-color: #b71c1c; }
    .btn-pdf:hover { background: #b71c1c; }
    .btn-print { background: #1976d2; color: white; border-color: #1565c0; }
    .btn-print:hover { background: #1565c0; }
    .btn-back { background: #f5f5f5; color: #333; }
    .btn-back:hover { background: #e0e0e0; }

    .document-a4 {
      width: 210mm;
      min-height: 295mm;
      margin: 0 auto;
      background: white;
      padding: 20mm;
      box-shadow: 0 0 15px rgba(0,0,0,0.3);
      box-sizing: border-box;
      font-family: 'Times New Roman', Times, serif;
      color: #000;
      position: relative;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
      text-rendering: optimizeLegibility;
    }

    .doc-header { display: flex; justify-content: space-between; border-bottom: 2px solid #000; padding-bottom: 10px; margin-bottom: 25px; }
    .header-left { text-align: center; width: 45%; }
    .header-left h1 { margin: 0; font-size: 18px; font-weight: bold; text-transform: uppercase; }
    .header-left h2 { margin: 5px 0 0; font-size: 14px; font-weight: normal; }
    .header-right { text-align: right; font-size: 12px; width: 45%; display: flex; flex-direction: column; justify-content: flex-end; }
    .header-logo { font-size: 40px; margin-bottom: 10px; color: #1a365d; }

    .doc-title { text-align: center; font-size: 22px; font-weight: bold; text-transform: uppercase; letter-spacing: 2px; margin: 30px 0; text-decoration: underline; text-underline-offset: 5px; }

    .info-table { width: 100%; border-collapse: collapse; margin-bottom: 30px; font-size: 13px; }
    .info-table td { padding: 6px; }
    .info-label { font-weight: bold; width: 20%; }
    .info-value { width: 30%; border-bottom: 1px dotted #999; }

    .grades-table { width: 100%; border-collapse: collapse; margin-bottom: 30px; font-size: 13px; }
    .grades-table th, .grades-table td { border: 1px solid #000; padding: 8px 10px; }
    .grades-table th { background: #f0f0f0; text-align: center; font-weight: bold; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; }
    .col-matiere { text-align: left; }
    .col-center { text-align: center; width: 15%; }
    .row-total { background: #f0f0f0; font-weight: bold; }

    .resultat-box { border: 2px solid #000; padding: 10px 15px; margin-left: auto; width: 220px; background: #fafafa; }
    .resultat-line { display: flex; justify-content: space-between; margin-bottom: 5px; font-size: 13px; }
    .resultat-line.main { font-size: 15px; font-weight: bold; margin-top: 8px; border-top: 1px solid #ccc; padding-top: 8px; }

    .signatures { display: flex; justify-content: space-between; margin-top: 60px; font-size: 14px; }
    .sig-box { width: 45%; text-align: center; }
    .sig-title { font-weight: bold; text-decoration: underline; margin-bottom: 60px; }

    @media print {
      .no-print { display: none !important; }
      body { background: white; padding: 0; }
      .document-a4 { box-shadow: none; border: none; padding: 0; width: 100%; min-height: auto; margin: 0; }
    }
  </style>
</head>
<body>

<div class="no-print">
  <a href="listeEleves" class="btn btn-back"><i class="fas fa-arrow-left"></i> Retour à la liste</a>
  <div style="display:flex; gap:10px;">
    <button onclick="window.print()" class="btn btn-print"><i class="fas fa-print"></i> Imprimer le document</button>
    <button onclick="generatePDF()" class="btn btn-pdf"><i class="fas fa-file-pdf"></i> Exporter en PDF</button>
  </div>
</div>

<div class="document-a4" id="printable-area">

  <div class="doc-header">
    <div class="header-left">
      <i class="fas fa-graduation-cap header-logo"></i>
      <h1>FST</h1>
      <h2>Faculté des Sciences et Techniques</h2>
    </div>
    <div class="header-right">
      <p><strong>Année Universitaire :</strong> 2025/2026</p>
      <p><strong>Édité le :</strong> <%= dateEdition %></p>
      <p><strong>Réf :</strong> FST/SCOL/<%= eleve.getMatricule().replaceAll("[^0-9]", "") %></p>
    </div>
  </div>

  <div class="doc-title">Relevé de Notes et Résultats</div>

  <table class="info-table">
    <tr>
      <td class="info-label">Nom et Prénom :</td>
      <td class="info-value"><strong><%= eleve.getNom().toUpperCase() %> <%= eleve.getPrenom() %></strong></td>
      <td class="info-label">N° Matricule :</td>
      <td class="info-value"><%= eleve.getMatricule() %></td>
    </tr>
    <tr>
      <td class="info-label">Filière :</td>
      <td class="info-value" colspan="3"><%= (eleve.getClasse() != null && eleve.getClasse().getFiliere() != null) ? eleve.getClasse().getFiliere().getNom() : "Non assignée" %></td>
    </tr>
  </table>

  <table class="grades-table">
    <thead>
    <tr>
      <th>Module / Éléments constitutifs</th>
      <th class="col-center">Coefficient</th>
      <th class="col-center">Note / 20</th>
      <th class="col-center">Note Pondérée</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (notes != null && !notes.isEmpty()) {
        for (Note n : notes) {
          double coeff = n.getMatiere().getCoefficient();
          double noteVal = n.getValeur();
          double ponderee = noteVal * coeff;
          totalPoints += ponderee;
          totalCoeffs += coeff;
    %>
    <tr>
      <td class="col-matiere"><%= n.getMatiere().getLibelle() %></td>
      <td class="col-center"><%= String.format("%.1f", coeff) %></td>
      <td class="col-center"><strong><%= String.format("%.2f", noteVal) %></strong></td>
      <td class="col-center"><%= String.format("%.2f", ponderee) %></td>
    </tr>
    <%
      }
    } else {
    %>
    <tr><td colspan="4" style="text-align:center; padding:20px; font-style: italic;">Aucune note n'a été saisie pour le moment.</td></tr>
    <% } %>
    </tbody>
    <tfoot>
    <tr class="row-total">
      <td style="text-align: right; padding-right: 15px;">TOTAL DES COEFFICIENTS ET POINTS</td>
      <td class="col-center"><%= String.format("%.1f", totalCoeffs) %></td>
      <td class="col-center">-</td>
      <td class="col-center"><%= String.format("%.2f", totalPoints) %></td>
    </tr>
    </tfoot>
  </table>

  <%
    double moyenneG = (totalCoeffs > 0) ? (totalPoints / totalCoeffs) : 0;
    String mention = (moyenneG >= 16) ? "Très Bien" : (moyenneG >= 14) ? "Bien" : (moyenneG >= 12) ? "Assez Bien" : (moyenneG >= 10) ? "Passable" : "Ajourné";
  %>

  <div class="resultat-box">
    <div class="resultat-line">
      <span>Total points :</span>
      <span><%= String.format("%.2f", totalPoints) %></span>
    </div>
    <div class="resultat-line main">
      <span>MOYENNE :</span>
      <span><%= String.format("%.2f", moyenneG) %> / 20</span>
    </div>
    <div class="resultat-line" style="margin-top: 8px; justify-content: center; font-weight: bold; text-transform: uppercase;">
      Décision : <%= mention %>
    </div>
  </div>

  <div class="signatures">
    <div class="sig-box">
      <div class="sig-title">Signature de l'Étudiant(e)</div>
    </div>
    <div class="sig-box">
      <div class="sig-title">Le Doyen / Le Directeur</div>
      <p style="font-size: 11px; font-style: italic; color: #555;">(Cachet de l'établissement et signature)</p>
    </div>
  </div>

</div>

<script>
  function generatePDF() {
    const element = document.getElementById('printable-area');
    element.style.margin = '0';

    const opt = {
      margin:       0,
      filename:     'Releve_Officiel_<%= eleve.getMatricule() %>.pdf',
      image:        { type: 'png' },
      html2canvas:  { scale: 2, useCORS: true, scrollX: 0, scrollY: 0 },
      jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
    };

    return html2pdf().set(opt).from(element).save().then(() => {
      element.style.margin = '0 auto';
    });
  }

  window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('download') === 'true') {
      generatePDF().then(() => {
        setTimeout(() => {
          window.close();
        }, 600);
      });
    }
  });
</script>

</body>
</html>