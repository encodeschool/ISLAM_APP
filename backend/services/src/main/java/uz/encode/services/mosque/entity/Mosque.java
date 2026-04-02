package uz.encode.services.mosque.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "mosques")
@Getter @Setter @Builder @NoArgsConstructor @AllArgsConstructor
public class Mosque {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String address;
    private String city;
    private String country;
    private String phone;
    private String email;
    private String website;

    @Column(columnDefinition = "TEXT")
    private String description;

    private String logoUrl;
    private String imageUrl;

    @Column(nullable = false)
    private boolean active = true;

    @Builder.Default
    private LocalDateTime createdAt = LocalDateTime.now();

    private LocalDateTime updatedAt;
}
