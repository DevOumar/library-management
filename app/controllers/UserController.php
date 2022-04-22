<?php

declare(strict_types=1);

use Phalcon\Security\Exception;
use Ramsey\Uuid\Uuid;
use Phalcon\Security\Random;

class UserController extends ControllerBase
{

    public function indexAction($type = null)
    {

        

        // Filtrage par étudiant par compte
        $user_id = $this->session->get('id');

        if ($this->session->get('role') == "ETUDIANT") {
            $user =  Users::findFirst($user_id);
            $this->view->users = Users::find(["role = 'ETUDIANT' AND matricule = '" . $user->matricule . "'"]);
        } elseif ($this->session->get('role') == "PROFESSEUR") {
            $user =  Users::findFirst($user_id);
            $this->view->users = Users::find(["role = 'PROFESSEUR' AND matricule = '" . $user->matricule . "'"]);
        } else {

            $this->view->users = Users::find(["role = 'ETUDIANT' OR role = 'PROFESSEUR'"]);
        }


        // Filtrage nombre etudiants inscrits 
        if ($type == "nombre-etudiant") {
            if ($this->session->get('role') == "ADMINISTRATEUR") {
                $user =  Users::findFirst($user_id);

                $this->view->users = Users::find(["role = 'ETUDIANT'"]);
            }
        }
        if ($type == "nombre-professeur") {
            if ($this->session->get('role') == "ADMINISTRATEUR") {
                $user =  Users::findFirst($user_id);

                $this->view->users = Users::find(["role = 'PROFESSEUR'"]);
            }
        }
    }

