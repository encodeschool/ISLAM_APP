# Architecture of the App

```bash
services
│
├── src/main/java/com/arabiclearning
│
│   ├── config
│   │     ├── SecurityConfig.java
│   │     ├── JwtAuthenticationFilter.java
│   │     ├── JwtService.java
│   │     └── CorsConfig.java
│
│   ├── auth
│   │     ├── controller
│   │     │      └── AuthController.java
│   │     ├── service
│   │     │      └── AuthService.java
│   │     ├── dto
│   │     │      ├── LoginRequest.java
│   │     │      ├── RegisterRequest.java
│   │     │      └── AuthResponse.java
│
│   ├── user
│   │     ├── controller
│   │     │      └── UserController.java
│   │     ├── service
│   │     │      └── UserService.java
│   │     ├── repository
│   │     │      └── UserRepository.java
│   │     └── entity
│   │            └── User.java
│
│   ├── course
│   │     ├── controller
│   │     │      └── CourseController.java
│   │     ├── service
│   │     │      └── CourseService.java
│   │     ├── repository
│   │     │      ├── CourseRepository.java
│   │     │      └── LessonRepository.java
│   │     └── entity
│   │            ├── Course.java
│   │            └── Lesson.java
│
│   ├── progress
│   │     ├── controller
│   │     │      └── ProgressController.java
│   │     ├── service
│   │     │      └── ProgressService.java
│   │     ├── repository
│   │     │      └── ProgressRepository.java
│   │     └── entity
│   │            └── Progress.java
│
│   ├── subscription
│   │     ├── controller
│   │     │      └── SubscriptionController.java
│   │     ├── service
│   │     │      └── SubscriptionService.java
│   │     ├── repository
│   │     │      └── SubscriptionRepository.java
│   │     └── entity
│   │            └── Subscription.java
│
│   ├── payment
│   │     ├── controller
│   │     │      └── PaymentController.java
│   │     ├── service
│   │     │      └── StripeService.java
│   │     └── dto
│   │            └── CheckoutRequest.java
│
│   ├── analytics
│   │     └── AnalyticsService.java
│
│   ├── common
│   │     ├── exception
│   │     │      ├── GlobalExceptionHandler.java
│   │     │      └── ApiException.java
│   │     ├── response
│   │     │      └── ApiResponse.java
│   │     └── util
│   │            └── DateUtils.java
│
│   └── ArabicLearningApplication.java
│
├── src/main/resources
│
│   ├── application.yml
│   └── db/migration
│         ├── V1__create_users.sql
│         ├── V2__create_courses.sql
│         ├── V3__create_lessons.sql
│         └── V4__create_subscriptions.sql
│
└── pom.xml
```
