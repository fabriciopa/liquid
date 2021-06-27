<?
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require './PHPMailer-master/src/Exception.php';
require './PHPMailer-master/src/PHPMailer.php';
require './PHPMailer-master/src/SMTP.php';

//Server settings
$mail = new PHPMailer(true);
$mail->CharSet = 'UTF-8';
$mail->isSMTP();                                            //Send using SMTP
$mail->Host       = 'smtp.gmail.com';                     //Set the SMTP server to send through
$mail->SMTPAuth   = true;                                   //Enable SMTP authentication
$mail->Username   = 'testeliquidpetlove@gmail.com';                     //SMTP username
$mail->Password   = 'testeliquidpetlove2021.';                               //SMTP password
$mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
$mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`

$vEmails = array(
    'araujopa@gmail.com' => 'Fabrício Araújo',
    //'bruna.moreira@petlove.com.br' => 'Bruna Moreira'
);

$mail->setFrom('testeliquidpetlove@gmail.com', 'Mailer Test PetLove');

foreach($vEmails as $email=>$nome){
    try {

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, "http://127.0.0.1:3000/products?cliente_id=".$email);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        $output = curl_exec($ch);
        curl_close($ch);
    
        //Recipients
        $mail->addAddress($email, $nome);     //Add a recipient
        
        //Content
        $mail->isHTML(true);                                  //Set email format to HTML
        $mail->Subject = 'Teste email marketing PetLove';
        $mail->Body    = $output;
        $mail->AltBody = $output;
    
        $mail->send();
        echo 'Mensagem enviada';
    } catch (Exception $e) {
        echo "Mailer Error: {$mail->ErrorInfo}";
    }
}


?>