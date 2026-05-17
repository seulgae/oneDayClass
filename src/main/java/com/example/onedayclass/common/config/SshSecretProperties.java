package com.example.onedayclass.common.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "app.ssh")
public class SshSecretProperties {

    /*
     * application.properties 사용 예시:
     *
     * app.ssh.host=example.com
     * app.ssh.port=22
     * app.ssh.username=deploy
     * app.ssh.password=ENC(암호화된_SSH_비밀번호)
     *
     * 이 클래스에 바인딩되는 password 값은 ENC(...) 문자열이 아니라
     * Jasypt가 복호화한 실제 비밀번호입니다.
     *
     * 주의:
     * - 이 값을 로그로 출력하지 마세요.
     * - 운영 서버 로그인용 SSH 비밀번호는 애플리케이션 설정에 넣지 않는 편이 안전합니다.
     * - 애플리케이션이 다른 서버로 SSH 접속해야 하는 경우에만 이런 식으로 주입해서 사용하세요.
     */

    private String host;
    private int port = 22;
    private String username;
    private String password;

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public int getPort() {
        return port;
    }

    public void setPort(int port) {
        this.port = port;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
