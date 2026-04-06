package com.example.onedayclass.common.storage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.UncheckedIOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Objects;
import java.util.UUID;

@Service
public class FileStorageService {

    private final Path uploadRoot;

    public FileStorageService(@Value("${app.upload.dir:uploads}") String uploadDir) {
        this.uploadRoot = Paths.get(uploadDir).toAbsolutePath().normalize();
        try {
            Files.createDirectories(uploadRoot);
        } catch (IOException e) {
            throw new UncheckedIOException("Failed to initialize upload directory.", e);
        }
    }

    public String store(MultipartFile file, String directory) throws IOException {
        Path targetDirectory = resolveDirectory(directory);
        String originalName = StringUtils.cleanPath(Objects.requireNonNullElse(file.getOriginalFilename(), ""));
        String extension = "";
        int extensionIndex = originalName.lastIndexOf('.');
        if (extensionIndex >= 0) {
            extension = originalName.substring(extensionIndex);
        }
        String storedFileName = UUID.randomUUID() + extension;
        Files.copy(file.getInputStream(), targetDirectory.resolve(storedFileName), StandardCopyOption.REPLACE_EXISTING);
        return storedFileName;
    }

    public void delete(String directory, String storedFileName) throws IOException {
        if (!StringUtils.hasText(storedFileName)) {
            return;
        }
        Files.deleteIfExists(resolveDirectory(directory).resolve(storedFileName));
    }

    private Path resolveDirectory(String directory) throws IOException {
        Path targetDirectory = uploadRoot.resolve(directory).normalize();
        Files.createDirectories(targetDirectory);
        return targetDirectory;
    }
}
