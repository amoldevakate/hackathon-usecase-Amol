# ==============================================
# Stage 1: Build stage
# ==============================================
FROM eclipse-temurin:21-jdk-alpine AS builder

# Install Maven
RUN apk add --no-cache maven

WORKDIR /build

# Copy pom.xml first for layer caching
COPY pom.xml .

# Download dependencies (cached layer)
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application (skip tests for CI speed; tests run separately)
RUN mvn clean package -DskipTests -B

# ==============================================
# Stage 2: Final production image
# ==============================================
FROM eclipse-temurin:21-jre-alpine AS runner

# Install dumb-init for proper PID 1 signal handling
RUN apk add --no-cache dumb-init

# Create non-root user for security
RUN addgroup -g 1001 -S javagroup && \
    adduser -S javauser -u 1001 -G javagroup

WORKDIR /app

# Copy the built JAR from builder stage
COPY --from=builder --chown=javauser:javagroup /build/target/order-service-0.0.1-SNAPSHOT.jar ./app.jar

# Switch to non-root user
USER javauser

# Expose application port
EXPOSE 8080

# Health check for Kubernetes liveness/readiness probes
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:8080/actuator/health || exit 1

# JVM tuning for containers
ENV JAVA_OPTS="-XX:+UseContainerSupport \
               -XX:MaxRAMPercentage=75.0 \
               -XX:InitialRAMPercentage=50.0 \
               -Djava.security.egd=file:/dev/./urandom \
               -Dspring.backgroundpreinitializer.ignore=true"

# Use dumb-init as entrypoint for proper signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["sh", "-c", "java $JAVA_OPTS -jar /app/app.jar"]