    public function administrateurAction()
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if ($this->session->get('role') == "ADMINISTRATEUR") {

            $this->view->users = Users::find(["role = 'ADMINISTRATEUR'"]);
        }
    }

    public function newAction()
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if ($this->request->isPost()) {
            $data = $this->request->getPost();

            $verifUserExist  = Users::findFirst([
                'telephone = :telephone:',
                'bind' => [
                    'telephone' => $data['telephone'],
                ]
            ]);
            $userForm = new UserForm();

            if ($verifUserExist) {
                $this->flash->error("Ce numéro de téléphone " . $data['telephone'] . " est déjà utilisé.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/new');
                return;
            }

            $verifUserExist  = Users::findFirst([
                'pseudo = :pseudo:',
                'bind' => [
                    'pseudo' => $data['pseudo'],
                ]
            ]);
            $userForm = new UserForm();

            if ($verifUserExist) {
                $this->flash->error("Le pseudo " . $data['pseudo'] . " est déjà utilisé.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/new');
                return;
            }

            $verifUserExist  = Users::findFirst([
                'email = :email:',
                'bind' => [
                    'email' => $data['email'],
                ]
            ]);
            $userForm = new UserForm();

            if ($verifUserExist) {
                $this->flash->error("L'adresse e-mail " . $data['email'] . " déjà utilisée.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/new');
                return;
            }

            $user = new Users();

            if ($userForm->isValid($data, $user)) {
                $user->status = 1;
                $user->create_date = date('Y-m-d H:i:s');
                $user->initials = $user->nom[0] . '.' . $user->prenom[0];
                $user->password = $this->security->hash("123456");
                $user->id_cycle = ($user->role != "ETUDIANT") ? NULL : $user->id_cycle;
                $user->id_filiere = ($user->role != "ETUDIANT") ? NULL : $user->id_filiere;
                $user->save();

                if (!$user->save()) {
                }
                $this->flash->success("L'utilisateur " . ($user->prenom) . " " . strtoupper($user->nom) . " a été crée avec succès.");
                $this->response->redirect("user");
            } else {
            }
        }
        $userForm = new UserForm();
        $this->view->form = $userForm;
    }

    public function editAction($id = null)
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }

        if ($id == null || !is_numeric($id)) {
            $this->flash->error("Objet introuvable !");
            $this->response->redirect("user");
            return;
        }

        if ($id == null) {
            $this->response->redirect("errors/show403");
            return;
        }

        if ($id > 0) {

            $user = Users::findFirst($id);
            if (!$user) {
                $this->flash->error("Objet introuvable !");
                $this->response->redirect("user");
                return;
            }

            $values = (array)$user;

            $this->tag->setDefaults($values);

            $userForm = new UserForm();

            if ($this->request->isPost()) {
                $data = $this->request->getPost();

                $user = Users::findFirst($id);

                if ($userForm->isValid($data, $user)) {
                    $user->update_date = date('Y-m-d H:i:s');
                    if (!$user->save()) {
                    }

                    $this->flash->success("Objet modifié avec succès !");
                    $this->response->redirect("user");
                }
            }
            $this->view->form = $userForm;
            $this->view->user = $user;
        }
    }

    private function _createSession($user)
    {

        $this->session->set("id", $user->id);
        $this->session->set("matricule", $user->matricule);
        $this->session->set("nom", $user->nom);
        $this->session->set("prenom", $user->prenom);
        $this->session->set("pseudo", $user->pseudo);
        $this->session->set("email", $user->email);
        $this->session->set("telephone", $user->telephone);
        $this->session->set("photo", $user->photo);
        $this->session->set("id_cycle", $user->id_cycle);
        $this->session->set("libelle", $user->getCycle()->libelle);
        $this->session->set('token_activation', $user->token_activation);
        $this->session->set("role", $user->role);
    }

    public function inscriptionAction()
    {

        $uuid = Uuid::uuid6();

        if ($this->request->isPost()) {
            $data = $this->request->getPost();
            $verifUserExist  = Users::findFirst([
                'pseudo = :pseudo:',
                'bind' => [
                    'pseudo' => $data['pseudo'],
                ]
            ]);
            $userForm = new UserForm();

            if ($verifUserExist) {
                $this->flash->error("Le pseudo " . $data['pseudo'] . " est déjà utilisé.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/inscription');
                return;
            }
            $verifUserExist  = Users::findFirst([
                'telephone = :telephone:',
                'bind' => [
                    'telephone' => $data['telephone'],
                ]
            ]);
            $userForm = new UserForm();

            if ($verifUserExist) {
                $this->flash->error("Ce numéro de téléphone " . $data['telephone'] . " est déjà utilisé.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/inscription');
                return;
            }


            $verifUserExist  = Users::findFirst([
                'email = :email:',
                'bind' => [
                    'email' => $data['email'],
                ]
            ]);
            $userForm = new UserForm();

            if ($verifUserExist) {
                $this->flash->error("L'adresse e-mail " . $data['email'] . " est déjà utilisée.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/inscription');
                return;
            }

            $user = new Users();


            if ($data["password"] == $data["con_password"]) {
                $user->password = $this->security->hash($data["password"]);
            } else {
                $this->flash->error("Les deux mots de passe ne se correspondent pas.");
                $this->tag->setDefaults($data);
                $this->view->form = $userForm;
                $this->view->disable();
                $this->view->partial('user/inscription');
                return;
            }

            $mail = new Mail();
            $email = $_POST['email'];
            if ($userForm->isValid($data, $user)) {
                $user->status = 0;
                // $user->id_role = 3;
                $user->create_date = date('Y-m-d H:i:s');
                $user->id_cycle = ($user->role != "ETUDIANT") ? NULL : $user->id_cycle;
                $user->id_filiere = ($user->role != "ETUDIANT") ? NULL : $user->id_filiere;
                $user->initials = $user->nom[0] . '.' . $user->prenom[0];
                $user->password = $this->security->hash($user->password);
                $user->token_activation = $uuid;
                $user->save();

                if (!$user->save()) {
                    $messages = $user->getMessages();
                    foreach ($messages as $key => $msg) {
                        $this->flash->error($msg);
                        $this->response->redirect("user/inscription");
                        return;
                    }
                }

                $params = [
                    'link' => 'http://bibliotheques.lan/user/activation?token_activation=' . $uuid,
                    'nom' => $user->nom,
                    'prenom' => $user->prenom

                ];

                if (!$mail->send($email, 'inscription_user', $params)) {
                    $this->flash->error('Non envoyé');

                    return 0;
                }
                $this->flash->success(strtoupper($user->prenom) . ", vous êtes inscrit avec succès ! Nous avons envoyé par mail votre lien d'activation. Connectez-vous pour activer votre compte.");
                $this->response->redirect("user/inscription");
            }
        }
        $userForm = new UserForm();

        $this->view->form = $userForm;
    }

    public function activationAction()
    {

        $data = $this->request->get();
        $token_activation = $this->request->get("token_activation");
        $user = Users::findFirst(['token_activation =:token_activation:', 'bind' => ['token_activation' => $token_activation]]);
        // var_dump($user);exit();
        if ($user) {
            $user->status = 1;
            $user->token_activation = NULL;
            $user->save();
            $this->flash->success("Votre compte a été activé avec succès !");
            $this->response->redirect("user/connexion");
        } else {
            $this->flash->error("La clé d'activation est invalide ou expirée.");
            $this->response->redirect("user/connexion");
        }
    }

    public function connexionAction()
    {

        if ($this->request->isPost()) {
            $data = $this->request->getPost();
           // var_dump($data);exit();
            if (empty($data["email"]) && empty($data["password"])) {
                $this->flash->error("Veuillez saisir votre identifiant et votre mot de passe");
            } else {
                $user = Users::findFirst([
                    "email = :email:",
                    "bind" => [
                        "email" => $data["email"]
                    ]
                ]);

                  if ($data['role'] !== $user->role) {
                    
                      $this->flash->error("Vous n'êtes pas autorisé à accéder à cette ressource !");
                      $this->response->redirect("user/connexion");
                      return;
                  }
                
                if ($user && $this->security->checkHash($data["password"], $user->password)) {

                    if ($user->status == false or $user->status == NULL) {
                        $this->flash->error("Accès non autorisé, ce compte est désactivé !");
                        $this->response->redirect("user/connexion");
                        return;
                    }

                    $user->datepreviouslogin = $user->datelastlogin;
                    $user->datelastlogin = date('Y-m-d H:i:s');
                    $user->save();

                    $this->_createSession($user);

                    $this->response->redirect("dashboard");
                } else {
                    $this->flash->error("Identifiant incorrect !");
                }
            }
        }
    }

    public function logoutAction()
    {
        $this->session->destroy();
        $this->flash->error("Vous êtes déconnecté !");
        $this->response->redirect("user?access=out");
        return;
    }

    public function profilAction()
    {

        $this->view->user_id = $this->session->get('id');

        $user_id = $this->session->get('id');

        $user = Users::findFirstById($user_id);

        $values = (array)$user;

        $this->tag->setDefaults($values);

        $userForm = new UserForm();

        if ($this->request->isPost()) {
            $data = $this->request->getPost();

            if ($userForm->isValid($data, $user)) {

                if ($this->request->hasFiles() == true) {

                    $files = $this->request->getUploadedFiles();
                    $uploadDirPhoto = FILES_USERS_UPLOAD_DIR;
                    $extensions = ['jpg', 'png', 'jpeg'];
                    foreach ($files as $key => $file) {

                        if (!in_array(strtolower($file->getExtension()), $extensions)) {
                            $this->flash->error('Ce type d\'extension n\'est pas acceptée. Les extensions acceptées sont Jpg, Png, Jpeg');

                            $this->response->redirect("user");
                            return;
                        }
                        if ($file->getSize() > 10000000) {

                            $this->flash->error('Oops! Fichier trop volumineux, la taille maximale acceptée est 10Mo');

                            $this->response->redirect("user");
                            return;
                        }
                        if ($file->getName() != null && $file->getName() != "") {
                            if ($user->photo != null && file_exists($uploadDirPhoto . $user->photo) && $user->photo != "avatar1.png") {
                                unlink($uploadDirPhoto . $user->photo);
                            }

                            $filename   = uniqid() . '_' . date('d-m-Y') . '.' . $file->getExtension();
                            // Move the file into the application

                            $file->moveTo(
                                $uploadDirPhoto . $filename
                            );
                            $user->photo     = $filename;
                        }
                    }
                }
                if (!$user->save()) {
                }

                $this->flash->success("Profil modifié avec succès !");
                $this->response->redirect("user/profil");
            }
        }
        $this->view->form = $userForm;
        $this->view->user = $user;
    }

    public function resetPasswordAction()
    {

        $this->view->user_id = $this->session->get('id');

        $user_id = $this->session->get('id');

        $user = Users::findFirst($user_id);

        if (!$user) {
            $this->flash->error("Objet introuvable !");
            $this->response->redirect("user");
            return;
        }

        $resetPasswordForm = new ResetPasswordForm();

        if ($this->request->isPost()) {
            $data = $this->request->getPost();

            /* var_dump($data["new_password"]);exit; */
            if ($this->security->checkHash($data["old_password"], $user->password)) {

                if ($data["new_password"] == $data["con_password"]) {
                    $user->password = $this->security->hash($data["new_password"]);
                } else {
                    $this->flash->error("Le nouveau mot de passe et le mot de passe de confirmation ne correspondent pas.");
                    $this->response->redirect("user/resetPassword");
                    return;
                }
            } else {
                $this->flash->error("Mot de passe actuel incorrect !");
                $this->response->redirect("user/resetPassword");
                return;
            }

            if (!$user->save()) {
            }

            $this->flash->success("Mot de passe modifié avec succès !");
            //$this->response->redirect("user/details/".$compte->id);
            $this->response->redirect("user/resetPassword");
        }
        $this->view->form = $resetPasswordForm;
        $this->view->user = $user;
    }

    public function resetpasswordUserAction()
    {

        if ($this->request->isPost()) {
            $uuid = Uuid::uuid6();
            $data = $this->request->getPost();
            $verifUserEmail  = Users::findFirst([
                'email = :email:',
                'bind' => [
                    'email' => $data['email'],
                ]
            ]);

            if (!$verifUserEmail) {
                $this->flash->error("Échec d'envoi, veuillez réessayer !");
                $this->response->redirect("user/resetpasswordUser");
                return;
            } else {
                $mail = new Mail();
                $email = $_POST['email'];
                $user = Users::findFirstByEmail($email);
                $user->token_activation = $uuid;
                $user->save();
            }

            $params = [
                'link' => 'http://bibliotheques.lan/user/confirmation?token_activation=' . $user->token_activation,
                'email' => $user->email,
                'nom' => $user->nom,
                'prenom' => $user->prenom

            ];

            if (!$mail->send($email, 'resetUser', $params)) {
                $this->flash->error('Non envoyé');

                return 0;
            }
            $this->flash->success("Demande envoyé avec succès. Veuillez suivre l'instruction pour reinitiliaser votre mot de passe !");
            $this->response->redirect("user/resetpasswordUser");
            return;
        }
    }

    public function confirmationAction()
    {

        $token_activation = $this->request->get("token_activation");
        $user = Users::findFirstByToken_activation($token_activation);

        if (!$token_activation) {
            $this->response->redirect("errors/show403");
            return;
        }

        $this->view->user = $user;

        $resetPasswordForm = new ResetPasswordForm();

        if ($this->request->isPost()) {
            $token_activation = $this->request->get("token_activation");

            $data = $this->request->getPost();

            $user = Users::findFirstByToken_activation($token_activation);

            if (!$user) {
                $this->flash->error("Token invalide ou expiré.");
                $this->response->redirect("user/confirmation?token_activation=$token_activation");
                return;
            }

            if ($data["new_password"] == $data["con_password"]) {
                $user->password = $this->security->hash($data["new_password"]);
            } else {
                $this->flash->error("Le nouveau mot de passe et le mot de passe de confirmation ne correspondent pas.");
                $this->response->redirect("user/confirmation?token_activation=$token_activation");
                return;
            }
            $user->token_activation = NULL;
            if (!$user->save()) {
            }

            $this->flash->success("Mot de passe modifié avec succès !");
            //$this->response->redirect("user/details/".$compte->id);
            $this->response->redirect("user/confirmation?token_activation=$token_activation");
            return;
        }
        $this->view->token_activation = $token_activation;
        $this->view->form = $resetPasswordForm;
        $this->view->user = $user;
    }

    public function infosAction()
    {
        if ($this->request->isPost()) {
            $data = $this->request->getPost();
            $verifUserExist  = Users::findFirst([
                'email = :email:',
                'bind' => [
                    'email' => $data['email'],
                ]
            ]);

            if (isset($verifUserExist) == 1) {
                echo "<span style='color:red'> cet adresse e-mail est déjà utilisée.</span>";
                echo "<script>$('#submit').prop('disabled',true);</script>";
                if ($verifUserExist->status == false) {
                    echo "<span style='color:red'> Compte utilisateur bloqué.</span>";
                    echo "<script>$('#submit').prop('disabled',true);</script>";
                }
            } elseif (filter_var($data['email'], FILTER_VALIDATE_EMAIL) === false) {
                echo "<span style='color:red'> saisissez une adresse e-mail valide.</span>";
                echo "<script>$('#submit').prop('disabled',true);</script>";
            } else {
                echo "<span style='color:green'> adresse e-mail disponible pour inscription.</span>";
                echo "<script>$('#submit').prop('disabled',false);</script>";
            }
        }
    }


    public function updateStatusAction($id)
    {

        $user = Users::findFirst($id);

        if ($user->status == true) {
            $user->status = false;
            $user->save();

            echo 1;
            exit;
        } else {
            $user->status = true;
            $user->save();
            echo 1;
            exit;
        }

        echo 0;
        exit;
    }
    public function deleteAction($id)
    {
        if ($this->session->role != "ADMINISTRATEUR") {
            $this->response->redirect("errors/show403");
            return;
        }


        if ($id > 0) {
            $elm = Users::findFirst($id);

            if (!$elm) {
                echo 0;
                exit();
            }

            if ($this->request->isAjax()) {
                if (!$elm->delete()) {
                    echo 0;
                    exit();
                } else {
                    echo 1;
                    exit();
                }
            }
            echo 0;
            exit();
        }

        echo 0;
        exit;
    }
}
