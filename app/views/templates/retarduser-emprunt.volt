<p>Salut cher(e) utilisateur(e) <strong> {{ prenom }} {{ nom }} !</strong></p>
<p>
Suite à votre emprunt du livre : <strong> {{nom_livre |upper}} </strong>, le {{date('d-m-Y',strtotime(date_emprunt))}} dont le numéro ISBN est <strong> {{isbn}} </strong>, nous vous informons que vous êtes en retard de retour. Veuillez retourner avec le livre au plus vite possible au risque d'être sanctionné.
</p>
<br>
À bientôt,<br/>
<br>
L'équipe Bibliothèque-BIBLIO
<br>
<br>
-------------------------------------------<br><br>
Ceci est un mail automatique, merci de ne pas y répondre.