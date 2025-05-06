import java.sql.Connection;
import java.sql.DriverManager;

public class test {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/gaming_gear?useSSL=false&allowPublicKeyRetrieval=true";
        String user = "root";
        String password = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println(" Connection successful!");
            conn.close();
        } catch (Exception e) {
            System.out.println(" Connection failed! Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
