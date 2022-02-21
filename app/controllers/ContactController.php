<?php
declare(strict_types=1);

class ContactController extends ControllerBase
{


	public function indexAction()
	{
		if($this->request->isPost()){
			$data = $this->request->getPost();
			$contactForm = new ContactForm();
			$contact = new Contact();
			$mail = new Mail();
			$email = "cisseoumar621@gmail.com";
			if($contactForm->isValid($data, $contact)){
				$contact->nom_complet = $contact->nom_complet;
				$contact->email = $contact->email;
				$contact->telephone = $contact->telephone;
				$contact->message = $contact->message;
				$params = [
					'nom_complet' => $contact->nom_complet,
					'email' => $contact->email,
					'telephone' => $contact->telephone,
					'message' => $contact->message

				];

				if(!$mail->send($email,'contact',$params)) {
					$this->flash->error('Non envoyé');

					return 0;

				}


				if(!$contact->save()){
					var_dump($contact->getMessages());exit();
					$messages = $contact->getMessages();
					foreach ($messages as $key => $msg) {
						$this->flash->error($msg);
						$this->response->redirect("contact");
						return;
					}
				}
				$this->flash->success(strtoupper($contact->nom_complet).", votre message est envoyé avec succès ! Nous vous ferons un retour de message à l'adresse e-mail indiquée.");
				$this->response->redirect("contact");
			}
		}
		$contactForm = new ContactForm();

		$this->view->form = $contactForm;
	}
}

