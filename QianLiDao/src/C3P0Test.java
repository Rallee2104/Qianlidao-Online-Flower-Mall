import com.mchange.v2.c3p0.ComboPooledDataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class C3P0Test {
    public static void main(String[] args) {
        // 创建c3p0连接池实例
        ComboPooledDataSource cpds = new ComboPooledDataSource();

        try {
            // 设置JDBC驱动的全类名
            cpds.setDriverClass("com.mysql.jdbc.Driver");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error setting the driver class.");
            return;
        }

        // 配置连接池属性，这些属性应该与您的c3p0配置文件中的设置相匹配
        cpds.setJdbcUrl("jdbc:mysql://8.134.190.116:3306/goods?useUnicode=true&characterEncoding=UTF8&useServerPrepStmts=true&prepStmtCacheSqlLimit=256&cachePrepStmts=true&prepStmtCacheSize=256&rewriteBatchedStatements=true&useSSL=false");
        cpds.setUser("root"); // 数据库用户名
        cpds.setPassword("l1w2k3w4c"); // 数据库密码

        // 可以设置其他连接池配置参数，如下：
        // 连接池中保留的最小连接数
        cpds.setMinPoolSize(5);

// 连接池中保留的最大连接数
        cpds.setMaxPoolSize(20);

// 当连接池中的连接用完时，C3P0一次性创建新连接的数目
        cpds.setAcquireIncrement(5);

// 定义在从数据库获取新连接失败后重复尝试的次数，默认为30
        cpds.setAcquireRetryAttempts(5);

// 两次连接中间隔时间，单位毫秒，默认为1000
        cpds.setAcquireRetryDelay(1000);

// 连接的最大空闲时间，超过空闲时间的连接将被丢弃，单位秒，默认为0，表示无限制
        cpds.setMaxIdleTime(300);

// 获取连接的最大等待时间，超过该时间未获得可用连接，则会抛出 SQLException，单位毫秒，默认为0，表示无限制
        cpds.setCheckoutTimeout(5000);


        Connection conn = null;
        try {
            // 尝试从连接池获取连接
            conn = cpds.getConnection();
            if (conn != null) {
                System.out.println("Successfully connected to the database!");
            } else {
                System.out.println("Failed to connect to the database.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("SQLException: " + e.getMessage());
        } finally {
            // 确保在完成后关闭连接
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

