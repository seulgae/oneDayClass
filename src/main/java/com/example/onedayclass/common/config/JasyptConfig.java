package com.example.onedayclass.common.config;

import org.jasypt.encryption.StringEncryptor;
import org.jasypt.encryption.pbe.PooledPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;

@Configuration
public class JasyptConfig {

    /*
     * Jasypt Spring Boot starter가 ENC(...) 값을 복호화할 때 사용하는 encryptor입니다.
     *
     * 사용 방법:
     * 1. application.properties에는 평문 대신 ENC(암호문)을 넣습니다.
     *    예) spring.datasource.password=ENC(xxxxx)
     *    예) app.ssh.password=ENC(yyyyy)
     *
     * 2. 마스터키는 application.properties에 저장하지 않습니다.
     *    실행 시 JVM 속성으로만 전달합니다.
     *    예) java -Djasypt.encryptor.password=마스터키 -jar target/oneDayClass-0.0.1-SNAPSHOT.jar
     *
     * 3. Maven으로 암호문을 만들 때도 같은 마스터키와 같은 알고리즘을 사용합니다.
     *    예) mvn jasypt:encrypt-value "-Djasypt.encryptor.password=마스터키" "-Djasypt.plugin.value=암호화할평문"
     */
    @Bean("jasyptStringEncryptor")
    public StringEncryptor jasyptStringEncryptor(
            @Value("${jasypt.encryptor.password:}") String password,
            @Value("${jasypt.encryptor.algorithm:PBEWITHHMACSHA512ANDAES_256}") String algorithm,
            @Value("${jasypt.encryptor.key-obtention-iterations:1000}") String keyObtentionIterations,
            @Value("${jasypt.encryptor.pool-size:1}") String poolSize,
            @Value("${jasypt.encryptor.provider-name:SunJCE}") String providerName,
            @Value("${jasypt.encryptor.salt-generator-classname:org.jasypt.salt.RandomSaltGenerator}") String saltGeneratorClassName,
            @Value("${jasypt.encryptor.iv-generator-classname:org.jasypt.iv.RandomIvGenerator}") String ivGeneratorClassName,
            @Value("${jasypt.encryptor.string-output-type:base64}") String stringOutputType) {

        if (!StringUtils.hasText(password)) {
            return new MissingPasswordStringEncryptor();
        }

        SimpleStringPBEConfig config = new SimpleStringPBEConfig();
        config.setPassword(password);
        config.setAlgorithm(algorithm);
        config.setKeyObtentionIterations(keyObtentionIterations);
        config.setPoolSize(poolSize);
        config.setProviderName(providerName);
        config.setSaltGeneratorClassName(saltGeneratorClassName);
        config.setIvGeneratorClassName(ivGeneratorClassName);
        config.setStringOutputType(stringOutputType);

        PooledPBEStringEncryptor encryptor = new PooledPBEStringEncryptor();
        encryptor.setConfig(config);
        return encryptor;
    }

    private static class MissingPasswordStringEncryptor implements StringEncryptor {

        @Override
        public String encrypt(String message) {
            throw missingPasswordException();
        }

        @Override
        public String decrypt(String encryptedMessage) {
            throw missingPasswordException();
        }

        private IllegalStateException missingPasswordException() {
            return new IllegalStateException(
                    "jasypt.encryptor.password JVM 속성이 필요합니다. "
                            + "예: -Djasypt.encryptor.password=마스터키");
        }
    }
}
