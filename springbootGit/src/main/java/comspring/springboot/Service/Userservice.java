package comspring.springboot.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class Userservice {

    
    @Autowired
    private JavaMailSender javaMailSender;

    
    @Value("${spring.mail.username}")
    private String fromEmail;

    public boolean sendEmail(String message, String toEmail, int subjectType) {

        String subject = "Verify Your Email Adddress";
        String subject2 = "Application Creation Confirmation";
        String subject3 = "OTP to Reset Password";
        try {

            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();

            simpleMailMessage.setTo(toEmail);
            simpleMailMessage.setFrom(fromEmail);
            if (subjectType == 1) {
            simpleMailMessage.setSubject(subject);
                
            } else if(subjectType == 2){
            simpleMailMessage.setSubject(subject2);
                
            } else {
            simpleMailMessage.setSubject(subject3);

            }
            simpleMailMessage.setText(message);

            javaMailSender.send(simpleMailMessage);
            return true;

        } catch (Exception e) {

            e.printStackTrace();
            return false;
        }
    }

    
}
