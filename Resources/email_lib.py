import smtplib
import os
from email.message import EmailMessage

def enviar_correo_gmail_nativo(usuario, password, destinatario, asunto, cuerpo, ruta_adjunto):
    
    if password:
        password = password.strip().replace(" ", "")
        
    msg = EmailMessage()
    msg['Subject'] = asunto
    msg['From'] = usuario
    msg['To'] = destinatario
    msg.set_content(cuerpo)

    # Validar y adjuntar archivo
    if ruta_adjunto and os.path.isfile(ruta_adjunto):
        with open(ruta_adjunto, 'rb') as f:
            file_data = f.read()
            file_name = os.path.basename(ruta_adjunto)
        
        msg.add_attachment(file_data, maintype='application', subtype='pdf', filename=file_name)
    else:
        print(f"ADVERTENCIA: No se encontró el adjunto en: {ruta_adjunto}")

    # Conexión Segura con Gmail (Puerto 465 SSL estándar)
    try:
        with smtplib.SMTP_SSL('smtp.gmail.com', 465) as smtp:
            smtp.login(usuario, password)
            smtp.send_message(msg)
            print("Correo enviado exitosamente.")
            return True
    except Exception as e:
        print(f"Error enviando correo: {e}")
        raise e