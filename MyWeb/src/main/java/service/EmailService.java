package service;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.InputStream;
import java.util.Optional;
import java.util.Properties;

/**
 * Lightweight email sender for registration flow.
 * Reads SMTP config from classpath mail.properties or environment variables (MAIL_*).
 */
public class EmailService {
    private final Properties props = new Properties();
    private final boolean enabled;
    private final String from;

    public EmailService() {
        loadProperties();
        this.enabled = Boolean.parseBoolean(props.getProperty("mail.enabled", "false"))
                && hasText(props.getProperty("mail.smtp.host"))
                && hasText(props.getProperty("mail.smtp.user"));
        this.from = props.getProperty("mail.from", props.getProperty("mail.smtp.user", "noreply@example.com"));
    }

    private void loadProperties() {
        // Load from classpath mail.properties if present
        try (InputStream in = EmailService.class.getClassLoader().getResourceAsStream("mail.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (Exception ignored) {
        }
        // Env overrides (if provided)
        putIfPresent("mail.enabled", System.getenv("MAIL_ENABLED"));
        putIfPresent("mail.smtp.host", System.getenv("MAIL_SMTP_HOST"));
        putIfPresent("mail.smtp.port", System.getenv("MAIL_SMTP_PORT"));
        putIfPresent("mail.smtp.user", System.getenv("MAIL_SMTP_USER"));
        putIfPresent("mail.smtp.password", System.getenv("MAIL_SMTP_PASSWORD"));
        putIfPresent("mail.smtp.starttls.enable", System.getenv("MAIL_SMTP_STARTTLS"));
        putIfPresent("mail.smtp.auth", System.getenv("MAIL_SMTP_AUTH"));
        putIfPresent("mail.from", System.getenv("MAIL_FROM"));
        // Default TLS/auth if host present
        props.putIfAbsent("mail.smtp.auth", "true");
        props.putIfAbsent("mail.smtp.starttls.enable", "true");
    }

    private void putIfPresent(String key, String val) {
        if (val != null && !val.isBlank()) props.put(key, val);
    }

    private boolean hasText(String s) { return s != null && !s.trim().isEmpty(); }

    public void sendWelcomeEmail(String to, String username) {
        if (!enabled) {
            System.out.println("EmailService disabled or missing SMTP config; skip sending welcome email.");
            return;
        }
        String subject = "Welcome to BeatFlow";
        String body = "Hi " + Optional.ofNullable(username).orElse("there") + ",\n\n"
                + "Thanks for signing up for BeatFlow! You can now upload tracks, create playlists, and follow friends.\n\n"
                + "Happy listening!\nBeatFlow Team";
        send(to, subject, body);
    }

    public void send(String to, String subject, String textBody) {
        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(props.getProperty("mail.smtp.user"), props.getProperty("mail.smtp.password"));
                }
            });
            // Bật debug nếu đặt mail.debug=true để xem log SMTP trên server
            session.setDebug(Boolean.parseBoolean(props.getProperty("mail.debug", "false")));
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            message.setSubject(subject);
            message.setText(textBody);
            Transport.send(message);
            System.out.println("Email sent to " + to);
        } catch (MessagingException e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
